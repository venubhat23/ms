class Note < ApplicationRecord
  belongs_to :created_by_user, class_name: 'User', foreign_key: 'created_by_user_id'

  # Payment method options
  PAYMENT_METHODS = %w[UPI Cash Online Bank_Transfer Cheque Card].freeze

  # Status options
  STATUSES = %w[pending completed cancelled].freeze

  validates :title, presence: true, length: { maximum: 255 }
  validates :paid_to, presence: true, length: { maximum: 255 }
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :payment_method, presence: true, inclusion: { in: PAYMENT_METHODS }
  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :note_date, presence: true
  validates :description, length: { maximum: 1000 }
  validates :reference_number, length: { maximum: 100 }

  scope :recent, -> { order(created_at: :desc) }
  scope :by_status, ->(status) { where(status: status) if status.present? }
  scope :by_payment_method, ->(method) { where(payment_method: method) if method.present? }
  scope :by_date_range, ->(start_date, end_date) { where(note_date: start_date..end_date) if start_date && end_date }

  def display_amount
    "₹#{amount.to_f}"
  end

  def formatted_date
    note_date.strftime("%d %b %Y")
  end

  def status_badge_class
    case status
    when 'completed'
      'bg-success'
    when 'pending'
      'bg-warning'
    when 'cancelled'
      'bg-danger'
    else
      'bg-secondary'
    end
  end

  def payment_method_icon
    case payment_method
    when 'UPI'
      'bi-phone'
    when 'Cash'
      'bi-cash'
    when 'Online'
      'bi-globe'
    when 'Bank_Transfer'
      'bi-bank'
    when 'Cheque'
      'bi-journal-check'
    when 'Card'
      'bi-credit-card'
    else
      'bi-question-circle'
    end
  end
end