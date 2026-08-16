# Public order tracking — no authentication required. Mirrors the pattern
# used by BookingInvoicesController#public_view for public-facing pages:
# a bare ActionController::Base with its own layout, so it never depends on
# admin/customer session state.
class OrderTrackingController < ActionController::Base
  layout false
  protect_from_forgery with: :exception

  # Linear happy-path steps shown on the progress tracker. `draft` clamps to
  # the first step; `completed` clamps to the last. `cancelled`/`returned`
  # are handled separately as a banner instead of a step position.
  STEPS = [
    { key: 'ordered_and_delivery_pending', label: 'Order Placed',   icon: '🧾' },
    { key: 'confirmed',                    label: 'Confirmed',      icon: '✅' },
    { key: 'processing',                   label: 'Processing',     icon: '⚙️' },
    { key: 'packed',                       label: 'Packed',         icon: '📦' },
    { key: 'shipped',                      label: 'Shipped',        icon: '🚚' },
    { key: 'out_for_delivery',             label: 'Out for Delivery', icon: '🛵' },
    { key: 'delivered',                    label: 'Delivered',      icon: '🏠' }
  ].freeze
  STEP_KEYS = STEPS.map { |s| s[:key] }.freeze

  def index
    query = params[:booking_number].to_s.strip
    redirect_to track_order_show_path(booking_number: query) and return if query.present?

    @business_settings = SystemSetting.business_settings
  end

  def show
    query = params[:booking_number].to_s.strip
    @searched_number = query
    @business_settings = SystemSetting.business_settings

    if query.blank?
      redirect_to track_order_path and return
    end

    @booking = Booking.includes(booking_items: :product)
                       .find_by('booking_number ILIKE ?', query)

    if @booking.nil?
      @not_found = true
      render :index and return
    end

    @booking_items = @booking.booking_items
    @invoice = @booking.invoice_number.present? ? BookingInvoice.find_by(invoice_number: @booking.invoice_number) : nil

    @terminal_state =
      if @booking.status == 'cancelled'
        :cancelled
      elsif @booking.status == 'returned'
        :returned
      end

    @steps = STEPS
    raw_index = STEP_KEYS.index(@booking.status)
    @current_step_index =
      if raw_index
        raw_index
      elsif @booking.status == 'completed'
        STEP_KEYS.length - 1
      else
        0 # draft or any unmapped pre-processing status
      end
  end
end
