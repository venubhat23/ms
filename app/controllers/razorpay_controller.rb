# Public on purpose: guests pay too, and Razorpay calls the webhook. Nothing
# here is trusted on its own; every path re-checks the order with Razorpay's
# API (RazorpayService#confirm) before anything is marked paid.
class RazorpayController < ActionController::Base
  skip_forgery_protection

  PAID_EVENTS = %w[payment.authorized payment.captured order.paid].freeze

  # POST /razorpay/verify — the popup's success handler.
  def verify
    order_id, payment_id, signature = params.values_at(:razorpay_order_id, :razorpay_payment_id, :razorpay_signature)

    if [order_id, payment_id, signature].any?(&:blank?)
      return render json: { success: false, message: 'Payment details are missing.' }, status: :bad_request
    end

    unless RazorpayService.valid_payment_signature?(order_id: order_id, payment_id: payment_id, signature: signature)
      Rails.logger.warn("[Razorpay] Bad payment signature for #{order_id}")
      return render json: { success: false, message: 'Payment could not be verified.' }, status: :bad_request
    end

    status = RazorpayService.confirm(order_id)
    render json: { success: %i[paid already_paid].include?(status), status: status }
  end

  # GET /razorpay/return?order_id= — where the browser lands after the popup.
  def finish
    booking = Booking.find_by(razorpay_order_id: params[:order_id])
    return redirect_to(root_path, alert: 'Order not found.') unless booking

    RazorpayService.confirm(params[:order_id])
    message = if booking.reload.payment_status_paid?
                { notice: "Payment successful! Your order ##{booking.booking_number} has been confirmed." }
              else
                { alert: 'Payment was not completed. If money left your account, it will update here shortly.' }
              end

    if booking.booked_by == 'public'
      redirect_to confirmation_storefront_checkout_path(booking_id: booking.id), message
    else
      redirect_to customer_order_path(booking), message
    end
  end

  # POST /razorpay/webhook — catches payments whose browser never came back.
  def webhook
    body = request.raw_post
    unless RazorpayService.valid_webhook_signature?(body, request.headers['X-Razorpay-Signature'])
      Rails.logger.warn('[Razorpay] Rejected webhook with a bad signature')
      return head :unauthorized
    end

    payload = JSON.parse(body)
    return head :ok unless PAID_EVENTS.include?(payload['event'])

    order_id = payload.dig('payload', 'payment', 'entity', 'order_id') || payload.dig('payload', 'order', 'entity', 'id')
    return head :ok if order_id.blank?

    # A non-2xx makes Razorpay retry, which is what we want if its API was down.
    head(RazorpayService.confirm(order_id) == :error ? :service_unavailable : :ok)
  rescue JSON::ParserError
    head :bad_request
  end
end
