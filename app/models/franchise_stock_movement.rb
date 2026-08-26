class FranchiseStockMovement < ApplicationRecord
  MOVEMENT_TYPES = [
    ['added', 'Stock Added'],
    ['consumed', 'Stock Consumed'],
    ['adjusted', 'Stock Adjusted']
  ].freeze

  REFERENCE_TYPES = [
    ['wholesale_booking', 'Wholesale Booking (from HQ)'],
    ['franchise_booking', 'Franchise Booking'],
    ['adjustment', 'Manual Adjustment'],
    ['franchise_return', 'Franchise Return (to HQ)']
  ].freeze

  belongs_to :franchise
  belongs_to :product

  validates :reference_type, presence: true, inclusion: { in: REFERENCE_TYPES.map(&:first) }
  validates :movement_type, presence: true, inclusion: { in: MOVEMENT_TYPES.map(&:first) }
  validates :quantity, presence: true, numericality: { not_equal_to: 0 }
  validates :stock_before, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_after, presence: true, numericality: { greater_than_or_equal_to: 0 }

  validate :validate_quantity_direction

  scope :recent, -> { order(created_at: :desc) }
  scope :by_franchise, ->(franchise_id) { where(franchise_id: franchise_id) }
  scope :by_product, ->(product_id) { where(product_id: product_id) }

  def formatted_quantity
    sign = quantity > 0 ? '+' : ''
    "#{sign}#{quantity}"
  end

  def movement_type_badge_class
    case movement_type
    when 'added'
      'bg-success-subtle text-success'
    when 'consumed'
      'bg-danger-subtle text-danger'
    when 'adjusted'
      'bg-warning-subtle text-warning'
    else
      'bg-secondary-subtle text-secondary'
    end
  end

  def movement_type_icon
    case movement_type
    when 'added'
      'bi-arrow-down-circle'
    when 'consumed'
      'bi-arrow-up-circle'
    when 'adjusted'
      'bi-arrow-clockwise'
    else
      'bi-circle'
    end
  end

  private

  def validate_quantity_direction
    case movement_type
    when 'added'
      errors.add(:quantity, 'must be positive for stock additions') if quantity <= 0
    when 'consumed'
      errors.add(:quantity, 'must be negative for stock consumption') if quantity >= 0
    when 'adjusted'
      # Adjustments can be positive or negative
    end
  end
end
