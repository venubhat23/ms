class Report < ApplicationRecord
  validates :name, presence: true
  validates :report_type, presence: true

  enum :report_type, {
    commission: 'commission',
    expired_insurance: 'expired_insurance',
    payment_due: 'payment_due',
    upcoming_renewal: 'upcoming_renewal',
    upcoming_payment: 'upcoming_payment',
    leads: 'leads',
    sessions: 'sessions'
  }

  scope :active, -> { where(status: true) }
  scope :recent, -> { order(created_at: :desc) }
end