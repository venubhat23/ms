class Api::V1::Admin::VendorPurchasesController < Api::V1::Admin::BaseController
  PURCHASE_INCLUDES = [:vendor, :vendor_invoice, { vendor_purchase_items: [:product, :product_variant] }].freeze

  # GET /api/v1/admin/vendor_purchases
  # Same list as the web purchases page. Filters: search (vendor name), vendor_id,
  # status (pending/completed/cancelled), payment_status (paid/partial/unpaid).
  def index
    scope = VendorPurchase.all
    scope = scope.joins(:vendor).where('vendors.name ILIKE ?', "%#{VendorPurchase.sanitize_sql_like(params[:search].to_s.strip)}%") if params[:search].present?
    scope = scope.where(vendor_id: params[:vendor_id]) if params[:vendor_id].present?
    scope = scope.where(status: params[:status]) if params[:status].present?
    case params[:payment_status]
    when 'paid'    then scope = scope.where('COALESCE(vendor_purchases.paid_amount, 0) >= COALESCE(vendor_purchases.total_amount, 0)')
    when 'unpaid'  then scope = scope.where('COALESCE(vendor_purchases.paid_amount, 0) <= 0')
    when 'partial' then scope = scope.where('vendor_purchases.paid_amount > 0 AND vendor_purchases.paid_amount < vendor_purchases.total_amount')
    end

    total_count, pending_count, total_value, outstanding_value = scope.pick(
      Arel.sql('COUNT(*)'),
      Arel.sql("COUNT(*) FILTER (WHERE vendor_purchases.status = 'pending')"),
      Arel.sql('COALESCE(SUM(vendor_purchases.total_amount), 0)'),
      Arel.sql('COALESCE(SUM(vendor_purchases.total_amount - vendor_purchases.paid_amount), 0)')
    )
    purchases = paginate_scope(scope.includes(*PURCHASE_INCLUDES).recent)

    render_success(
      summary: {
        total_purchases: total_count.to_i,
        pending_purchases: pending_count.to_i,
        total_value: total_value.to_f,
        outstanding_value: outstanding_value.to_f
      },
      purchases: purchases.map { |p| self.class.purchase_json(p) },
      pagination: pagination_meta(purchases)
    )
  end

  # GET /api/v1/admin/vendor_purchases/form_options
  # What the web "New Purchase" form offers: active vendors, and products
  # (multi-quantity products expanded to one entry per variant).
  def form_options
    products = Product.active.includes(:product_variants).order(:name)
    render_success(
      vendors: Vendor.active.order(:name).map { |v| { id: v.id, name: v.name, phone: v.phone, payment_type: v.payment_type } },
      products: VendorPurchase.product_option_list(products).map { |o| o.except(:value) }
    )
  end

  # GET /api/v1/admin/vendor_purchases/products
  # Product picker for a purchase line: one row per thing that can be bought
  # (same list as form_options, but searchable and paginated). Products with
  # pack sizes come back as one row per variant, so each row carries the exact
  # product_id + product_variant_id to send in POST vendor_purchases items[].
  # Filters: search (name/SKU), category_id. Pagination is by product.
  def products
    scope = Product.active
    if params[:search].present?
      term = "%#{Product.sanitize_sql_like(params[:search].to_s.strip)}%"
      scope = scope.where('products.name ILIKE :t OR products.sku ILIKE :t', t: term)
    end
    scope = scope.where(category_id: params[:category_id]) if params[:category_id].present?
    products = paginate_scope(scope.includes(:category, :product_variants).order(:name))
    by_id = products.index_by(&:id)

    rows = VendorPurchase.product_option_list(products).map do |o|
      product = by_id[o[:product_id]]
      {
        product_id: o[:product_id],
        product_variant_id: o[:variant_id],
        name: o[:name],
        sku: product.sku,
        category: product.category && { id: product.category_id, name: product.category.name },
        image_url: product.main_image_url,
        unit_type: o[:unit_type],
        default_purchase_price: o[:default_purchase_price],
        default_selling_price: o[:default_selling_price],
        available_stock: o[:available_stock]
      }
    end

    render_success(
      products: rows,
      categories: page_one? ? Category.active.ordered.map { |c| { id: c.id, name: c.name } } : nil,
      pagination: pagination_meta(products)
    )
  end

  # GET /api/v1/admin/vendor_purchases/:id
  def show
    purchase = VendorPurchase.includes(*PURCHASE_INCLUDES).find(params[:id])
    render_success(self.class.purchase_json(purchase, with_stock: true))
  rescue ActiveRecord::RecordNotFound
    render_error('Purchase not found', nil, :not_found)
  end

  # POST /api/v1/admin/vendor_purchases
  # Same as the web Admin::VendorPurchasesController#create: the purchase is
  # saved as 'pending' and VendorPurchase's after_save callback creates a stock
  # batch per line, adds the quantity to stock (variant available_stock, or
  # product stock) and logs a StockMovement, all in one transaction.
  #
  # Body: { vendor_id, purchase_date (YYYY-MM-DD, default today), notes, paid_amount,
  #         items: [{ product_id, product_variant_id, quantity, purchase_price, selling_price }] }
  # (may also be wrapped in "vendor_purchase": { ... })
  def create
    # Look in the optional "vendor_purchase" wrapper first, then top level
    # (Rails' JSON param wrapping copies only model columns into the wrapper,
    # so items can be at the top level even when the wrapper exists).
    wrapper = params[:vendor_purchase].is_a?(ActionController::Parameters) ? params[:vendor_purchase] : {}
    attrs = ->(key) { wrapper[key].presence || params[key] }
    items = attrs.(:items)
    items = [] unless items.is_a?(Array)

    vendor = Vendor.find_by(id: attrs.(:vendor_id))
    return render_error('Vendor not found', ['vendor_id is invalid'], :unprocessable_entity) unless vendor
    return render_error('Vendor is inactive', ['Activate the vendor before adding a purchase'], :unprocessable_entity) unless vendor.status
    return render_error('Validation failed', ['Purchase must have at least one item'], :unprocessable_entity) if items.empty?

    item_errors = []
    item_attrs = items.each_with_index.map do |raw, index|
      return render_error('Validation failed', ["Item #{index + 1}: must be an object"], :unprocessable_entity) unless raw.is_a?(ActionController::Parameters)
      item = raw.permit(:product_id, :product_variant_id, :quantity, :purchase_price, :selling_price)
      error = item_error(item, index)
      item_errors << error if error
      item.to_h.slice('product_id', 'product_variant_id', 'quantity', 'purchase_price', 'selling_price')
    end
    return render_error('Validation failed', item_errors, :unprocessable_entity) if item_errors.any?

    purchase_date = attrs.(:purchase_date).present? ? param_purchase_date(attrs.(:purchase_date)) : Date.current
    return render_error('Validation failed', ['purchase_date must be YYYY-MM-DD'], :unprocessable_entity) unless purchase_date

    purchase = VendorPurchase.new(
      vendor: vendor,
      purchase_date: purchase_date,
      notes: attrs.(:notes),
      paid_amount: attrs.(:paid_amount).presence || 0,
      status: 'pending',
      vendor_purchase_items_attributes: item_attrs
    )

    if purchase.save
      purchase = VendorPurchase.includes(*PURCHASE_INCLUDES).find(purchase.id)
      render_success(self.class.purchase_json(purchase, with_stock: true),
                     'Purchase was successfully created and stock batches have been generated.', :created)
    else
      render_validation_errors(purchase)
    end
  end

  # PATCH /api/v1/admin/vendor_purchases/:id
  # Pending purchases only (same rule as web). Body: { notes, purchase_date, paid_amount }
  # Line items cannot be changed here: the model's stock-batch sync does not
  # run on item edits, so changing quantities would leave stock wrong.
  # Delete the pending purchase and create a new one instead.
  def update
    purchase = VendorPurchase.find(params[:id])
    return render_error('Cannot edit completed or cancelled purchases.') unless purchase.can_be_edited?

    # Keys may be top level or inside "vendor_purchase": { ... }
    wrapper = params[:vendor_purchase].is_a?(ActionController::Parameters) ? params[:vendor_purchase] : ActionController::Parameters.new
    given = ->(key) { params.key?(key) || wrapper.key?(key) }
    value = ->(key) { wrapper.key?(key) ? wrapper[key] : params[key] }
    if given.(:items) || given.(:vendor_purchase_items_attributes)
      return render_error('Validation failed', ['Items cannot be edited; delete this pending purchase and create a new one'])
    end

    attrs = {}
    attrs[:notes] = value.(:notes) if given.(:notes)
    if given.(:purchase_date)
      date = param_purchase_date(value.(:purchase_date))
      return render_error('Validation failed', ['purchase_date must be YYYY-MM-DD']) unless date
      attrs[:purchase_date] = date
    end
    if given.(:paid_amount)
      paid = BigDecimal(value.(:paid_amount).to_s, exception: false)
      unless paid && paid >= 0 && paid <= purchase.total_amount.to_d
        return render_error('Validation failed', ["paid_amount must be between 0 and #{purchase.total_amount.to_f}"])
      end
      attrs[:paid_amount] = paid
    end
    return render_error('Validation failed', ['Send at least one of notes, purchase_date, paid_amount']) if attrs.empty?

    if purchase.update(attrs)
      render_success(purchase_detail(purchase.id), 'Purchase was successfully updated.')
    else
      render_validation_errors(purchase)
    end
  rescue ActiveRecord::RecordNotFound
    render_error('Purchase not found', nil, :not_found)
  end

  # DELETE /api/v1/admin/vendor_purchases/:id — pending purchases only (same as web).
  # Like the web delete, its stock batches are removed with it but the stock
  # that was added to products/variants is NOT taken back out.
  def destroy
    purchase = VendorPurchase.find(params[:id])
    return render_error('Cannot delete completed purchases with stock movements.') unless purchase.can_be_cancelled?

    purchase.stock_batches.update_all(status: 'cancelled')
    purchase.destroy!
    render_success({ id: purchase.id, purchase_number: purchase.purchase_number }, 'Purchase was successfully deleted.')
  rescue ActiveRecord::RecordNotFound
    render_error('Purchase not found', nil, :not_found)
  end

  # PATCH /api/v1/admin/vendor_purchases/:id/complete — pending -> completed
  def complete
    purchase = VendorPurchase.find(params[:id])
    return render_error('Purchase cannot be completed.', ["Status is #{purchase.status}"]) unless purchase.status == 'pending'

    if purchase.update(status: 'completed')
      render_success(purchase_detail(purchase.id), 'Purchase marked as completed successfully.')
    else
      render_validation_errors(purchase)
    end
  rescue ActiveRecord::RecordNotFound
    render_error('Purchase not found', nil, :not_found)
  end

  # PATCH /api/v1/admin/vendor_purchases/:id/mark_paid — paid_amount = total_amount
  def mark_paid
    purchase = VendorPurchase.find(params[:id])
    return render_error('Purchase is already fully paid.') if purchase.payment_status == 'paid'

    if purchase.update(paid_amount: purchase.total_amount)
      render_success(purchase_detail(purchase.id), 'Purchase marked as fully paid successfully.')
    else
      render_validation_errors(purchase)
    end
  rescue ActiveRecord::RecordNotFound
    render_error('Purchase not found', nil, :not_found)
  end

  # POST /api/v1/admin/vendor_purchases/bulk_mark_paid  Body: { purchase_ids: [1, 2] }
  def bulk_mark_paid
    ids = Array(params[:purchase_ids]).reject(&:blank?)
    return render_error('Validation failed', ['purchase_ids is required']) if ids.empty?

    purchases = VendorPurchase.where(id: ids).where('COALESCE(paid_amount, 0) < COALESCE(total_amount, 0)').to_a
    return render_error('No unpaid purchases found to update') if purchases.empty?

    updated = []
    VendorPurchase.transaction do
      purchases.each { |p| updated << p.id if p.update(paid_amount: p.total_amount) }
    end
    render_success({ updated_count: updated.size, purchase_ids: updated },
                   "Successfully marked #{updated.size} purchase(s) as paid")
  end

  # POST /api/v1/admin/vendor_purchases/:id/generate_invoice
  # Creates the vendor invoice once (reused afterwards) and returns its public share link.
  def generate_invoice
    purchase = VendorPurchase.find(params[:id])
    invoice = purchase.vendor_invoice || purchase.create_vendor_invoice!(
      status: :sent,
      notes: "Invoice generated for vendor purchase ##{purchase.purchase_number}"
    )
    render_success({
      invoice_url: invoice.public_url,
      invoice_number: invoice.invoice_number,
      purchase_id: purchase.id,
      purchase_number: purchase.purchase_number,
      vendor_name: invoice.vendor_name
    }, 'Invoice generated successfully')
  rescue ActiveRecord::RecordNotFound
    render_error('Purchase not found', nil, :not_found)
  rescue ActiveRecord::RecordInvalid => e
    render_error('Error generating invoice', e.record.errors.full_messages)
  end

  # GET /api/v1/admin/vendor_purchases/batch_inventory
  # Stock batches (one per purchase line), oldest first like the web page.
  # Filters: search (product name), vendor_id, product_id, in_stock (true/false).
  def batch_inventory
    scope = StockBatch.all
    scope = scope.joins(:product).where('products.name ILIKE ?', "%#{StockBatch.sanitize_sql_like(params[:search].to_s.strip)}%") if params[:search].present?
    scope = scope.where(vendor_id: params[:vendor_id]) if params[:vendor_id].present?
    scope = scope.where(product_id: params[:product_id]) if params[:product_id].present?
    scope = scope.where('stock_batches.quantity_remaining > 0') if params[:in_stock] == 'true'
    scope = scope.where('stock_batches.quantity_remaining <= 0') if params[:in_stock] == 'false'

    batch_count, product_count, total_quantity, total_value = scope.pick(
      Arel.sql('COUNT(*)'),
      Arel.sql('COUNT(DISTINCT stock_batches.product_id)'),
      Arel.sql('COALESCE(SUM(stock_batches.quantity_remaining), 0)'),
      Arel.sql('COALESCE(SUM(stock_batches.quantity_remaining * stock_batches.purchase_price), 0)')
    )
    batches = paginate_scope(scope.includes(:product, :product_variant, :vendor).order(:batch_date, :created_at))

    render_success(
      summary: {
        total_batches: batch_count.to_i,
        total_products: product_count.to_i,
        total_quantity: total_quantity.to_f,
        total_stock_value: total_value.to_f
      },
      batches: batches.map { |b| batch_json(b) },
      pagination: pagination_meta(batches)
    )
  end

  # POST /api/v1/admin/vendor_purchases/mark_batches_sold  Body: { batch_ids: [1, 2] }
  # Manual write-off (damaged/lost/sold outside the system), same as web:
  # remaining quantity -> 0 and a StockMovement adjustment is logged per batch.
  def mark_batches_sold
    ids = Array(params[:batch_ids]).reject(&:blank?)
    return render_error('Validation failed', ['batch_ids is required']) if ids.empty?

    batches = StockBatch.where(id: ids).where('quantity_remaining > 0').to_a
    return render_error('Selected batches are already sold out or not found') if batches.empty?

    StockBatch.transaction do
      batches.each do |batch|
        before_qty = batch.quantity_remaining
        batch.update!(quantity_remaining: 0)
        StockMovement.create!(
          product_id: batch.product_id,
          reference_type: 'adjustment',
          reference_id: batch.id,
          movement_type: 'adjusted',
          quantity: -before_qty,
          stock_before: before_qty,
          stock_after: 0,
          notes: "Batch ##{batch.id} manually marked as sold by #{@current_user.email} (admin app)"
        )
      end
    end
    render_success({ updated_count: batches.size, batch_ids: batches.map(&:id) },
                   "Marked #{batches.size} batch(es) as sold")
  rescue ActiveRecord::RecordInvalid => e
    render_error('Error marking batches as sold', e.record.errors.full_messages)
  end

  def self.purchase_json(purchase, with_stock: false)
    {
      id: purchase.id,
      purchase_number: purchase.purchase_number,
      vendor: { id: purchase.vendor_id, name: purchase.vendor&.name },
      purchase_date: purchase.purchase_date,
      status: purchase.status,
      payment_status: purchase.payment_status,
      total_amount: purchase.total_amount.to_f,
      paid_amount: purchase.paid_amount.to_f,
      outstanding_amount: purchase.outstanding_amount.to_f,
      notes: purchase.notes,
      items_count: purchase.vendor_purchase_items.size,
      items: purchase.vendor_purchase_items.map do |item|
        row = {
          id: item.id,
          product_id: item.product_id,
          product_variant_id: item.product_variant_id,
          name: item.display_name,
          quantity: item.quantity.to_f,
          purchase_price: item.purchase_price.to_f,
          selling_price: item.selling_price.to_f,
          line_total: item.line_total.to_f,
          profit_margin: item.profit_margin.to_f
        }
        if with_stock
          row[:current_stock] = item.product_variant ? item.product_variant.available_stock.to_i : item.product.stock.to_i
        end
        row
      end,
      invoice_url: purchase.association(:vendor_invoice).loaded? ? purchase.vendor_invoice&.public_url : nil,
      created_at: purchase.created_at
    }
  end

  private

  def page_one?
    params[:page].blank? || params[:page].to_i <= 1
  end

  def purchase_detail(id)
    self.class.purchase_json(VendorPurchase.includes(*PURCHASE_INCLUDES).find(id), with_stock: true)
  end

  def batch_json(batch)
    {
      id: batch.id,
      batch_number: batch.batch_number,
      product_id: batch.product_id,
      product_name: batch.product&.name,
      product_variant_id: batch.product_variant_id,
      variant_label: batch.product_variant&.label,
      vendor: { id: batch.vendor_id, name: batch.vendor&.name },
      vendor_purchase_id: batch.vendor_purchase_id,
      batch_date: batch.batch_date,
      quantity_purchased: batch.quantity_purchased.to_f,
      quantity_remaining: batch.quantity_remaining.to_f,
      quantity_sold: batch.quantity_sold.to_f,
      purchase_price: batch.purchase_price.to_f,
      selling_price: batch.selling_price.to_f,
      stock_value: (batch.quantity_remaining.to_d * batch.purchase_price.to_d).to_f,
      status: batch.status
    }
  end

  def param_purchase_date(value)
    Date.iso8601(value.to_s)
  rescue Date::Error
    nil
  end

  # Checks the web form guarantees by construction (its product picker only
  # offers active products, and a variant entry for multi-quantity products).
  def item_error(item, index)
    label = "Item #{index + 1}"
    product = Product.find_by(id: item[:product_id])
    return "#{label}: product not found" unless product
    return "#{label}: product is not active" unless product.active?

    if item[:product_variant_id].present?
      return "#{label}: variant does not belong to this product" unless product.product_variants.exists?(id: item[:product_variant_id])
    elsif product.has_multiple_quantities? && product.product_variants.exists?
      return "#{label}: product_variant_id is required for #{product.name} (it has variants)"
    end

    quantity = item[:quantity].to_f
    purchase_price = item[:purchase_price].to_f
    selling_price = item[:selling_price].to_f
    return "#{label}: quantity must be greater than 0" unless quantity.positive?
    return "#{label}: purchase_price must be greater than 0" unless purchase_price.positive?
    return "#{label}: selling_price must be greater than purchase_price" unless selling_price > purchase_price

    nil
  end
end
