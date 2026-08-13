class Admin::CouponsController < Admin::ApplicationController
  include ConfigurablePagination
  before_action :set_coupon, only: [:show, :edit, :update, :destroy, :toggle_status]

  def index
    @coupons = Coupon.all
    @coupons = @coupons.search(params[:search]) if params[:search].present?
    @coupons = case params[:filter]
               when 'active' then @coupons.active
               when 'inactive' then @coupons.inactive
               when 'expired' then @coupons.expired
               when 'upcoming' then @coupons.upcoming
               else @coupons
               end
    @coupons = paginate_records(@coupons.order(created_at: :desc))

    # active/expired/upcoming aren't a single-column partition (a coupon can
    # be both active and expired at once), so this can't collapse to
    # .group(:status).count like leads/sub_agents/orders — but the 4 counts
    # can still fold into 1 query via conditional aggregation instead of 4
    # separate COUNT(*) round trips.
    begin
      now = Coupon.connection.quote(Time.current)
      row = Coupon.select(
        "COUNT(*) AS total_count, " \
        "COUNT(CASE WHEN status = true THEN 1 END) AS active_count, " \
        "COUNT(CASE WHEN valid_until < #{now} THEN 1 END) AS expired_count, " \
        "COUNT(CASE WHEN valid_from > #{now} THEN 1 END) AS upcoming_count"
      ).take
      @stats = {
        total: row.total_count.to_i,
        active: row.active_count.to_i,
        expired: row.expired_count.to_i,
        upcoming: row.upcoming_count.to_i
      }
    rescue
      @stats = {
        total: Coupon.count,
        active: Coupon.active.count,
        expired: Coupon.expired.count,
        upcoming: Coupon.upcoming.count
      }
    end
  end

  def show
  end

  def new
    @coupon = Coupon.new
  end

  def edit
  end

  def create
    @coupon = Coupon.new(coupon_params)

    if @coupon.save
      redirect_to admin_coupons_path, notice: 'Coupon was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @coupon.update(coupon_params)
      redirect_to admin_coupons_path, notice: 'Coupon was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @coupon.destroy
    redirect_to admin_coupons_path, notice: 'Coupon was successfully deleted.'
  end

  def toggle_status
    @coupon.update(status: !@coupon.status)
    redirect_to admin_coupons_path, notice: "Coupon status updated to #{@coupon.status ? 'Active' : 'Inactive'}."
  end

  private

  def set_coupon
    @coupon = Coupon.find(params[:id])
  end

  def coupon_params
    params.require(:coupon).permit(
      :code, :description, :discount_type, :discount_value,
      :minimum_amount, :maximum_discount, :usage_limit,
      :valid_from, :valid_until, :status,
      :applicable_products, :applicable_categories
    )
  end
end