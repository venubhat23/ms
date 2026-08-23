class Franchise::StockRequestsController < Franchise::BaseController
  before_action :ensure_franchise_commission_enabled
  before_action :set_stock_request, only: [:show]

  def index
    @stock_requests = current_franchise.franchise_stock_requests
                                        .select(:id, :status, :items_count, :discount_amount, :created_at, :reviewed_at, :booking_id)
                                        .recent.page(params[:page]).per(20)

    status_counts = current_franchise.franchise_stock_requests.group(:status).count
    @pending_count  = status_counts["pending"]  || 0
    @approved_count = status_counts["approved"] || 0
    @rejected_count = status_counts["rejected"] || 0
  end

  def new
    @stock_request = current_franchise.franchise_stock_requests.new
    @products_json = cached_products_json
  end

  def create
    @stock_request = current_franchise.franchise_stock_requests.new(stock_request_params)

    if @stock_request.save
      redirect_to franchise_stock_requests_path, notice: "Stock request submitted. An admin will review it shortly."
    else
      flash.now[:alert] = @stock_request.errors.full_messages.to_sentence
      @products_json = cached_products_json
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def set_stock_request
    @stock_request = current_franchise.franchise_stock_requests
                                       .includes(:booking, items: [:product, :product_variant])
                                       .find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to franchise_stock_requests_path, alert: "Request not found"
  end

  def stock_request_params
    params.require(:franchise_stock_request).permit(
      :notes,
      items_attributes: [:product_id, :product_variant_id, :quantity]
    )
  end

  # Full catalog (every active product, regardless of what's currently in
  # this franchise's own inventory) so a franchise can request anything —
  # cached as a pre-built JSON string, shared across every franchise, since
  # it's identical for all of them and rarely changes. Caching the finished
  # JSON string (not ActiveRecord objects) sidesteps ActiveModel::MissingAttributeError
  # on cache hits that a partial-select + Marshal round trip would risk.
  def cached_products_json
    Rails.cache.fetch("franchise_stock_requests/products_json", expires_in: 5.minutes) do
      products = Product.active
                         .select(:id, :name, :sku, :category_id, :has_multiple_quantities, :r2_image_url, :image_url, :price, :display_order)
                         .includes(:category, :product_variants, image_attachment: :blob)
                         .order(:display_order, :name)

      products.map do |p|
        sorted_variants = p.has_multiple_quantities ? p.product_variants.sort_by { |v| [v.display_order.to_i, v.weight.to_f] } : []
        {
          id: p.id,
          name: p.name,
          sku: p.sku.to_s,
          category_id: p.category_id&.to_s || "",
          category_name: p.category&.name || "No Category",
          has_variants: p.has_multiple_quantities,
          image_url: p.main_image_url,
          price: p.price.to_f.round,
          variants: sorted_variants.map { |v| { id: v.id, label: v.label.to_s, price: v.selling_price.to_f.round } }
        }
      end.to_json
    end
  end
end
