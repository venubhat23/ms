class AddLowStockThresholdToProductVariants < ActiveRecord::Migration[8.0]
  def change
    unless column_exists?(:product_variants, :low_stock_threshold)
      add_column :product_variants, :low_stock_threshold, :integer, default: 10
    end
  end
end
