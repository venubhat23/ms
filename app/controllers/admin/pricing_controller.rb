class Admin::PricingController < Admin::ApplicationController
  def index
    products = Product.includes(:category)
                      .joins(:category)
                      .where(status: :active)
                      .select('products.id, products.name, products.price, products.buying_price, products.stock, products.has_multiple_quantities, categories.name as category_name, categories.id as category_id')
                      .order('categories.name ASC, products.name ASC')

    @categories_with_products = products.group_by(&:category_name).map do |category_name, prods|
      in_stock = prods.select { |p| p.stock.to_f > 0 }
      out_of_stock = prods.select { |p| p.stock.to_f <= 0 }
      [category_name, in_stock + out_of_stock]
    end.sort_by { |_cat, prods| prods.any? { |p| p.stock.to_f > 0 } ? 0 : 1 }
  end
end
