class Invoice < ApplicationRecord
  belongs_to :customer, optional: true
  belongs_to :created_by_user, class_name: 'User', foreign_key: 'created_by', optional: true
  has_many :invoice_items, dependent: :destroy

  enum :status, { draft: 'draft', sent: 'sent', paid: 'paid', overdue: 'overdue', cancelled: 'cancelled' }
  enum :payment_status, { unpaid: 0, partially_paid: 1, fully_paid: 2 }

  validates :invoice_number, presence: true, uniqueness: true
  validates :total_amount, presence: true, numericality: { greater_than: 0 }
  validates :invoice_date, presence: true

  before_validation :generate_invoice_number, on: :create
  before_create :generate_share_token

  scope :for_month, ->(month, year) { where(invoice_date: Date.new(year, month).beginning_of_month..Date.new(year, month).end_of_month) }

  # Get customer display name (customer or walk-in from booking)
  def customer_display_name
    return customer.display_name if customer.present?

    # For walk-in customers, get name from related booking
    related_booking = Booking.find_by(invoice_number: invoice_number)
    return related_booking.customer_name if related_booking&.customer_name.present?

    'Walk-in Customer'
  end

  # Get customer address (customer or walk-in from booking)
  def customer_address
    return customer.address if customer&.address.present?

    # For walk-in customers, get address from related booking
    related_booking = Booking.find_by(invoice_number: invoice_number)
    return related_booking.delivery_address if related_booking&.delivery_address.present?

    'Walk-in Address'
  end

  # Get customer mobile (customer or walk-in from booking)
  def customer_mobile
    return customer.mobile if customer&.mobile.present?

    # For walk-in customers, get mobile from related booking
    related_booking = Booking.find_by(invoice_number: invoice_number)
    return related_booking.customer_phone if related_booking&.customer_phone.present?

    nil
  end

  def generate_share_token!
    self.share_token = SecureRandom.urlsafe_base64(32)
    save!
  end

  def formatted_number
    invoice_number
  end

  def customer_name
    "#{customer&.first_name} #{customer&.last_name}".strip
  end

  def customer_phone
    customer&.mobile
  end

  def customer_email
    customer&.email
  end

  def overdue?
    due_date && due_date < Date.current && payment_status != 'fully_paid'
  end

  private

  def generate_invoice_number
    return if invoice_number.present?

    # Get the month from invoice_date or current date
    invoice_month = (invoice_date || Date.current).month
    month_prefix = invoice_month.to_s.rjust(2, '0')

    # Get the next invoice number for this month
    last_invoice = Invoice.where("invoice_number LIKE ?", "INV-#{month_prefix}-%")
                         .order(created_at: :desc)
                         .first

    if last_invoice
      # Extract the number part and increment
      last_number = last_invoice.invoice_number.split('-').last.to_i
      next_number = (last_number + 1).to_s.rjust(5, '0')
    else
      # Start from 00001 for this month
      next_number = '00001'
    end

    self.invoice_number = "INV-#{month_prefix}-#{next_number}"
  end

  # Helper method to generate month-based invoice number for specific month
  def self.generate_invoice_number_for_month(month)
    month_prefix = month.to_s.rjust(2, '0')

    last_invoice = where("invoice_number LIKE ?", "INV-#{month_prefix}-%")
                   .order(created_at: :desc)
                   .first

    if last_invoice
      last_number = last_invoice.invoice_number.split('-').last.to_i
      next_number = (last_number + 1).to_s.rjust(5, '0')
    else
      next_number = '00001'
    end

    "INV-#{month_prefix}-#{next_number}"
  end

  def generate_share_token
    return if share_token.present?
    self.share_token = SecureRandom.urlsafe_base64(32)
  end
end
