# Razorpay Standard Checkout: the server creates an order, the browser opens
# Razorpay's popup, and a payment only counts once Razorpay's API confirms it
# here. The popup's signature, the return page and the webhook all end up in
# #confirm, so whichever arrives first does the work and the rest are no-ops.
#
# Keys are entered on Admin > Settings > System > Payment Gateway.
class RazorpayService
  include HTTParty

  base_uri 'https://api.razorpay.com/v1'
  default_timeout 15

  CURRENCY = 'INR'.freeze
  MIN_AMOUNT_PAISE = 100

  class << self
    def key_id
      SystemSetting.razorpay_key_id
    end

    # Whether Razorpay accepts the saved Key ID and Key Secret as a pair.
    def credentials_valid?
      request(:get, '/orders?count=1')[:success]
    end

    # Creates the gateway order for a checkout and records it on the booking.
    # => { success: true, checkout: {...} } | { success: false, message: }
    def start_checkout(booking)
      response = create_order(booking)
      return response unless response[:success]

      order = response[:data]
      booking.update!(
        razorpay_order_id: order['id'],
        payment_gateway: 'razorpay',
        payment_initiated_at: Time.current,
        payment_status: 'unpaid'
      )
      return_url = Rails.application.routes.url_helpers.razorpay_return_path(order_id: order['id'])
      { success: true, checkout: checkout_payload(booking, order, return_url: return_url) }
    end

    # Optional overrides are used by booking payment links (PaymentLinkService).
    def create_order(booking, amount: nil, receipt: nil, notes: {})
      paise = ((amount || booking.total_amount).to_d * 100).round.to_i
      return { success: false, message: 'Online payment needs an amount of at least ₹1.' } if paise < MIN_AMOUNT_PAISE

      request(:post, '/orders', amount: paise, currency: CURRENCY, receipt: receipt || booking.booking_number,
                                notes: { booking_id: booking.id.to_s, booking_number: booking.booking_number }.merge(notes))
    end

    # What the browser needs to open the popup. Never includes the key secret.
    def checkout_payload(booking, order, return_url:)
      customer = booking.customer
      email = customer&.email.presence || booking.customer_email
      {
        key: key_id,
        order_id: order['id'],
        amount: order['amount'],
        currency: order['currency'],
        name: SystemSetting.business_settings&.business_name.presence || 'Marali Santhe',
        description: "Order #{booking.booking_number}",
        return_url: return_url,
        prefill: {
          name: customer&.display_name.presence || booking.customer_name,
          # Mobile-only signups hold a placeholder address nobody can receive at.
          email: email.to_s.end_with?('.invalid') ? nil : email,
          contact: customer&.mobile.presence || booking.customer_phone
        }.compact
      }
    end

    # Asks Razorpay whether the order is paid and records it on the booking.
    # Safe to call repeatedly.
    # => :paid, :already_paid, :pending, :failed, :invalid, :error (API unreachable)
    def confirm(order_id)
      settled = settle(order_id)
      return :error if settled[:status] == :error

      order = settled[:order]
      return PaymentLinkService.record(order, settled) if PaymentLinkService.link_order?(order['receipt'])

      booking = Booking.find_by(razorpay_order_id: order_id)
      return :invalid unless booking
      return settled[:status] unless settled[:status] == :paid

      payment = settled[:payment]
      booking.with_lock do
        next :already_paid if booking.payment_status_paid?

        booking.mark_payment_completed!(
          razorpay_payment_id: payment['id'],
          payment_method: 'razorpay',
          method: payment['method'],
          order_status: order['status'],
          payment_amount: order['amount'].to_i / 100.0
        )
        :paid
      end
    end

    # The order's state according to Razorpay. Captures a payment left
    # authorized by the account's capture setting; Razorpay refunds those if
    # they are not captured, and the customer has already paid.
    # => { status: :paid/:failed/:pending, order:, payment: } | { status: :error }
    def settle(order_id)
      order = request(:get, "/orders/#{order_id}")
      payments = request(:get, "/orders/#{order_id}/payments")
      return { status: :error } unless order[:success] && payments[:success]

      items = Array(payments[:data]['items'])
      paid = order[:data]['status'] == 'paid'
      payment = items.find { |item| item['status'] == 'captured' }

      if !paid && !payment && (authorized = items.find { |item| item['status'] == 'authorized' })
        captured = request(:post, "/payments/#{authorized['id']}/capture",
                           amount: authorized['amount'], currency: authorized['currency'])
        return { status: :error } unless captured[:success]

        payment = captured[:data]
      end

      status = if paid || payment then :paid
               elsif items.any? && items.all? { |item| item['status'] == 'failed' } then :failed
               else :pending
               end
      { status: status, order: order[:data], payment: payment || {} }
    end

    # HMAC-SHA256 of "order_id|payment_id", signed with the key secret.
    def valid_payment_signature?(order_id:, payment_id:, signature:)
      return false if key_secret.blank?

      matches?(OpenSSL::HMAC.hexdigest('SHA256', key_secret, "#{order_id}|#{payment_id}"), signature)
    end

    def valid_webhook_signature?(body, signature)
      secret = SystemSetting.razorpay_webhook_secret
      return false if secret.blank?

      matches?(OpenSSL::HMAC.hexdigest('SHA256', secret, body), signature)
    end

    private

    def key_secret
      SystemSetting.razorpay_key_secret
    end

    def matches?(expected, given)
      ActiveSupport::SecurityUtils.secure_compare(expected, given.to_s)
    end

    def request(verb, path, body = nil)
      username = key_id
      password = key_secret
      if username.blank? || password.blank?
        Rails.logger.error('[Razorpay] Keys are not set in System Settings')
        return { success: false, message: 'Online payment is unavailable right now.' }
      end

      options = { basic_auth: { username: username, password: password } }
      options.merge!(headers: { 'Content-Type' => 'application/json' }, body: body.to_json) if body
      handle_response(public_send(verb, path, options))
    rescue HTTParty::Error, SocketError, SystemCallError, Timeout::Error, OpenSSL::SSL::SSLError => e
      Rails.logger.error("[Razorpay] #{verb} #{path} failed: #{e.class}: #{e.message}")
      { success: false, message: 'Could not reach the payment gateway. Please try again.' }
    end

    def handle_response(response)
      return { success: true, data: response.parsed_response } if response.success?

      message = response.parsed_response.is_a?(Hash) ? response.parsed_response.dig('error', 'description') : nil
      Rails.logger.error("[Razorpay] HTTP #{response.code}: #{message}")
      user_message = response.code == 400 && message.present? ? message : 'Payment gateway error. Please try again.'
      { success: false, message: user_message, code: response.code }
    end
  end
end
