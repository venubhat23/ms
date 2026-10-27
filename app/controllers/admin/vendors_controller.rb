class Admin::VendorsController < Admin::ApplicationController
  before_action :authenticate_user!
  before_action :set_vendor, only: [:show, :edit, :update, :destroy, :toggle_status, :mark_paid]
  layout 'application'

  def index
    scope = Vendor.all
    scope = scope.where(id: params[:vendor_id]) if params[:vendor_id].present?
    if params[:search].present?
      term = "%#{Vendor.sanitize_sql_like(params[:search].to_s.strip)}%"
      scope = scope.where('vendors.name ILIKE :t OR vendors.phone ILIKE :t OR vendors.email ILIKE :t', t: term)
    end
    scope = scope.where(status: params[:status]) if params[:status].present?
    scope = scope.where(payment_type: params[:payment_type]) if params[:payment_type].present?

    # Fired together so their round trips overlap: the status counts (one
    # grouped query covering both stat cards) and the compact vendor list
    # that feeds the searchable vendor dropdown.
    status_counts = scope.group(:status).async_count
    vendor_options = Vendor.order(:name).async_pluck(:id, :name, :phone, :status, :payment_type)

    # Purchase count/total/paid come back with each vendor row
    # (with_purchase_totals) instead of loading every purchase record.
    @vendors = scope.with_purchase_totals
                    .order(created_at: :desc)
                    .page(params[:page]).per(20)

    status_counts = status_counts.value
    @total_vendor_count  = status_counts.values.sum
    @active_vendor_count = status_counts[true] || 0
    @vendor_options = vendor_options.value

    respond_to do |format|
      format.html
      format.json { render json: @vendors }
    end
  end

  def show
    @purchases = @vendor.vendor_purchases.includes(:vendor_purchase_items).recent.limit(10).load
    @stock_summary = InventoryService.new.vendor_stock_summary(@vendor)
  end

  def new
    @vendor = Vendor.new
  end

  def edit
  end

  def create
    @vendor = Vendor.new(vendor_params)

    if @vendor.save
      respond_to do |format|
        format.html { redirect_to admin_vendor_path(@vendor), notice: 'Vendor was successfully created.' }
        format.json { render json: { success: true, vendor: { id: @vendor.id, name: @vendor.name } } }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { success: false, errors: @vendor.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @vendor.update(vendor_params)
      redirect_to admin_vendor_path(@vendor),
                  notice: 'Vendor was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @vendor.can_be_deleted?
      @vendor.destroy
      redirect_to admin_vendors_path, notice: 'Vendor was successfully deleted.'
    else
      redirect_to admin_vendor_path(@vendor),
                  alert: 'Cannot delete vendor with existing purchases.'
    end
  end

  def toggle_status
    @vendor.update(status: !@vendor.status)
    status_text = @vendor.status? ? 'activated' : 'deactivated'

    respond_to do |format|
      format.html {
        redirect_to admin_vendors_path,
        notice: "Vendor was successfully #{status_text}."
      }
      format.json {
        render json: {
          status: 'success',
          message: "Vendor #{status_text} successfully",
          new_status: @vendor.status
        }
      }
    end
  end

  def mark_paid
    @vendor.mark_as_paid!
    redirect_back fallback_location: admin_vendors_path, notice: "#{@vendor.name} marked as paid."
  rescue ActiveRecord::RecordInvalid => e
    redirect_back fallback_location: admin_vendors_path, alert: "Could not mark #{@vendor.name} as paid: #{e.record.errors.full_messages.to_sentence}"
  end

  def bulk_mark_paid
    vendors = Vendor.where(id: Array(params[:vendor_ids]).reject(&:blank?)).with_purchase_totals
                    .select { |v| v.outstanding_balance.positive? }
    if vendors.empty?
      redirect_to admin_vendors_path, alert: 'No vendors with dues were selected.'
      return
    end

    failures = []
    vendors.each do |vendor|
      vendor.mark_as_paid!
    rescue ActiveRecord::RecordInvalid => e
      failures << "#{vendor.name} (#{e.record.errors.full_messages.to_sentence})"
    end

    paid_count = vendors.size - failures.size
    if failures.any?
      redirect_to admin_vendors_path, alert: "Marked #{paid_count} vendor(s) as paid. Failed: #{failures.join(', ')}"
    else
      redirect_to admin_vendors_path, notice: "Marked #{paid_count} vendor(s) as paid."
    end
  end

  private

  def set_vendor
    @vendor = Vendor.find(params[:id])
  end

  def vendor_params
    params.require(:vendor).permit(:name, :phone, :email, :address,
                                   :payment_type, :opening_balance, :status)
  end
end
