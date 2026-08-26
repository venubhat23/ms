class FranchiseReturnItem < ApplicationRecord
  belongs_to :franchise_return, counter_cache: :items_count
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :unit_price, presence: true, numericality: { greater_than: 0 }

  def subtotal
    quantity.to_f * unit_price.to_f
  end
end
