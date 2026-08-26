class FranchiseReturnItem < ApplicationRecord
  belongs_to :franchise_return, counter_cache: :items_count
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :unit_price, presence: true, numericality: { greater_than: 0 }
  validate :product_has_b2b_price

  def subtotal
    quantity.to_f * unit_price.to_f
  end

  private

  # A return must always be valued at the franchise's actual B2B/wholesale
  # price, never Product#effective_b2b_price's fallback to the regular
  # selling price — checked here too (not just filtered out of the picker
  # in Admin::FranchiseReturnsController#cached_products_json) so a stale
  # cached catalog or a future call site can't credit a return at the
  # higher retail price.
  def product_has_b2b_price
    return if product.nil? || product.b2b_price.present?

    errors.add(:base, "#{product.name} has no B2B price set and cannot be returned")
  end
end
