class Admin::FranchisesController < Admin::ApplicationController
  include ConfigurablePagination
  before_action :set_franchise, only: [:show, :edit, :update, :destroy, :toggle_status, :reset_password]

  def index
    franchises_scope = Franchise.all
    franchises_scope = franchises_scope.where("name ILIKE ? OR email ILIKE ? OR contact_person_name ILIKE ?",
                                   "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
    franchises_scope = franchises_scope.where(status: params[:status]) if params[:status].present?

    # Computed once from the filtered scope, before pagination truncates it —
    # the view used to independently re-query @franchises 4 more times for
    # these same numbers (and disagreed with this controller's old unfiltered
    # @stats whenever a search/status filter was active).
    status_counts = franchises_scope.group(:status).count
    @stats = {
      total: status_counts.values.sum,
      active: status_counts[true] || 0,
      inactive: status_counts[false] || 0,
      this_month: franchises_scope.where('created_at >= ?', 1.month.ago).count
    }

    @franchises = paginate_records(franchises_scope.order(:name))
  end

  def show
    if SystemSetting.franchise_commission_enabled?
      @franchise_wallet = @franchise.franchise_wallet || @franchise.create_franchise_wallet!(balance: 0)
      @franchise_wallet_transactions = @franchise_wallet.franchise_wallet_transactions.recent.limit(10)
      @franchise_inventories = @franchise.franchise_inventories.includes(:product).references(:product).order('products.name')
    end
  end

  def new
    @franchise = Franchise.new
  end

  def create
    @franchise = Franchise.new(franchise_params)

    if @franchise.save
      # The model's after_create callback will handle user creation
      password = @franchise.auto_generated_password
      flash[:success] = "Franchise created successfully! Login credentials - Username: #{@franchise.email}, Password: #{password}"
      redirect_to admin_franchises_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @franchise.update(franchise_params)
      redirect_to admin_franchise_path(@franchise), notice: 'Franchise was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @franchise.destroy
    redirect_to admin_franchises_path, notice: 'Franchise was successfully deleted.'
  end

  def toggle_status
    @franchise.update!(status: !@franchise.status)
    redirect_to admin_franchises_path, notice: "Franchise #{@franchise.status? ? 'activated' : 'deactivated'} successfully."
  end

  def reset_password
    new_password = Franchise.generate_random_password

    if @franchise.user&.update(password: new_password, password_confirmation: new_password)
      @franchise.update(auto_generated_password: new_password)
      redirect_to admin_franchise_path(@franchise), notice: "Password reset successfully. New password: #{new_password}"
    else
      redirect_to admin_franchise_path(@franchise), alert: 'Failed to reset password.'
    end
  end

  private

  def set_franchise
    @franchise = Franchise.find(params[:id])
  end

  def franchise_params
    params.require(:franchise).permit(
      :name, :email, :mobile, :contact_person_name, :business_type,
      :address, :city, :state, :pincode, :pan_no, :gst_no, :license_no,
      :establishment_date, :territory, :franchise_fee, :commission_percentage,
      :status, :notes, :longitude, :latitude, :whatsapp_number
    )
  end

end
