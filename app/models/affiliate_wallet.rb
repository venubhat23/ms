class AffiliateWallet < ApplicationRecord
  belongs_to :affiliate
  has_many :affiliate_wallet_transactions, dependent: :destroy

  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }

  after_initialize :set_defaults

  def add_money(amount, description = nil, reference = nil, booking_id: nil)
    transaction do
      self.balance += amount
      save!

      affiliate_wallet_transactions.create!(
        transaction_type: 'credit',
        amount: amount,
        balance_after: balance,
        description: description || 'Money added to wallet',
        reference_number: reference || generate_reference_number,
        booking_id: booking_id
      )
    end
  end

  def deduct_money(amount, description = nil, reference = nil, booking_id: nil)
    return false if balance < amount

    transaction do
      self.balance -= amount
      save!

      affiliate_wallet_transactions.create!(
        transaction_type: 'debit',
        amount: amount,
        balance_after: balance,
        description: description || 'Money deducted from wallet',
        reference_number: reference || generate_reference_number,
        booking_id: booking_id
      )
    end

    true
  end

  def formatted_balance
    "₹#{balance.to_f.round(2)}"
  end

  private

  def set_defaults
    self.balance ||= 0.0
  end

  def generate_reference_number
    "ATXN#{Time.current.to_i}#{rand(1000..9999)}"
  end
end
