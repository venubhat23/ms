class Admin::FranchiseStockRequestsController < Admin::ApplicationController
  include ConfigurablePagination
  before_action :ensure_franchise_commission_enabled
  before_action :set_stock_request, only: [:show, :approve, :reject]

  def index
    @stock_requests = FranchiseStockRequest.includes(:franchise).recent
    @stock_requests = @stock_requests.where(status: params[:status]) if params[:status].present?
    @stock_requests = paginate_records(@stock_requests)

    stats_row = FranchiseStockRequest.pick(
      Arel.sql("COUNT(*)"),
      Arel.sql("COUNT(*) FILTER (WHERE status = 'pending')"),
      Arel.sql("COUNT(*) FILTER (WHERE status = 'approved')"),
      Arel.sql("COUNT(*) FILTER (WHERE status = 'rejected')")
    )
    total, pending, approved, rejected = stats_row
    @stats = { total: total, pending: pending, approved: approved, rejected: rejected }
  end

  def show
    items = @stock_request.items.to_a
    product_ids = items.map(&:product_id).uniq
    variant_ids = items.map(&:product_variant_id).compact.uniq

    @central_stock_by_product = StockBatch.where(status: "active", product_id: product_ids, store_id: nil)
                                           .group(:product_id).sum(:quantity_remaining)
    @central_stock_by_variant = variant_ids.any? ? ProductVariant.where(id: variant_ids).pluck(:id, :available_stock).to_h : {}
  end

  def approve
    # Pricing is fully automatic now — Product#b2b_price (see
    # FranchiseStockRequest#pricing_preview / resolved_unit_price) replaces
    # the manual discount picker that used to live on this screen.
    if @stock_request.approve!(current_user)
      redirect_to admin_franchise_stock_request_path(@stock_request), notice: "Request approved — a Franchise Booking was created and stock credited to the franchise's inventory."
    else
      redirect_to admin_franchise_stock_request_path(@stock_request), alert: @stock_request.errors.full_messages.to_sentence.presence || "Only pending requests can be approved."
    end
  end

  def reject
    if @stock_request.reject!(current_user, params[:reason])
      redirect_to admin_franchise_stock_request_path(@stock_request), notice: "Request rejected."
    else
      redirect_to admin_franchise_stock_request_path(@stock_request), alert: "Only pending requests can be rejected."
    end
  end

  private def ensure_franchise_commission_enabled
    unless SystemSetting.franchise_commission_enabled?
      redirect_to admin_settings_system_path, alert: "Enable the Franchise Commission feature (Settings > System > Store Settings) to manage franchise stock requests."
    end
  end

  def set_stock_request
    @stock_request = FranchiseStockRequest.includes(:franchise, items: [:product, :product_variant]).find(params[:id])
  end
end
