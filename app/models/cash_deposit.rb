# Cash moved from a shop's till to the bank. A shop's cash in hand is the cash
# it collected on bookings (CashDeposit.collected_by_store) minus these.
# store_id NULL is the main shop, the same convention as bookings.store_id.
class CashDeposit < ApplicationRecord
  MAIN_STORE_LABEL = 'Main Shop'.freeze

  belongs_to :store, optional: true
  belongs_to :created_by, class_name: 'User', optional: true

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :deposited_on, presence: true
  validate :amount_within_cash_in_hand, on: :create

  scope :for_store_key, ->(key) { key.to_s == 'main' ? where(store_id: nil) : where(store_id: key) }

  # Bookings counted as cash collected: payment method "cash" and marked paid,
  # not cancelled. bookings.payment_method is a string column holding the
  # integer enum value, so cash is stored as '0'. Wallet money used on the
  # booking is not cash, so it is left out of the amount.
  def self.cash_bookings
    Booking.where(payment_method: Booking.payment_methods[:cash].to_s, payment_status: 'paid')
           .where("bookings.status IS NULL OR bookings.status <> 'cancelled'")
  end

  CASH_AMOUNT_SQL = 'COALESCE(bookings.total_amount, 0) - COALESCE(bookings.wallet_amount_used, 0)'.freeze
  # When the cash came in: the payment time if recorded, otherwise the booking time.
  COLLECTED_AT_SQL = 'COALESCE(bookings.payment_completed_at, bookings.created_at)'.freeze

  # { store_id_or_nil => [booking_count, cash_amount] } in one query.
  def self.collected_by_store(range = nil)
    scope = cash_bookings
    scope = scope.where(Arel.sql("#{COLLECTED_AT_SQL} BETWEEN ? AND ?"), range.begin, range.end) if range
    scope.group(:store_id)
         .pluck(:store_id, Arel.sql('COUNT(*)'), Arel.sql("SUM(#{CASH_AMOUNT_SQL})"))
         .to_h { |store_id, count, sum| [store_id, [count.to_i, sum.to_d]] }
  end

  def self.deposited_by_store
    group(:store_id).sum(:amount).transform_values(&:to_d)
  end

  def self.cash_in_hand(store_id)
    collected = cash_bookings.where(store_id: store_id).sum(Arel.sql(CASH_AMOUNT_SQL)).to_d
    collected - where(store_id: store_id).sum(:amount).to_d
  end

  def store_label
    store&.name || MAIN_STORE_LABEL
  end

  private

  # Runs inside the transaction CashDeposit#save opens; the advisory lock stops
  # two deposits for the same shop from both passing this check at once.
  def amount_within_cash_in_hand
    return if amount.blank? || amount <= 0

    self.class.connection.execute(
      "SELECT pg_advisory_xact_lock(#{self.class.connection.quote(73_100_000 + store_id.to_i)})"
    )
    available = self.class.cash_in_hand(store_id)
    return if amount <= available

    errors.add(:amount, "is more than the cash in hand at #{store_label} (₹#{available.round(2).to_s('F')})")
  end
end
