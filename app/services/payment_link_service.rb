# Shareable "pay this booking" links (Admin > Bookings > Payment link, sent
# over WhatsApp). The link carries a signed token holding the booking id and
# the amount the admin asked for, so the customer can't change either.
#
# Paying it marks the booking's payment_status 'paid' (the same flag as
# "Mark as Paid" on manage_stage) WITHOUT touching the order status — unlike
# Booking#mark_payment_completed!, which is for checkout and resets status to
# confirmed. Payment is only trusted after asking Razorpay for the order
# status server side, whether the trigger is the customer's return redirect
# or the webhook.
class PaymentLinkService
  ORDER_PREFIX = "MKSPL".freeze
  ORDER_ID_FORMAT = /\AMKSPL_(\d+)_/

  class << self
    def token_for(booking, amount)
      verifier.generate({ "b" => booking.id, "a" => format("%.2f", amount.to_d) }, purpose: :payment_link)
    end

    # => [booking, amount] or nil when the token is forged / malformed.
    def resolve(token)
      data = verifier.verified(token.to_s, purpose: :payment_link)
      return unless data.is_a?(Hash)

      booking = Booking.find_by(id: data["b"])
      amount = data["a"].to_d
      [booking, amount] if booking && amount.positive?
    rescue ArgumentError
      nil
    end

    def default_amount(booking)
      booking.total_amount.to_d.round(2)
    end

    def payable?(booking)
      !booking.payment_status_paid? && !%w[cancelled returned].include?(booking.status)
    end

    # Creates a fresh Razorpay order for this attempt. Razorpay picks the order
    # id, so the MKSPL_ marker that identifies a link order goes in the receipt.
    # `return_to` may contain "{order_id}", filled in with the new order id.
    # => { success: true, checkout:, order_id: } | { success: false, message: }
    def start(booking, amount, return_to:)
      receipt = "#{ORDER_PREFIX}_#{booking.id}_#{Time.current.strftime('%y%m%d%H%M%S')}_#{SecureRandom.hex(3).upcase}"
      response = RazorpayService.create_order(booking, amount: amount, receipt: receipt)
      return { success: false, message: response[:message] || "Could not reach the payment gateway." } unless response[:success]

      order = response[:data]
      booking.update_columns(razorpay_order_id: order["id"], payment_initiated_at: Time.current, updated_at: Time.current)
      checkout = RazorpayService.checkout_payload(booking, order, return_url: return_to.sub("{order_id}", order["id"]))
      { success: true, checkout: checkout, order_id: order["id"] }
    end

    def link_order?(receipt)
      receipt.to_s.match?(ORDER_ID_FORMAT)
    end

    # Marks the booking paid from a settled order (RazorpayService#settle).
    # Called for link orders only, by RazorpayService#confirm, which the return
    # page and the webhook both go through.
    # => :paid, :already_paid, :pending, :failed, :invalid
    def record(order, settled)
      booking = Booking.find_by(id: order["receipt"].to_s[ORDER_ID_FORMAT, 1])
      return :invalid unless booking
      return :already_paid if booking.payment_status_paid?
      return settled[:status] unless settled[:status] == :paid

      mark_paid(booking, order, settled[:payment]) ? :paid : :already_paid
    end

    private

    def mark_paid(booking, order, payment)
      booking.with_lock do
        return false if booking.payment_status_paid?

        booking.update!(
          payment_status: :paid,
          payment_completed_at: Time.current,
          payment_gateway: "razorpay",
          razorpay_order_id: order["id"],
          razorpay_payment_id: payment["id"],
          gateway_response: {
            source: "payment_link", order_id: order["id"], order_amount: order["amount"].to_i / 100.0,
            razorpay_payment_id: payment["id"], payment_method: payment["method"], paid_at: Time.current
          }.to_json
        )
      end
      Rails.logger.info("[PaymentLink] booking #{booking.booking_number} marked paid via #{order['id']}")
      true
    end

    def verifier
      @verifier ||= ActiveSupport::MessageVerifier.new(
        Rails.application.key_generator.generate_key("booking_payment_link"),
        digest: "SHA256", serializer: JSON, url_safe: true
      )
    end
  end
end
