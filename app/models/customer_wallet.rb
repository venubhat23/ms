class CustomerWallet < ApplicationRecord
  belongs_to :customer
  has_many :wallet_transactions, dependent: :destroy

  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }

  after_initialize :set_defaults

  # Lazily provisions a wallet for a customer who doesn't have one yet
  # (starts at balance 0), instead of requiring an admin to create it first.
  def self.for_customer(customer)
    find_or_create_by!(customer_id: customer.id) do |wallet|
      wallet.balance = 0
      wallet.status = true
    end
  end

  def add_money(amount, description = nil, reference = nil, booking_id: nil)
    transaction do
      self.balance += amount
      save!

      wallet_transactions.create!(
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

      wallet_transactions.create!(
        transaction_type: 'debit',
        amount: amount,
        balance_after: balance,
        description: description || 'Money deducted from wallet',
        reference_number: reference || generate_reference_number,
        booking_id: booking_id
      )
    end
  end

  def formatted_balance
    "₹#{balance.to_f.round(2)}"
  end

  private

  def set_defaults
    self.balance ||= 0.0
  end

  def generate_reference_number
    "TXN#{Time.current.to_i}#{rand(1000..9999)}"
  end
end
