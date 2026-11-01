module Admin::BookingsHelper
  include GstCalculatorHelper

  # wa.me link carrying a "payment received, thank you" note to the booking's
  # customer, or nil when there's no usable mobile number.
  # Plain text on purpose: emojis arrive garbled through wa.me.
  def booking_payment_thanks_whatsapp_url(booking)
    digits = (booking.customer&.mobile || booking.customer_phone).to_s.gsub(/\D/, '').sub(/^0+/, '')
    digits = digits.delete_prefix('91') if digits.length == 12
    return nil unless digits.length == 10

    "https://wa.me/91#{digits}?text=#{ERB::Util.url_encode(booking_payment_thanks_message(booking))}"
  end

  # The one WhatsApp thank-you text used by every "Thanks" button (client's
  # "Payment-in" receipt wording). An unpaid booking quotes its booking total.
  def booking_payment_thanks_message(booking)
    name = booking.customer&.display_name.presence || booking.customer_name.presence || 'Customer'
    store = SystemSetting.business_settings&.business_name.presence || 'Marali Santhe'
    amount = format('%.2f', booking.total_amount.to_f)

    headline =
      if booking.payment_status_paid?
        invoice_number = booking.display_invoice_number.presence
        ref = invoice_number ? "Invoice number: #{invoice_number}" : "Booking number: #{booking.booking_number}"
        received_on = (booking.payment_completed_at || booking.updated_at || Time.current).in_time_zone.strftime('%d-%b-%Y')
        "Payment (#{ref}) of Rs. #{amount} has been received from you on #{received_on}"
      else
        booked_on = (booking.booking_date.presence || booking.created_at || Time.current).in_time_zone.strftime('%d-%b-%Y')
        "Booking(number: #{booking.booking_number}) of Rs. #{amount} has been received from you on #{booked_on}"
      end

    ["Dear #{name},", '', headline, '',
     'Thank you for your business. We appreciate your trust in us!', '', store].join("\n")
  end
end
