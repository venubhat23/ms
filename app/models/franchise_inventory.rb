class FranchiseInventory < ApplicationRecord
  belongs_to :franchise
  belongs_to :product

  # quantity may go negative — a booking assigned to a franchise for delivery
  # before they've been restocked drives their ledger below zero (see
  # consume_stock!'s allow_negative:); the negative figure is what they owe HQ.
  validates :quantity, presence: true, numericality: true
  validates :franchise_id, uniqueness: { scope: :product_id }

  scope :with_stock, -> { where("quantity > 0") }

  def self.balance_for(franchise, product)
    find_by(franchise: franchise, product: product)&.quantity || 0
  end

  # Credits stock into a franchise's own ledger — e.g. HQ wholesaling stock to
  # them via a "Franchise Booking" — and records a paired
  # FranchiseStockMovement entry, mirroring StockBatch/StockMovement.
  def self.add_stock!(franchise, product, quantity, reference_type:, reference_id: nil, notes: nil)
    raise ArgumentError, "quantity must be positive" unless quantity.to_f > 0

    transaction do
      inventory = find_or_create_by!(franchise: franchise, product: product)
      inventory.lock!
      stock_before = inventory.quantity
      inventory.increment!(:quantity, quantity)

      FranchiseStockMovement.create!(
        franchise: franchise, product: product,
        reference_type: reference_type, reference_id: reference_id,
        movement_type: 'added', quantity: quantity,
        stock_before: stock_before, stock_after: inventory.quantity,
        notes: notes
      )

      inventory
    end
  end

  # Deducts stock as a franchise sells to their own walk-in customers.
  # Returns false (no raise) if there isn't enough balance — unless
  # allow_negative: true, in which case the ledger is allowed to go negative
  # (e.g. a booking is handed to a franchise for delivery before they've been
  # restocked; the negative balance is the stock they now owe HQ).
  def self.consume_stock!(franchise, product, quantity, reference_type:, reference_id: nil, notes: nil, allow_negative: false)
    raise ArgumentError, "quantity must be positive" unless quantity.to_f > 0

    transaction do
      inventory = find_or_create_by!(franchise: franchise, product: product)
      inventory.lock!
      next false if !allow_negative && inventory.quantity < quantity

      stock_before = inventory.quantity
      inventory.decrement!(:quantity, quantity)

      FranchiseStockMovement.create!(
        franchise: franchise, product: product,
        reference_type: reference_type, reference_id: reference_id,
        movement_type: 'consumed', quantity: -quantity,
        stock_before: stock_before, stock_after: inventory.quantity,
        notes: notes
      )

      true
    end
  end
end
