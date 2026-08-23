class FranchiseWithdrawalRequest < ApplicationRecord
  belongs_to :franchise
  belongs_to :approved_by_user, class_name: 'User', foreign_key: :approved_by_user_id, optional: true
  belongs_to :booking, optional: true # legacy single-booking tag, kept for old requests
  has_many :franchise_withdrawal_request_bookings, dependent: :destroy
  has_many :tagged_bookings, through: :franchise_withdrawal_request_bookings, source: :booking

  enum :status, { pending: 'pending', approved: 'approved', rejected: 'rejected', paid: 'paid' }

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :sufficient_wallet_balance, on: :create

  before_validation :set_requested_at, on: :create
  after_create :debit_wallet!

  scope :recent, -> { order(created_at: :desc) }

  def formatted_amount
    "₹#{amount.to_f.round(2)}"
  end

  # Legacy single `booking` plus the bulk-tagged `tagged_bookings`, deduped —
  # the full picture of what's tagged to this request.
  def all_tagged_bookings
    ([booking] + tagged_bookings.to_a).compact.uniq
  end

  def approve!(user)
    return false unless pending?
    update!(status: :approved, approved_at: Time.current, approved_by_user_id: user&.id)
  end

  # Reverses the hold placed on the wallet at request time.
  def reject!(user, reason = nil)
    return false unless pending?

    transaction do
      update!(status: :rejected, approved_by_user_id: user&.id, notes: [notes, reason].compact_blank.join("\n"))
      franchise.franchise_wallet.add_money(amount, "Withdrawal request ##{id} rejected — refunded", "WD-REFUND-#{id}")
    end

    true
  end

  def mark_paid!(payment_reference:)
    return false unless approved?
    update!(status: :paid, paid_at: Time.current, payment_reference: payment_reference)
  end

  private

  def set_requested_at
    self.requested_at ||= Time.current
  end

  def sufficient_wallet_balance
    wallet = franchise&.franchise_wallet
    if wallet.nil?
      errors.add(:amount, "franchise wallet not found")
    elsif amount.present? && amount > wallet.balance
      errors.add(:amount, "exceeds available wallet balance (#{wallet.formatted_balance})")
    end
  end

  # Funds are held immediately on request (not at approval) so the wallet
  # balance always reflects what's actually still available to request —
  # locks the wallet row to stay correct if two requests are submitted at
  # the same time.
  def debit_wallet!
    wallet = franchise.franchise_wallet.lock!
    raise "Insufficient franchise wallet balance" unless wallet.balance >= amount
    wallet.deduct_money(amount, "Withdrawal request ##{id}", "WD-#{id}")
  end
end
