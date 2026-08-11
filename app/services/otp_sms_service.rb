class OtpSmsService
  include HTTParty

  base_uri 'https://control.msg91.com/api/v5'
  headers 'Content-Type' => 'application/json'

  class << self
    def auth_key
      Rails.application.credentials.dig(:msg91, :auth_key) || ENV['MSG91_AUTH_KEY']
    end

    def sender_id
      Rails.application.credentials.dig(:msg91, :sender_id) || ENV['MSG91_SENDER_ID']
    end

    def otp_template_id
      Rails.application.credentials.dig(:msg91, :otp_template_id) || ENV['MSG91_OTP_TEMPLATE_ID']
    end

    def configured?
      auth_key.present? && sender_id.present? && otp_template_id.present?
    end

    # Sends `otp_code` to `mobile` (10-digit, no country code) via MSG91's
    # DLT-registered OTP template. Falls back to logging the code instead of
    # sending in non-production environments when MSG91 isn't configured yet,
    # so the OTP login flow can be exercised end-to-end before DLT/MSG91
    # registration is complete.
    def send_otp(mobile, otp_code)
      unless configured?
        if Rails.env.production?
          Rails.logger.error 'OtpSmsService: MSG91 credentials missing, cannot send OTP in production'
          return { success: false, error: 'SMS provider not configured' }
        end

        Rails.logger.info "OtpSmsService (dev fallback, no MSG91 credentials): OTP for #{mobile} is #{otp_code}"
        return { success: true, dev_fallback: true }
      end

      response = post('/otp', body: {
        template_id: otp_template_id,
        mobile: "91#{mobile}",
        authkey: auth_key,
        otp: otp_code,
        sender: sender_id
      }.to_json)

      if response.success? && response.parsed_response['type'] == 'success'
        { success: true }
      else
        Rails.logger.error "OtpSmsService: MSG91 send failed: #{response.body}"
        { success: false, error: 'Failed to send OTP' }
      end
    rescue => e
      Rails.logger.error "OtpSmsService: MSG91 request error: #{e.message}"
      { success: false, error: 'Failed to send OTP' }
    end
  end
end
