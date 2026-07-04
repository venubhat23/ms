class StoreAdmin::StockTransfersController < StoreAdmin::ApplicationController
  def index
    @transfers = StockTransfer.for_store(@current_store.id)
                              .includes(:product, :product_variant, :from_store, :requested_by)
                              .order(created_at: :desc)
                              .page(params[:page]).per(25)
  end

  def new
    stock_subquery = StockBatch
      .select("product_id, SUM(quantity_remaining) AS total_stock")
      .where(status: 'active').where("quantity_remaining > 0")
      .group(:product_id)
      .to_sql

    products = Product.active
                      .joins("LEFT JOIN (#{stock_subquery}) AS batch_stock ON batch_stock.product_id = products.id")
                      .select(
                        "products.id, products.name, products.sku, " \
                        "products.category_id, products.has_multiple_quantities, " \
                        "products.r2_image_url, products.image_url, " \
                        "products.stock, products.display_order, " \
                        "COALESCE(batch_stock.total_stock, 0) AS cached_stock"
                      )
                      .includes(:category, :product_variants)
                      .by_stock_availability

    @products_json = products.map do |p|
      {
        id:            p.id,
        name:          p.name,
        sku:           p.sku.to_s,
        category_id:   p.category_id&.to_s || '',
        category_name: p.category&.name || 'No Category',
        stock:         p.cached_total_batch_stock,
        has_variants:  p.has_multiple_quantities,
        image_url:     p.r2_image_url.presence || p.image_url.presence,
        variants:      p.has_multiple_quantities ? p.product_variants.sort_by { |v| [v.display_order.to_i, v.weight.to_f] }.map { |v| { id: v.id, label: v.label.to_s, stock: v.available_stock.to_f } } : []
      }
    end.to_json

    @stores = Store.where.not(id: @current_store.id).active.order(:name)
  end

  def create
    transfers_params = params[:transfers].to_unsafe_h rescue {}
    from_store_id    = params[:from_store_id].presence
    notes            = params[:notes].to_s.strip

    if transfers_params.blank?
      flash[:alert] = 'Please select at least one product.'
      redirect_to new_store_admin_stock_transfer_path and return
    end

    errors        = []
    created       = 0
    transfer_group_id = SecureRandom.uuid

    items = transfers_params.values.map do |item|
      { product_id: item[:product_id].to_i, quantity: item[:quantity].to_f, variant_id: item[:variant_id].to_i }
    end.select { |i| i[:product_id] > 0 && i[:quantity] > 0 }

    product_ids = items.map { |i| i[:product_id] }.uniq
    variant_ids = items.map { |i| i[:variant_id] }.select(&:positive?).uniq

    products_by_id = Product.where(id: product_ids).index_by(&:id)
    variants_by_id = variant_ids.any? ? ProductVariant.where(id: variant_ids).index_by(&:id) : {}

    items.each do |item|
      product = products_by_id[item[:product_id]]
      next unless product

      variant = item[:variant_id] > 0 ? variants_by_id[item[:variant_id]] : nil

      transfer = StockTransfer.new(
        product:            product,
        product_variant:    variant,
        from_store_id:      from_store_id,
        to_store:           @current_store,
        requested_by:       current_user,
        quantity:           item[:quantity],
        notes:              notes,
        status:             'pending',
        transfer_group_id:  transfer_group_id
      )

      if transfer.save
        created += 1
      else
        errors << "#{product.name}: #{transfer.errors.full_messages.join(', ')}"
      end
    end

    if errors.any?
      flash[:alert] = "Some requests failed — #{errors.join(' | ')}"
    end

    if created > 0
      flash[:notice] = "#{created} transfer request(s) submitted. Awaiting admin approval."
      redirect_to store_admin_stock_transfers_path
    else
      redirect_to new_store_admin_stock_transfer_path
    end
  end
end
