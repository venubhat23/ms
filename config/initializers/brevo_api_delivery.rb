# Railway (non-Pro) blocks outbound SMTP, so mail can instead be sent through
# Brevo's transactional email HTTP API. Active only when BREVO_API_KEY is set
# (takes precedence over MAIL_WEBHOOK_URL); otherwise the other delivery
# methods apply.
class BrevoApiDelivery
  ENDPOINT = 'https://api.brevo.com/v3/smtp/email'.freeze

  def initialize(settings)
    @api_key = settings[:api_key]
    @sender_email = settings[:sender_email]
    @sender_name = settings[:sender_name]
  end

  def deliver!(mail)
    html = mail.html_part&.decoded || (mail.mime_type == 'text/html' ? mail.decoded : nil)
    text = mail.text_part&.decoded || (mail.multipart? ? nil : mail.decoded)

    payload = {
      sender: { name: @sender_name, email: @sender_email },
      to: Array(mail.to).map { |e| { email: e } },
      subject: mail.subject
    }
    payload[:cc] = Array(mail.cc).map { |e| { email: e } } if mail.cc.present?
    payload[:bcc] = Array(mail.bcc).map { |e| { email: e } } if mail.bcc.present?
    payload[:htmlContent] = html if html.present?
    payload[:textContent] = text if text.present?
    payload[:textContent] = ' ' if html.blank? && text.blank?

    response = HTTParty.post(ENDPOINT, body: payload.to_json,
                                       headers: { 'api-key' => @api_key,
                                                  'Content-Type' => 'application/json',
                                                  'Accept' => 'application/json' },
                                       timeout: 15)
    unless response.code.between?(200, 299)
      raise "Brevo API failed (HTTP #{response.code}): #{response.body.to_s[0, 300]}"
    end
  end
end

ActiveSupport.on_load(:action_mailer) do
  add_delivery_method :brevo, BrevoApiDelivery,
                      api_key: ENV['BREVO_API_KEY'],
                      sender_email: ENV.fetch('BREVO_SENDER_EMAIL', 'maralisanthe@gmail.com'),
                      sender_name: ENV.fetch('BREVO_SENDER_NAME', 'Marali Santhe')

  self.delivery_method = :brevo if ENV['BREVO_API_KEY'].present?
end
