module Admin::BookingsHelper
  include GstCalculatorHelper

  # wa.me link carrying a "payment received, thank you" note to a paid
  # booking's customer, or nil when there's no usable mobile number.
  # Plain text on purpose: emojis arrive garbled through wa.me.
  def booking_payment_thanks_whatsapp_url(booking)
    digits = (booking.customer&.mobile || booking.customer_phone).to_s.gsub(/\D/, '').sub(/^0+/, '')
    digits = digits.delete_prefix('91') if digits.length == 12
    return nil unless digits.length == 10

    name = booking.customer&.display_name.presence || booking.customer_name.presence || 'Customer'
    reference = booking.display_invoice_number.presence || booking.booking_number
    received_on = (booking.payment_completed_at || booking.updated_at || Time.current).in_time_zone.strftime('%d-%b-%Y')
    store = SystemSetting.business_settings&.business_name.presence || 'Marali Santhe'

    lines = ["Dear #{name},", '',
             "Payment-in(number: #{reference}) of Rs. #{format('%.2f', booking.total_amount.to_f)} has been received from you on #{received_on}",
             '', 'Thank you for your business.', '', store]

    "https://wa.me/91#{digits}?text=#{ERB::Util.url_encode(lines.join("\n"))}"
  end
end
