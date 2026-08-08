class Api::V1::Admin::PricingController < Api::V1::Admin::BaseController
  # GET /api/v1/admin/pricing
  def index
    data = Rails.cache.fetch('api:admin:pricing:overview', expires_in: 2.minutes) do
      products = Product.joins(:category)
                         .where(status: :active)
                         .select('products.id, products.name, products.price, products.discount_price,
                                  products.buying_price, products.stock, products.has_multiple_quantities,
                                  categories.name as category_name, categories.id as category_id')
                         .order('categories.name ASC, products.name ASC')

      products.group_by(&:category_name).map do |category_name, prods|
        {
          category_id: prods.first.category_id,
          category_name: category_name,
          products: prods.map do |p|
            {
              id: p.id,
              name: p.name,
              price: p.price.to_f,
              discount_price: p.discount_price&.to_f,
              buying_price: p.buying_price&.to_f,
              stock: p.stock,
              in_stock: p.stock.to_f > 0,
              has_multiple_quantities: p.has_multiple_quantities
            }
          end
        }
      end
    end

    render_success(data)
  end
end
