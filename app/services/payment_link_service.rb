# Shareable "pay this booking" links (Admin > Bookings > Payment link, sent
# over WhatsApp). The link carries a signed token holding the booking id and
# the amount the admin asked for, so the customer can't change either.
#
# Paying it marks the booking's payment_status 'paid' (the same flag as
# "Mark as Paid" on manage_stage) WITHOUT touching the order status — unlike
# Booking#mark_payment_completed!, which is for checkout and resets status to
# confirmed. Payment is only trusted after asking Cashfree for the order
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

    # Creates a fresh Cashfree order for this attempt. `return_to` may contain
    # "{order_id}", filled in with the new order id.
    # => { success: true, payment_session_id:, order_id: } | { success: false, message: }
    def start(booking, amount, return_to:)
      order_id = "#{ORDER_PREFIX}_#{booking.id}_#{Time.current.strftime('%y%m%d%H%M%S')}_#{SecureRandom.hex(3).upcase}"
      response = CashfreeService.create_order(booking, amount: amount, order_id: order_id, return_to: return_to.sub("{order_id}", order_id))
      unless response[:success] && response.dig(:data, "payment_session_id").present?
        return { success: false, message: response[:message] || "Could not reach the payment gateway." }
      end

      booking.update_columns(cashfree_order_id: order_id, payment_session_id: response.dig(:data, "payment_session_id"),
                             payment_initiated_at: Time.current, updated_at: Time.current)
      { success: true, payment_session_id: response.dig(:data, "payment_session_id"), order_id: order_id }
    end

    def link_order?(order_id)
      order_id.to_s.match?(ORDER_ID_FORMAT)
    end

    # Asks Cashfree whether the order is paid and, if so, marks the booking
    # paid. Safe to call repeatedly (return page + webhook both do).
    # => :paid, :already_paid, :pending, :failed, :invalid
    def confirm(order_id)
      booking_id = order_id.to_s[ORDER_ID_FORMAT, 1]
      booking = booking_id && Booking.find_by(id: booking_id)
      return :invalid unless booking
      return :already_paid if booking.payment_status_paid?

      order = CashfreeService.get_order(order_id)
      return :pending unless order[:success]

      case order.dig(:data, "order_status")
      when "PAID"
        payment = successful_payment(order_id)
        marked = mark_paid(booking, order_id, order[:data], payment)
        marked ? :paid : :already_paid
      when "ACTIVE" then :pending
      else :failed
      end
    end

    private

    def successful_payment(order_id)
      response = CashfreeService.get_order_payments(order_id)
      payments = response[:success] ? Array(response[:data]) : []
      payments.find { |p| p["payment_status"] == "SUCCESS" } || {}
    end

    def mark_paid(booking, order_id, order, payment)
      booking.with_lock do
        return false if booking.payment_status_paid?

        method = payment["payment_group"].presence || payment["payment_method"]&.keys&.first
        booking.update!(
          payment_status: :paid,
          payment_completed_at: Time.current,
          payment_gateway: "cashfree",
          cashfree_order_id: order_id,
          cashfree_payment_id: payment["cf_payment_id"]&.to_s,
          gateway_response: {
            source: "payment_link", order_id: order_id, order_amount: order["order_amount"],
            cf_payment_id: payment["cf_payment_id"], payment_method: method,
            bank_reference: payment["bank_reference"], paid_at: Time.current
          }.to_json
        )
      end
      Rails.logger.info("[PaymentLink] booking #{booking.booking_number} marked paid via #{order_id}")
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
