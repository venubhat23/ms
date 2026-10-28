# Railway (non-Pro) blocks outbound SMTP, so mail can instead be POSTed over
# HTTPS to a Google Apps Script web app that sends it from the Gmail account
# with MailApp. Active only when MAIL_WEBHOOK_URL is set; otherwise the
# environment's normal delivery_method (SMTP) is used.
require 'net/http'

class MailWebhookDelivery
  def initialize(settings)
    @url = settings[:url]
    @secret = settings[:secret]
  end

  def deliver!(mail)
    html = mail.html_part&.decoded || (mail.mime_type == 'text/html' ? mail.decoded : nil)
    text = mail.text_part&.decoded || (mail.multipart? ? nil : mail.decoded)

    payload = {
      secret: @secret,
      to: Array(mail.to).join(','),
      cc: Array(mail.cc).join(','),
      bcc: Array(mail.bcc).join(','),
      subject: mail.subject,
      html: html,
      text: text.to_s,
      from_name: 'Marali Santhe'
    }

    # Apps Script answers the POST with a 302 to the result; following it
    # with a GET returns the script's JSON.
    response = HTTParty.post(@url, body: payload.to_json,
                                   headers: { 'Content-Type' => 'application/json' },
                                   timeout: 15)
    result = JSON.parse(response.body) rescue nil
    unless result.is_a?(Hash) && result['ok']
      raise "Mail webhook failed (HTTP #{response.code}): #{response.body.to_s[0, 200]}"
    end
  end
end

ActiveSupport.on_load(:action_mailer) do
  add_delivery_method :webhook, MailWebhookDelivery,
                      url: ENV['MAIL_WEBHOOK_URL'], secret: ENV['MAIL_WEBHOOK_SECRET']

  self.delivery_method = :webhook if ENV['MAIL_WEBHOOK_URL'].present?
end
