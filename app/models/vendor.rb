class Vendor < ApplicationRecord
  has_many :vendor_purchases, dependent: :destroy
  has_many :stock_batches, dependent: :destroy
  has_many :vendor_payments, through: :vendor_purchases

  validates :name, presence: true
  validates :payment_type, inclusion: { in: %w[Cash Credit] }
  validates :status, inclusion: { in: [true, false] }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :opening_balance, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true

  scope :active, -> { where(status: true) }
  scope :inactive, -> { where(status: false) }

  # Adds purchases_count / purchases_total / purchases_paid columns, computed
  # per vendor in the same query (one aggregate per row via LATERAL), so a
  # vendor list shows totals without loading every purchase row.
  scope :with_purchase_totals, -> {
    select("vendors.*, vp_totals.purchases_count, vp_totals.purchases_total, vp_totals.purchases_paid")
      .joins(<<~SQL.squish)
        LEFT JOIN LATERAL (
          SELECT COUNT(*) AS purchases_count,
                 COALESCE(SUM(vendor_purchases.total_amount), 0) AS purchases_total,
                 COALESCE(SUM(vendor_purchases.paid_amount), 0) AS purchases_paid
          FROM vendor_purchases
          WHERE vendor_purchases.vendor_id = vendors.id
        ) vp_totals ON TRUE
      SQL
  }

  # When vendor_purchases has been preloaded (e.g. Vendor.includes(:vendor_purchases)
  # for an index list), summing the already-loaded records in Ruby avoids firing a
  # fresh SQL SUM per vendor — `.sum(:column)` always hits the DB even on a preloaded
  # association, but `.sum(&block)` reuses the loaded array. Falls back to the DB-side
  # sum when it isn't preloaded, so this stays correct (just not extra-fast) anywhere
  # else it's called.
  # Rows loaded via with_purchase_totals already carry the sums.
  def total_purchases
    @total_purchases ||=
      if has_attribute?(:purchases_total) then read_attribute(:purchases_total).to_d
      elsif vendor_purchases.loaded? then vendor_purchases.sum(&:total_amount)
      else purchase_and_paid_sums.first
      end
  end

  def total_paid
    @total_paid ||=
      if has_attribute?(:purchases_paid) then read_attribute(:purchases_paid).to_d
      elsif vendor_purchases.loaded? then vendor_purchases.sum(&:paid_amount)
      else purchase_and_paid_sums.last
      end
  end

  def purchases_count
    has_attribute?(:purchases_count) ? read_attribute(:purchases_count).to_i : vendor_purchases.size
  end

  # Both sums in one query (they're nearly always read together, e.g. via
  # outstanding_balance) instead of one round trip each.
  def purchase_and_paid_sums
    @purchase_and_paid_sums ||= vendor_purchases.pick(
      Arel.sql('COALESCE(SUM(total_amount), 0)'), Arel.sql('COALESCE(SUM(paid_amount), 0)')
    )
  end

  def outstanding_balance
    @outstanding_balance ||= total_purchases - total_paid + (opening_balance || 0)
  end

  # "Mark vendor as Paid" from the vendors list: settles every unpaid purchase
  # (paid_amount = total, same as VendorPurchase mark_as_paid) and clears the
  # opening balance so the outstanding shows ₹0. payment_type (Cash/Credit
  # terms) is left alone.
  def mark_as_paid!
    transaction do
      vendor_purchases.where('COALESCE(paid_amount, 0) < COALESCE(total_amount, 0)').find_each do |purchase|
        purchase.update!(paid_amount: purchase.total_amount)
      end
      update!(opening_balance: 0) if opening_balance.to_d.positive?
    end
  end

  def can_be_deleted?
    has_attribute?(:purchases_count) ? purchases_count.zero? : vendor_purchases.empty?
  end

  def display_name
    name
  end

  def payment_type_badge_class
    case payment_type
    when 'Cash'
      'bg-success text-white'
    when 'Credit'
      'bg-warning text-dark'
    else
      'bg-secondary text-white'
    end
  end

  def status_badge_class
    status ? 'bg-success text-white' : 'bg-danger text-white'
  end

  def status_text
    status ? 'Active' : 'Inactive'
  end
end