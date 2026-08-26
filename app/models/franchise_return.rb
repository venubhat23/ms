class FranchiseReturn < ApplicationRecord
  belongs_to :franchise
  belongs_to :reviewed_by, class_name: "User", optional: true

  has_many :items, class_name: "FranchiseReturnItem", dependent: :destroy
  accepts_nested_attributes_for :items, allow_destroy: true,
    reject_if: proc { |attrs| attrs["product_id"].blank? || attrs["quantity"].to_f <= 0 }

  enum :status, { pending: "pending", approved: "approved", rejected: "rejected" }

  validate :must_have_at_least_one_item
  before_validation :calculate_total_amount

  scope :recent, -> { order(created_at: :desc) }

  # Placeholder vendor StockBatch requires (it belongs_to :vendor, not
  # optional) — returned stock has no real vendor, so every franchise
  # return's stock batches are attributed to this one shared record.
  RETURN_VENDOR_NAME = "Franchise Returns".freeze

  LOCAL_CACHE = LocalTtlCache.new
  LOCAL_TTL = 20.seconds

  def self.admin_pending_count
    LOCAL_CACHE.fetch("franchise_returns/admin_pending_count", LOCAL_TTL) do
      where(status: "pending").count
    end
  end

  # Approves the return: for each item, credits the quantity back into
  # main-store stock (a new active StockBatch, same shape
  # VendorPurchase#create_stock_batches builds), debits it from the
  # franchise's own inventory ledger where possible, and credits the
  # franchise's wallet for the value being returned.
  def approve!(admin_user)
    return false unless pending?

    transaction do
      items.includes(:product).each { |item| credit_stock_and_wallet(item) }
      update!(status: :approved, reviewed_by: admin_user, reviewed_at: Time.current)
    end

    LOCAL_CACHE.delete("franchise_returns/admin_pending_count")
    true
  rescue => e
    Rails.logger.error "FranchiseReturn##{id} approve! failed: #{e.message}"
    errors.add(:base, e.message)
    false
  end

  def reject!(admin_user, reason = nil)
    return false unless pending?

    result = update(status: :rejected, reviewed_by: admin_user, reviewed_at: Time.current, rejection_reason: reason)
    LOCAL_CACHE.delete("franchise_returns/admin_pending_count") if result
    result
  end

  def total_quantity
    items.sum(&:quantity)
  end

  private

  def must_have_at_least_one_item
    active_items = items.reject { |i| i.marked_for_destruction? || i.product_id.blank? || i.quantity.to_f <= 0 }
    errors.add(:base, "Add at least one product to return") if active_items.empty?
  end

  def calculate_total_amount
    self.total_amount = items.reject(&:marked_for_destruction?).sum { |i| i.quantity.to_f * i.unit_price.to_f }
  end

  def return_vendor
    Vendor.find_or_create_by!(name: RETURN_VENDOR_NAME) do |v|
      v.payment_type = "Cash"
      v.status = true
    end
  end

  def credit_stock_and_wallet(item)
    product = item.product
    current_stock = product.total_batch_stock

    StockBatch.create!(
      product: product,
      vendor: return_vendor,
      quantity_purchased: item.quantity,
      quantity_remaining: item.quantity,
      purchase_price: item.unit_price,
      selling_price: product.selling_price,
      batch_date: Date.current,
      status: "active"
    )

    new_stock = product.total_batch_stock
    product.update_column(:stock, new_stock)

    product.stock_movements.create!(
      reference_type: "franchise_return",
      reference_id: id,
      movement_type: "added",
      quantity: item.quantity.to_f,
      stock_before: current_stock,
      stock_after: new_stock,
      notes: "Stock returned from franchise #{franchise.name} (Return ##{id}) - #{product.name} (Qty: #{item.quantity})"
    )

    FranchiseInventory.consume_stock!(
      franchise, product, item.quantity,
      reference_type: "franchise_return",
      reference_id: id,
      notes: "Returned to HQ via Return ##{id}"
    )

    wallet = franchise.franchise_wallet || franchise.create_franchise_wallet!
    wallet.add_money(
      item.subtotal,
      "Product Return - #{product.name} x#{item.quantity} (Return ##{id})",
      "RETURN-#{id}-#{item.id}"
    )
  end
end
