class Admin::AffiliatesController < Admin::ApplicationController
  include ConfigurablePagination
  before_action :set_affiliate, only: [:show, :edit, :update, :destroy, :toggle_status, :reset_password]

  def index
    @affiliates = Affiliate.all
    @affiliates = @affiliates.where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?",
                                   "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
    @affiliates = @affiliates.where(status: params[:status]) if params[:status].present?
    @affiliates = paginate_records(@affiliates.order(:first_name))

    # Single aggregate query (FILTER clauses) instead of a grouped count plus
    # a separate this_month count, since each query is a full round trip to
    # the (remote) DB. Cached like admin_customers/admin_bookings stats — a
    # cache hit skips that round trip entirely. Not scoped to search/status
    # since this query already ignores those filters (always counts all
    # affiliates), matching the pre-existing behavior.
    @stats = Rails.cache.fetch('admin_affiliates/stats', expires_in: 1.minute) do
      stats_row = Affiliate.pick(
        Arel.sql('COUNT(*)'),
        Arel.sql('COUNT(*) FILTER (WHERE status = TRUE)'),
        Arel.sql('COUNT(*) FILTER (WHERE status = FALSE)'),
        Arel.sql(Affiliate.sanitize_sql_array(['COUNT(*) FILTER (WHERE created_at >= ?)', 1.month.ago]))
      )
      total, active, inactive, this_month = stats_row
      { total: total, active: active, inactive: inactive, this_month: this_month }
    end

    # One grouped query for the whole (already paginated) page instead of a
    # referred_customers.count per row.
    @referred_counts = Customer.where(referred_by_affiliate_id: @affiliates.map(&:id))
                                .group(:referred_by_affiliate_id).count
  end

  def show
    @wallet = @affiliate.affiliate_wallet
    @referred_customers = @affiliate.referred_customers.order(created_at: :desc).limit(10)
    @referred_customers_count = @affiliate.referred_customers.count
    @withdrawal_requests = @affiliate.affiliate_withdrawal_requests.recent.limit(10)
  end

  def new
    @affiliate = Affiliate.new
  end

  def create
    @affiliate = Affiliate.new(affiliate_params)

    if @affiliate.save
      redirect_to admin_affiliate_path(@affiliate),
                 notice: "Affiliate created successfully. Login credentials: Username: #{@affiliate.username || @affiliate.email} | Password: #{@affiliate.auto_generated_password}"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @affiliate.update(affiliate_params)
      redirect_to admin_affiliate_path(@affiliate), notice: 'Affiliate was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @affiliate.destroy
    redirect_to admin_affiliates_path, notice: 'Affiliate was successfully deleted.'
  end

  def toggle_status
    @affiliate.update!(status: !@affiliate.status)
    # Also update user status
    @affiliate.user&.update(status: @affiliate.status)
    redirect_to admin_affiliates_path, notice: "Affiliate #{@affiliate.status? ? 'activated' : 'deactivated'} successfully."
  end

  def reset_password
    new_password = @affiliate.send(:generate_secure_password)

    if @affiliate.user&.update(password: new_password, password_confirmation: new_password)
      @affiliate.update(auto_generated_password: new_password)
      redirect_to admin_affiliate_path(@affiliate), notice: "Password reset successfully. New password: #{new_password}"
    else
      redirect_to admin_affiliate_path(@affiliate), alert: 'Failed to reset password.'
    end
  end

  private

  def set_affiliate
    @affiliate = Affiliate.find(params[:id])
  end

  def affiliate_params
    params.require(:affiliate).permit(
      :first_name, :last_name, :middle_name, :email, :mobile,
      :address, :city, :state, :pincode, :pan_no, :gst_no,
      :commission_percentage, :bank_name, :account_no, :ifsc_code,
      :account_holder_name, :account_type, :upi_id, :status, :notes,
      :joining_date, :company_name, :username
    )
  end
end
