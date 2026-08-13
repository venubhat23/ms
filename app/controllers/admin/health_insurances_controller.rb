class Admin::HealthInsurancesController < Admin::ApplicationController
  include ConfigurablePagination
  before_action :set_health_insurance, only: [:show, :edit, :update, :destroy]
  before_action :load_form_data, only: [:new, :edit, :create, :update]

  # Stat cards for the default (no search) view are read on almost every
  # /admin/insurance/health request. Rails.cache here is Solid Cache, backed
  # by the same cross-region Postgres as the primary DB, so a Rails.cache
  # "hit" still pays a full network round trip — no faster than an uncached
  # query. This in-process cache (see lib/local_ttl_cache.rb, same pattern
  # already used for the sidebar badge counts) makes a hit a plain Ruby hash
  # read. Only usable for the unfiltered case — the key space is unbounded
  # once a search term is involved, so filtered stats are always computed live.
  STATS_LOCAL_CACHE = LocalTtlCache.new
  STATS_LOCAL_TTL = 1.minute

  def index
    @health_insurances = HealthInsurance.all

    # Search functionality
    if params[:search].present?
      @health_insurances = @health_insurances.search_health_policies(params[:search])
    end

    calculate_stats

    # sub_agent/agency_code/broker are never rendered on the index list (only
    # on show/edit), so preloading them was 3 wasted round trips per load —
    # dropped entirely. For :customer: no search means a single JOIN query
    # beats a separate preload round trip (customer is belongs_to, so the
    # JOIN can't fan out rows even with LIMIT/OFFSET applied). With search,
    # pg_search's own join against customers can't safely share the query
    # with a second eager_load join to the same table, so fall back to a
    # preload there.
    @health_insurances = params[:search].present? ? @health_insurances.includes(:customer) : @health_insurances.eager_load(:customer)

    @health_insurances = paginate_records(@health_insurances.order(created_at: :desc), total_count: @stats_total_count)
  end

  def show
  end

  def new
    @health_insurance = HealthInsurance.new
    @health_insurance.health_insurance_members.build
  end

  def edit
  end

  def create
    @health_insurance = HealthInsurance.new(health_insurance_params)

    # Set admin tracking fields for policies created from admin panel
    @health_insurance.policy_added_by_admin = true
    @health_insurance.is_admin_added = true
    @health_insurance.is_customer_added = false
    @health_insurance.is_agent_added = false

    set_distributor_from_affiliate(@health_insurance)

    if @health_insurance.save
      redirect_to admin_health_insurance_path(@health_insurance), notice: 'Health insurance policy was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @health_insurance.assign_attributes(health_insurance_params)
    set_distributor_from_affiliate(@health_insurance)

    if @health_insurance.save
      redirect_to admin_health_insurance_path(@health_insurance), notice: 'Health insurance policy was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @health_insurance.destroy
    redirect_to admin_health_insurances_path, notice: 'Health insurance policy was successfully deleted.'
  end

  # AJAX endpoint for getting policy holder options based on customer
  def policy_holder_options
    customer = Customer.find(params[:customer_id]) if params[:customer_id].present?
    options = [['Self', 'Self']]

    if customer&.family_members&.any?
      customer.family_members.each do |member|
        options << [member.full_name, member.id.to_s]
      end
    end

    render json: { options: options }
  end

  private

  def set_health_insurance
    @health_insurance = HealthInsurance.find(params[:id])
  end

  # Stat cards must be computed on the pre-pagination, filtered relation:
  # calling .count/.sum on an already-paginated (LIMIT/OFFSET) relation only
  # reflects the current page, not the full filtered set (Rails wraps such
  # calls in a subquery). All four numbers (including the old separate
  # .sum(&:total_premium) Ruby-side block and the "expiring soon" .where.count)
  # are collapsed into ONE query using Postgres's FILTER clause, and computed
  # before any customer join is added so the aggregate query stays a
  # single-table scan.
  def calculate_stats
    cutoff = HealthInsurance.sanitize_sql_array(['?', 30.days.from_now])
    sql = <<~SQL.squish
      COUNT(*),
      COALESCE(SUM(total_premium), 0),
      COALESCE(SUM(sum_insured), 0),
      COUNT(*) FILTER (WHERE policy_end_date <= #{cutoff})
    SQL

    @stats_total_count, @stats_total_premium, @stats_total_coverage, @stats_expiring_soon_count =
      if params[:search].present?
        @health_insurances.pick(Arel.sql(sql))
      else
        STATS_LOCAL_CACHE.fetch('stats/unfiltered', STATS_LOCAL_TTL) { @health_insurances.pick(Arel.sql(sql)) }
      end
  end

  def load_form_data
    @customers = Customer.active.order(:first_name, :last_name, :company_name)
    @sub_agents = SubAgent.active.order(:first_name, :last_name)
    @distributors = Distributor.active.order(:first_name, :last_name)
    @investors = Investor.active.order(:first_name, :last_name)
    @agency_codes = AgencyCode.where(insurance_type: 'Health')
    @brokers = Broker.active.order(:name)
    @insurance_companies = InsuranceCompanyHelper.company_names
  end

  def health_insurance_params
    params.require(:health_insurance).permit(
      :customer_id, :sub_agent_id, :distributor_id, :investor_id, :agency_code_id, :broker_id,
      :policy_holder, :insurance_company_name, :policy_type, :insurance_type,
      :plan_name, :policy_number, :policy_booking_date, :policy_start_date,
      :policy_end_date, :policy_term, :payment_mode, :claim_process,
      :sum_insured, :net_premium, :gst_percentage, :total_premium,
      :main_agent_commission_percentage, :commission_amount, :tds_percentage,
      :tds_amount, :after_tds_value, :reference_by_name,
      :installment_autopay_start_date, :installment_autopay_end_date,
      health_insurance_members_attributes: [:id, :member_name, :age, :relationship, :sum_insured, :_destroy],
      documents: [], policy_documents: []
    )
  end

  def set_distributor_from_affiliate(insurance_record)
    # If affiliate is selected but distributor is not set, auto-assign distributor
    if insurance_record.sub_agent_id.present? && insurance_record.distributor_id.blank?
      sub_agent = SubAgent.find(insurance_record.sub_agent_id)

      # Use direct distributor relationship first, then fall back to assignment
      distributor_id = sub_agent.distributor_id || sub_agent.assigned_distributor&.id

      insurance_record.distributor_id = distributor_id if distributor_id.present?
    end
  rescue StandardError => e
    # Log error but don't fail the form submission
    Rails.logger.error "Failed to set distributor from affiliate: #{e.message}"
  end
end