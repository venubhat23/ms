class AddB2bSellingPriceToProductVariants < ActiveRecord::Migration[8.0]
  def change
    add_column :product_variants, :b2b_selling_price, :decimal, precision: 10, scale: 2
  end
end
