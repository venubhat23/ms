class Franchise::WithdrawalRequestsController < Franchise::BaseController
  before_action :ensure_franchise_commission_enabled

  def index
    @withdrawal_requests = current_franchise.franchise_withdrawal_requests.recent.page(params[:page]).per(20)
    @wallet = current_franchise.franchise_wallet
  end

  def new
    @wallet = current_franchise.franchise_wallet
    @withdrawal_request = current_franchise.franchise_withdrawal_requests.new
  end

  def create
    @wallet = current_franchise.franchise_wallet
    @withdrawal_request = current_franchise.franchise_withdrawal_requests.new(withdrawal_request_params)

    if @withdrawal_request.save
      redirect_to franchise_withdrawal_requests_path, notice: 'Withdrawal request submitted. It will be reviewed by an admin shortly.'
    else
      flash.now[:alert] = @withdrawal_request.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  rescue => e
    flash.now[:alert] = "Could not submit withdrawal request: #{e.message}"
    render :new, status: :unprocessable_entity
  end

  private

  def withdrawal_request_params
    params.require(:franchise_withdrawal_request).permit(:amount, :notes)
  end
end
