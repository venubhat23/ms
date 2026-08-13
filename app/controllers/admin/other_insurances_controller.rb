class Admin::OtherInsurancesController < Admin::ApplicationController
  include ConfigurablePagination
  before_action :set_other_insurance, only: [:show, :edit, :update, :destroy]

  def index
    @other_insurances = Policy.where(insurance_type: 'other').includes(:customer, :insurance_company)

    calculate_stats

    @other_insurances = paginate_records(@other_insurances.order(created_at: :desc))
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
  # calls in a subquery). This also replaces the old .sum(&:total_premium)
  # block form, which forced loading every matching row into Ruby objects
  # just to add them up, with a single SQL SUM.
  def calculate_stats
    @stats_total_count, @stats_total_premium, @stats_total_coverage =
      @other_insurances.pick(Arel.sql('COUNT(*), COALESCE(SUM(total_premium), 0), COALESCE(SUM(sum_insured), 0)'))
    @stats_active_count = @other_insurances.where(status: 'active').count
  end

  def other_insurance_params
    params.require(:policy).permit(
      :customer_id, :insurance_company_id, :policy_number, :policy_type,
      :sum_insured, :net_premium, :total_premium, :payment_mode, :gst_percentage,
      :policy_start_date, :policy_end_date, :policy_booking_date, :status, :note
    )
  end
end