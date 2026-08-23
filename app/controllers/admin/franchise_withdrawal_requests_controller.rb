class Admin::FranchiseWithdrawalRequestsController < Admin::ApplicationController
  include ConfigurablePagination
  before_action :ensure_franchise_commission_enabled
  before_action :set_withdrawal_request, only: [:show, :approve, :reject, :mark_paid]

  private def ensure_franchise_commission_enabled
    unless SystemSetting.franchise_commission_enabled?
      redirect_to admin_settings_system_path, alert: 'Enable the Franchise Commission feature (Settings > System > Store Settings) to manage franchise withdrawals.'
    end
  end

  def index
    @withdrawal_requests = FranchiseWithdrawalRequest.includes(:franchise, :booking, :tagged_bookings).recent
    @withdrawal_requests = @withdrawal_requests.where(status: params[:status]) if params[:status].present?
    @withdrawal_requests = paginate_records(@withdrawal_requests)

    stats_row = FranchiseWithdrawalRequest.pick(
      Arel.sql('COUNT(*)'),
      Arel.sql("COUNT(*) FILTER (WHERE status = 'pending')"),
      Arel.sql("COUNT(*) FILTER (WHERE status = 'approved')"),
      Arel.sql("COUNT(*) FILTER (WHERE status = 'paid')")
    )
    total, pending, approved, paid = stats_row
    @stats = { total: total, pending: pending, approved: approved, paid: paid }
  end

  def show
  end

  def approve
    if @withdrawal_request.approve!(current_user)
      redirect_to admin_franchise_withdrawal_request_path(@withdrawal_request), notice: 'Withdrawal request approved.'
    else
      redirect_to admin_franchise_withdrawal_request_path(@withdrawal_request), alert: 'Only pending requests can be approved.'
    end
  end

  def reject
    if @withdrawal_request.reject!(current_user, params[:reason])
      redirect_to admin_franchise_withdrawal_request_path(@withdrawal_request), notice: 'Withdrawal request rejected and refunded to wallet.'
    else
      redirect_to admin_franchise_withdrawal_request_path(@withdrawal_request), alert: 'Only pending requests can be rejected.'
    end
  end

  def mark_paid
    if params[:payment_reference].blank?
      redirect_to admin_franchise_withdrawal_request_path(@withdrawal_request), alert: 'Payment reference is required.'
      return
    end

    if @withdrawal_request.mark_paid!(payment_reference: params[:payment_reference])
      redirect_to admin_franchise_withdrawal_request_path(@withdrawal_request), notice: 'Withdrawal marked as paid.'
    else
      redirect_to admin_franchise_withdrawal_request_path(@withdrawal_request), alert: 'Only approved requests can be marked as paid.'
    end
  end

  private

  def set_withdrawal_request
    @withdrawal_request = FranchiseWithdrawalRequest.includes(:franchise, :booking, :tagged_bookings).find(params[:id])
  end
end
