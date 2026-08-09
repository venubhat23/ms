class Admin::InsuranceCompaniesController < Admin::ApplicationController
  before_action :set_insurance_company, only: [:show, :edit, :update, :destroy]

  def index
    scope = InsuranceCompany.all
    @insurance_companies = scope.order(:name).page(params[:page])

    # One grouped query for both header stats instead of 3 separate .count
    # round trips (the view previously queried "active" twice) — also fixes
    # those counts being capped at the per-page limit, since a bare .count on
    # a .page()'d relation counts only the current page, not the true total.
    status_counts = scope.group(:status).count
    @insurance_companies_total  = status_counts.values.sum
    @insurance_companies_active = status_counts[true] || 0
  rescue NameError
    # Handle case where InsuranceCompany model doesn't exist yet
    redirect_to admin_customers_path, alert: 'Insurance Companies functionality not yet implemented.'
  end

  def show
  end

  def new
    @insurance_company = InsuranceCompany.new
  rescue NameError
    redirect_to admin_customers_path, alert: 'Insurance Companies functionality not yet implemented.'
  end

  def edit
  end

  def create
    @insurance_company = InsuranceCompany.new(insurance_company_params)

    if @insurance_company.save
      redirect_to admin_insurance_company_path(@insurance_company), notice: 'Insurance company was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  rescue NameError
    redirect_to admin_customers_path, alert: 'Insurance Companies functionality not yet implemented.'
  end

  def update
    if @insurance_company.update(insurance_company_params)
      redirect_to admin_insurance_company_path(@insurance_company), notice: 'Insurance company was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @insurance_company.destroy
    redirect_to admin_insurance_companies_path, notice: 'Insurance company was successfully deleted.'
  end

  private

  def set_insurance_company
    @insurance_company = InsuranceCompany.find(params[:id])
  rescue NameError
    redirect_to admin_customers_path, alert: 'Insurance Companies functionality not yet implemented.'
  end

  def insurance_company_params
    params.require(:insurance_company).permit(:name, :code, :contact_person, :email, :mobile, :address, :status)
  end
end