class FranchiseStockRequestItem < ApplicationRecord
  belongs_to :franchise_stock_request, counter_cache: :items_count
  belongs_to :product
  belongs_to :product_variant, optional: true

  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
