class Admin::PricingController < Admin::ApplicationController
  before_action { require_sidebar_permission!('pricing') }

  def index
    # Full catalog + Ruby-side grouping is cached for 2 minutes — this page
    # renders one big per-category pricing table (with a print/PDF view), so
    # pagination or per-category filtering would break that UX. Cached value
    # is plain OpenStructs (not AR objects tied to this request) so it can be
    # cheaply serialized by the cache store between requests.
    @categories_with_products = Rails.cache.fetch('admin:pricing:overview', expires_in: 2.minutes) do
      products = Product.joins(:category)
                        .where(status: :active)
                        .select('products.id, products.name, products.price, products.buying_price, products.stock, products.has_multiple_quantities, categories.name as category_name, categories.id as category_id')
                        .order('categories.name ASC, products.name ASC')

      plain_products = products.map do |p|
        OpenStruct.new(
          id: p.id,
          name: p.name,
          price: p.price,
          buying_price: p.buying_price,
          stock: p.stock,
          has_multiple_quantities: p.has_multiple_quantities,
          category_name: p.category_name,
          category_id: p.category_id
        )
      end

      plain_products.group_by(&:category_name).map do |category_name, prods|
        in_stock = prods.select { |p| p.stock.to_f > 0 }
        out_of_stock = prods.select { |p| p.stock.to_f <= 0 }
        [category_name, in_stock + out_of_stock]
      end.sort_by { |_cat, prods| prods.any? { |p| p.stock.to_f > 0 } ? 0 : 1 }
    end
  end
end
