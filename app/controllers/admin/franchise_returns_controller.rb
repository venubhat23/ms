class Admin::FranchiseReturnsController < Admin::ApplicationController
  include ConfigurablePagination
  before_action :set_franchise_return, only: [:show, :approve, :reject]

  def index
    @franchise_returns = FranchiseReturn.includes(:franchise).recent
    @franchise_returns = @franchise_returns.where(status: params[:status]) if params[:status].present?
    @franchise_returns = paginate_records(@franchise_returns)

    stats_row = FranchiseReturn.pick(
      Arel.sql("COUNT(*)"),
      Arel.sql("COUNT(*) FILTER (WHERE status = 'pending')"),
      Arel.sql("COUNT(*) FILTER (WHERE status = 'approved')"),
      Arel.sql("COUNT(*) FILTER (WHERE status = 'rejected')")
    )
    total, pending, approved, rejected = stats_row
    @stats = { total: total.to_i, pending: pending.to_i, approved: approved.to_i, rejected: rejected.to_i }
  end

  def new
    @franchise_return = FranchiseReturn.new
    @franchises = Franchise.active.select(:id, :name, :mobile, :status, :commission_percentage).order(:name)
    @products_json = cached_products_json
  end

  def create
    @franchise_return = FranchiseReturn.new(franchise_return_params)

    if @franchise_return.save
      redirect_to admin_franchise_returns_path, notice: "Franchise return submitted."
    else
      @franchises = Franchise.active.select(:id, :name, :mobile, :status, :commission_percentage).order(:name)
      @products_json = cached_products_json
      flash.now[:alert] = @franchise_return.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def approve
    if @franchise_return.approve!(current_user)
      redirect_to admin_franchise_return_path(@franchise_return), notice: "Return approved — stock credited back to the main store and the franchise wallet credited."
    else
      redirect_to admin_franchise_return_path(@franchise_return), alert: @franchise_return.errors.full_messages.to_sentence.presence || "Only pending returns can be approved."
    end
  end

  def reject
    if @franchise_return.reject!(current_user, params[:reason])
      redirect_to admin_franchise_return_path(@franchise_return), notice: "Return rejected."
    else
      redirect_to admin_franchise_return_path(@franchise_return), alert: "Only pending returns can be rejected."
    end
  end

  private

  def set_franchise_return
    @franchise_return = FranchiseReturn.includes(:franchise, items: :product).find(params[:id])
  end

  def franchise_return_params
    params.require(:franchise_return).permit(
      :franchise_id, :notes,
      items_attributes: [:product_id, :quantity, :unit_price]
    )
  end

  # Full catalog, each product's B2B price pre-baked in as the per-unit
  # return credit. Products with no b2b_price set are excluded entirely
  # rather than silently falling back to the regular selling price (see
  # Product#effective_b2b_price) — a return must always be valued at what
  # the franchise actually paid, never the higher retail price.
  def cached_products_json
    Rails.cache.fetch("franchise_returns/products_json_b2b_only", expires_in: 5.minutes) do
      products = Product.active
                         .where.not(b2b_price: nil)
                         .includes(:category, image_attachment: :blob)
                         .order(:display_order, :name)

      products.map do |p|
        {
          id: p.id,
          name: p.name,
          sku: p.sku.to_s,
          category_id: p.category_id&.to_s || "",
          category_name: p.category&.name || "No Category",
          image_url: p.main_image_url,
          price: p.b2b_price.to_f.round(2)
        }
      end.to_json
    end
  end
end
