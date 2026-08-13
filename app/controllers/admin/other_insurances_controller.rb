class Admin::OtherInsurancesController < Admin::ApplicationController
  include ConfigurablePagination
  before_action :set_other_insurance, only: [:show, :edit, :update, :destroy]

  # Stat cards are read on every /admin/insurance/other request (this
  # controller has no search/filter params, so the relation is always the
  # same unfiltered scope). Rails.cache here is Solid Cache, backed by the
  # same cross-region Postgres as the primary DB, so a Rails.cache "hit"
  # still pays a full network round trip — no faster than an uncached query.
  # This in-process cache (see lib/local_ttl_cache.rb, same pattern already
  # used for the sidebar badge counts) makes a hit a plain Ruby hash read.
  STATS_LOCAL_CACHE = LocalTtlCache.new
  STATS_LOCAL_TTL = 1.minute

  def index
    @other_insurances = Policy.where(insurance_type: 'other')

    calculate_stats

    # No search scope exists on this controller (no join to worry about
    # colliding with), so :customer/:insurance_company can always be a single
    # JOIN query instead of a separate preload round trip — both are
    # belongs_to, so the JOIN can't fan out rows even with LIMIT/OFFSET applied.
    @other_insurances = @other_insurances.eager_load(:customer, :insurance_company)

    @other_insurances = paginate_records(@other_insurances.order(created_at: :desc), total_count: @stats_total_count)
  end

  def show
  end

  def new
    @other_insurance = Policy.new(insurance_type: 'other')
    load_form_data
  end

  def edit
    load_form_data
  end

  def create
    @other_insurance = Policy.new(other_insurance_params)
    @other_insurance.insurance_type = 'other'
    @other_insurance.user = current_user

    if @other_insurance.save
      redirect_to admin_other_insurance_path(@other_insurance), notice: 'Other insurance policy was successfully created.'
    else
      @customers = Customer.active.order(:first_name)
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @other_insurance.update(other_insurance_params)
      redirect_to admin_other_insurance_path(@other_insurance), notice: 'Other insurance policy was successfully updated.'
    else
      @customers = Customer.active.order(:first_name)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @other_insurance.destroy
    redirect_to admin_other_insurances_path, notice: 'Other insurance policy was successfully deleted.'
  end

  private

  def set_other_insurance
    @other_insurance = Policy.where(insurance_type: 'other').find(params[:id])
  end

  def load_form_data
    @customers = Customer.active.order(:first_name)
  end

  # Stat cards must be computed on the pre-pagination, filtered relation:
  # calling .count/.sum on an already-paginated (LIMIT/OFFSET) relation only
  # reflects the current page, not the full filtered set (Rails wraps such
  # calls in a subquery). All four numbers (including the old separate
  # .sum(&:total_premium) Ruby-side block and the "active" .where.count) are
  # collapsed into ONE query using Postgres's FILTER clause, and computed
  # before any customer/insurance_company join is added so the aggregate
  # query stays a single-table scan.
  def calculate_stats
    @stats_total_count, @stats_total_premium, @stats_total_coverage, @stats_active_count =
      STATS_LOCAL_CACHE.fetch('stats/unfiltered', STATS_LOCAL_TTL) do
        @other_insurances.pick(Arel.sql(<<~SQL.squish))
          COUNT(*),
          COALESCE(SUM(total_premium), 0),
          COALESCE(SUM(sum_insured), 0),
          COUNT(*) FILTER (WHERE status = 'active')
        SQL
      end
  end

  def other_insurance_params
    params.require(:policy).permit(
      :customer_id, :insurance_company_id, :policy_number, :policy_type,
      :sum_insured, :net_premium, :total_premium, :payment_mode, :gst_percentage,
      :policy_start_date, :policy_end_date, :policy_booking_date, :status, :note
    )
  end
end