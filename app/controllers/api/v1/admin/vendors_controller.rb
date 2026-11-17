class Api::V1::Admin::VendorsController < Api::V1::Admin::BaseController
  # GET /api/v1/admin/vendors
  # Same list as the web Admin::VendorsController#index.
  # Filters: search (name/phone/email), status (true/false), payment_type (Cash/Credit)
  def index
    scope = Vendor.all
    if params[:search].present?
      term = "%#{Vendor.sanitize_sql_like(params[:search].to_s.strip)}%"
      scope = scope.where('vendors.name ILIKE :t OR vendors.phone ILIKE :t OR vendors.email ILIKE :t', t: term)
    end
    scope = scope.where(status: ActiveModel::Type::Boolean.new.cast(params[:status])) if params[:status].present?
    scope = scope.where(payment_type: params[:payment_type]) if params[:payment_type].present?

    status_counts = scope.group(:status).count
    vendors = paginate_scope(scope.with_purchase_totals.order(created_at: :desc))

    render_success(
      summary: {
        total_vendors: status_counts.values.sum,
        active_vendors: status_counts[true] || 0,
        inactive_vendors: status_counts[false] || 0
      },
      vendors: vendors.map { |v| vendor_row(v) },
      pagination: pagination_meta(vendors)
    )
  end

  # GET /api/v1/admin/vendors/:id
  # Vendor, its stock still on hand (active batches) and recent purchases,
  # same as the web vendor show page.
  def show
    vendor = Vendor.with_purchase_totals.find(params[:id])
    limit = (params[:purchases_limit] || 10).to_i.clamp(1, 100)
    purchases = vendor.vendor_purchases.includes(vendor_purchase_items: [:product, :product_variant]).recent.limit(limit)

    render_success(
      vendor_row(vendor).merge(
        address: vendor.address,
        stock_summary: stock_summary(vendor),
        recent_purchases: purchases.map { |p| Api::V1::Admin::VendorPurchasesController.purchase_json(p) }
      )
    )
  rescue ActiveRecord::RecordNotFound
    render_error('Vendor not found', nil, :not_found)
  end

  # POST /api/v1/admin/vendors
  # Body: { name, phone, email, address, payment_type (Cash/Credit), opening_balance, status }
  # (may also be wrapped in "vendor": { ... })
  def create
    vendor = Vendor.new(vendor_params)
    vendor.status = true if vendor_params[:status].nil?
    vendor.payment_type ||= 'Cash'
    if vendor.save
      render_success(vendor_detail(vendor.id), 'Vendor was successfully created.', :created)
    else
      render_validation_errors(vendor)
    end
  end

  # PATCH /api/v1/admin/vendors/:id  — send only the fields to change
  def update
    vendor = Vendor.find(params[:id])
    if vendor.update(vendor_params)
      render_success(vendor_detail(vendor.id), 'Vendor was successfully updated.')
    else
      render_validation_errors(vendor)
    end
  rescue ActiveRecord::RecordNotFound
    render_error('Vendor not found', nil, :not_found)
  end

  # DELETE /api/v1/admin/vendors/:id — only vendors with no purchases (same as web)
  def destroy
    vendor = Vendor.find(params[:id])
    return render_error('Cannot delete vendor with existing purchases.') unless vendor.can_be_deleted?

    vendor.destroy!
    render_success({ id: vendor.id }, 'Vendor was successfully deleted.')
  rescue ActiveRecord::RecordNotFound
    render_error('Vendor not found', nil, :not_found)
  end

  # PATCH /api/v1/admin/vendors/:id/toggle_status — active <-> inactive
  def toggle_status
    vendor = Vendor.find(params[:id])
    vendor.update!(status: !vendor.status)
    render_success(vendor_detail(vendor.id), "Vendor #{vendor.status ? 'activated' : 'deactivated'} successfully")
  rescue ActiveRecord::RecordNotFound
    render_error('Vendor not found', nil, :not_found)
  end

  # PATCH /api/v1/admin/vendors/:id/mark_paid
  # Same as web "Mark as Paid": every unpaid purchase gets paid_amount = total
  # and the opening balance is cleared, so outstanding becomes 0.
  def mark_paid
    vendor = Vendor.find(params[:id])
    vendor.mark_as_paid!
    render_success(vendor_detail(vendor.id), "#{vendor.name} marked as paid.")
  rescue ActiveRecord::RecordNotFound
    render_error('Vendor not found', nil, :not_found)
  rescue ActiveRecord::RecordInvalid => e
    render_error("Could not mark #{vendor.name} as paid", e.record.errors.full_messages)
  end

  # POST /api/v1/admin/vendors/bulk_mark_paid  Body: { vendor_ids: [1, 2] }
  # Vendors with nothing outstanding are skipped.
  def bulk_mark_paid
    ids = Array(params[:vendor_ids]).reject(&:blank?)
    return render_error('Validation failed', ['vendor_ids is required']) if ids.empty?

    vendors = Vendor.where(id: ids).with_purchase_totals.select { |v| v.outstanding_balance.positive? }
    return render_error('No vendors with dues were selected.') if vendors.empty?

    paid = []
    failures = []
    vendors.each do |vendor|
      vendor.mark_as_paid!
      paid << vendor.id
    rescue ActiveRecord::RecordInvalid => e
      failures << "#{vendor.name} (#{e.record.errors.full_messages.to_sentence})"
    end

    render_success({ updated_count: paid.size, vendor_ids: paid, failures: failures },
                   "Marked #{paid.size} vendor(s) as paid.")
  end

  private

  def vendor_params
    source = params[:vendor].is_a?(ActionController::Parameters) ? params[:vendor] : params
    source.permit(:name, :phone, :email, :address, :payment_type, :opening_balance, :status)
  end

  def vendor_detail(id)
    vendor = Vendor.with_purchase_totals.find(id)
    vendor_row(vendor).merge(address: vendor.address)
  end

  # InventoryService#vendor_stock_summary returns decimals, which JSON-encode as strings.
  def stock_summary(vendor)
    summary = InventoryService.new.vendor_stock_summary(vendor)
    summary.merge(
      total_quantity: summary[:total_quantity].to_f,
      total_value: summary[:total_value].to_f,
      products_summary: summary[:products_summary].map { |row| row.merge(total_quantity: row[:total_quantity].to_f) }
    )
  end

  def vendor_row(vendor)
    {
      id: vendor.id,
      name: vendor.name,
      phone: vendor.phone,
      email: vendor.email,
      payment_type: vendor.payment_type,
      status: vendor.status,
      status_text: vendor.status_text,
      opening_balance: vendor.opening_balance.to_f,
      purchases_count: vendor.purchases_count,
      total_purchases: vendor.total_purchases.to_f,
      total_paid: vendor.total_paid.to_f,
      outstanding_balance: vendor.outstanding_balance.to_f,
      created_at: vendor.created_at
    }
  end
end
