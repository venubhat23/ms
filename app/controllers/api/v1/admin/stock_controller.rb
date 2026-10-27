class Api::V1::Admin::StockController < Api::V1::Admin::BaseController
  # GET /api/v1/admin/stock
  # Stock per product, counted like the web products page (Product#total_stock).
  # Filters: stock_status (out_of_stock / low_stock / in_stock), category_id, search
  def index
    products = Product.all
    products = products.where(category_id: params[:category_id]) if params[:category_id].present?
    if params[:search].present?
      term = "%#{ActiveRecord::Base.sanitize_sql_like(params[:search].strip)}%"
      products = products.where('products.name ILIKE :t OR products.sku ILIKE :t', t: term)
    end

    summary = {
      total_products: products.count,
      out_of_stock: products.where_stock_status('out_of_stock').count,
      low_stock: products.where_stock_status('low_stock').count,
      in_stock: products.where_stock_status('in_stock').count,
      low_stock_limit: Product::LOW_STOCK_LIMIT
    }

    products = products.where_stock_status(params[:stock_status]) if params[:stock_status].present?
    products = paginate_scope(
      products.with_total_stock.includes(:category, image_attachment: :blob)
              .order(Arel.sql("(#{Product::TOTAL_STOCK_SQL}) ASC, products.name ASC"))
    )

    render_success(
      summary: summary,
      products: products.map { |p| stock_row(p) },
      pagination: pagination_meta(products)
    )
  end

  # GET /api/v1/admin/stock/:id
  # One product: variant-level stock and its latest stock movements.
  def show
    product = Product.with_total_stock.includes(:category, :product_variants).find(params[:id])
    movements = product.stock_movements.order(created_at: :desc).limit((params[:movements_limit] || 50).to_i.clamp(1, 200))

    render_success(
      stock_row(product).merge(
        variants: product.product_variants.sort_by { |v| [v.display_order.to_i, v.id] }.map do |v|
          {
            id: v.id,
            label: v.label,
            available_stock: v.available_stock.to_i,
            low_stock_threshold: v.low_stock_threshold,
            stock_status: v.available_stock.to_i <= 0 ? 'out_of_stock' : (v.available_stock.to_i <= v.low_stock_threshold.to_i ? 'low_stock' : 'in_stock')
          }
        end,
        movements: movements.map do |m|
          {
            id: m.id,
            movement_type: m.movement_type,
            quantity: m.quantity.to_f,
            stock_before: m.stock_before.to_f,
            stock_after: m.stock_after.to_f,
            reference_type: m.reference_type,
            reference_id: m.reference_id,
            reference_description: (m.reference_description rescue nil),
            notes: m.notes,
            created_at: m.created_at
          }
        end
      )
    )
  rescue ActiveRecord::RecordNotFound
    render_error('Product not found', nil, :not_found)
  end

  private

  def stock_row(product)
    total = product.computed_total_stock.to_i
    {
      id: product.id,
      name: product.name,
      sku: product.sku,
      category: { id: product.category_id, name: product.category&.name },
      unit_type: product.unit_type,
      status: product.status,
      has_variants: product.has_multiple_quantities,
      total_stock: total,
      stock_status: Product.stock_status_for(total),
      main_image_url: product.main_image_url
    }
  end
end
