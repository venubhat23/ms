class ProductVariant < ApplicationRecord
  class TransferError < StandardError; end

  belongs_to :product

  UNIT_TYPES = Product::UNIT_TYPES

  validates :weight, presence: true, numericality: { greater_than: 0 }
  validates :selling_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :unit, presence: true
  validates :available_stock, numericality: { greater_than_or_equal_to: 0 }

  scope :ordered, -> { order(:display_order, :weight) }
  scope :default_first, -> { order(is_default: :desc, weight: :asc) }
  scope :in_stock, -> { where('available_stock > 0') }

  before_save :calculate_discount_amount
  before_save :calculate_gst_fields
  before_save :ensure_single_default

  after_create :create_initial_stock_records, if: -> { available_stock.present? && available_stock > 0 }
  after_commit :bust_mobile_product_cache

  def bust_mobile_product_cache
    MobileApiCache.bust_products!
  end

  def label
    "#{weight.to_f.to_s.sub(/\.0$/, '')} #{unit}"
  end

  def effective_price
    if discount_enabled? && discount_amount.present? && discount_amount > 0
      (selling_price - discount_amount).round(2)
    else
      selling_price
    end
  end

  def effective_gst_percentage
    gst_percentage.presence || product&.gst_percentage || 0
  end

  def computed_gst_amount
    return 0 unless effective_gst_percentage > 0
    (effective_price * effective_gst_percentage / 100.0).round(2)
  end

  def price_with_gst
    (effective_price + computed_gst_amount).round(2)
  end

  def in_stock?
    available_stock > 0
  end

  # Moves stock between variants of the same product — covers both splitting
  # one variant into several smaller ones and merging several into one. Each
  # side is a list of { variant:, quantity: } lines; the two sides must carry
  # the same total weight (quantity * variant.weight) since nothing is being
  # created or destroyed, only repackaged.
  def self.transfer_stock!(product:, from_lines:, to_lines:)
    raise TransferError, 'Select at least one source variant and quantity.' if from_lines.blank?
    raise TransferError, 'Select at least one destination variant and quantity.' if to_lines.blank?

    from_lines.each do |line|
      raise TransferError, "#{line[:variant].label} does not belong to #{product.name}." unless line[:variant].product_id == product.id
    end
    to_lines.each do |line|
      raise TransferError, "#{line[:variant].label} does not belong to #{product.name}." unless line[:variant].product_id == product.id
    end

    from_total_weight = from_lines.sum { |line| line[:quantity] * line[:variant].weight.to_f }
    to_total_weight = to_lines.sum { |line| line[:quantity] * line[:variant].weight.to_f }

    if (from_total_weight - to_total_weight).abs > 0.01
      raise TransferError, "Quantities don't balance: source totals #{from_total_weight.round(2)}, destination totals #{to_total_weight.round(2)}. They must match."
    end

    from_lines.each do |line|
      if line[:variant].available_stock < line[:quantity]
        raise TransferError, "Not enough stock in #{line[:variant].label} (available #{line[:variant].available_stock}, requested #{line[:quantity]})."
      end
    end

    transaction do
      from_lines.each do |line|
        variant = line[:variant]
        stock_before = variant.available_stock
        stock_after = stock_before - line[:quantity]
        variant.update_column(:available_stock, stock_after)
        product.stock_movements.create!(
          reference_type: 'variant_split',
          movement_type: 'consumed',
          quantity: -line[:quantity],
          stock_before: stock_before,
          stock_after: stock_after,
          notes: "Split/merge: moved #{line[:quantity]} x #{variant.label} out to other variant(s)"
        )
      end

      to_lines.each do |line|
        variant = line[:variant]
        stock_before = variant.available_stock
        stock_after = stock_before + line[:quantity]
        variant.update_column(:available_stock, stock_after)
        product.stock_movements.create!(
          reference_type: 'variant_split',
          movement_type: 'added',
          quantity: line[:quantity],
          stock_before: stock_before,
          stock_after: stock_after,
          notes: "Split/merge: received #{line[:quantity]} x #{variant.label} from other variant(s)"
        )
      end
    end
  end

  private

  def calculate_discount_amount
    return unless discount_enabled?
    return unless discount_type.present? && discount_value.present? && selling_price.present?

    self.discount_amount = if discount_type == 'percentage'
      (selling_price * discount_value / 100.0).round(2)
    else
      [discount_value, selling_price].min.round(2)
    end
  end

  def calculate_gst_fields
    pct = gst_percentage.presence&.to_f || product&.gst_percentage.to_f
    if pct && pct > 0 && selling_price.present?
      base = effective_price
      self.gst_amount = (base * pct / 100.0).round(2)
      self.final_price_with_gst = (base + gst_amount).round(2)
    else
      self.gst_amount = 0
      self.final_price_with_gst = effective_price
    end
  end

  def ensure_single_default
    if is_default? && is_default_changed?
      product.product_variants.where.not(id: id).update_all(is_default: false)
    end
  end

  def create_initial_stock_records
    variant_label = "#{weight.to_f.to_s.sub(/\.0$/, '')} #{unit}"

    product.stock_movements.create!(
      reference_type: 'adjustment',
      reference_id: nil,
      movement_type: 'added',
      quantity: available_stock,
      stock_before: 0,
      stock_after: available_stock,
      notes: "Initial stock for variant #{variant_label} when product was created"
    )

    default_vendor = Vendor.find_or_create_by(name: 'System Default') do |v|
      v.email   = 'system@default.com'
      v.phone   = '0000000000'
      v.address = 'System Generated'
      v.payment_type = 'Cash'
      v.status  = true
    end

    product.stock_batches.create!(
      vendor: default_vendor,
      quantity_purchased: available_stock,
      quantity_remaining: available_stock,
      purchase_price: buying_price.presence || selling_price || 0,
      selling_price: selling_price,
      batch_date: Date.current,
      status: 'active'
    )
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Failed to create initial stock records for ProductVariant #{id}: #{e.message}"
  end
end
