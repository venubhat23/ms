# Public "pay for your order" page behind a WhatsApp payment link
# (see PaymentLinkService). No login: the signed token in the URL is the
# authorisation. GET never talks to Cashfree (link previews hit it); the
# Pay button POSTs to start a gateway order.
class PaymentLinksController < ActionController::Base
  include TracksPageViews
  layout false

  before_action :load_link

  def show
    @items = @booking.booking_items.includes(:product, :product_variant).to_a if @booking
  end

  def create
    unless @booking && PaymentLinkService.payable?(@booking)
      render json: { success: false, already_paid: @booking&.payment_status_paid?, message: "This order no longer needs payment." }
      return
    end

    result = PaymentLinkService.start(@booking, @amount, return_to: "#{payment_link_url(params[:token])}/done?order_id={order_id}")
    if result[:success]
      render json: { success: true, payment_session_id: result[:payment_session_id], mode: CashfreeService.production_credentials? ? "production" : "sandbox" }
    else
      render json: { success: false, message: result[:message] }, status: :bad_gateway
    end
  end

  # Cashfree sends the customer back here after the attempt.
  def done
    @result =
      if @booking && params[:order_id].to_s.start_with?("#{PaymentLinkService::ORDER_PREFIX}_#{@booking.id}_")
        PaymentLinkService.confirm(params[:order_id])
      else
        :invalid
      end
    @booking&.reload
    render :show
  end

  private

  def load_link
    @booking, @amount = PaymentLinkService.resolve(params[:token])
    @business_settings = SystemSetting.business_settings
  end
end
