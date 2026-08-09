class Affiliate::WithdrawalRequestsController < Affiliate::ApplicationController
  def index
    @withdrawal_requests = current_affiliate.affiliate_withdrawal_requests.recent.page(params[:page]).per(20)
    @wallet = current_affiliate.affiliate_wallet
  end

  def new
    @wallet = current_affiliate.affiliate_wallet
    @withdrawal_request = current_affiliate.affiliate_withdrawal_requests.new
  end

  def create
    @wallet = current_affiliate.affiliate_wallet
    @withdrawal_request = current_affiliate.affiliate_withdrawal_requests.new(withdrawal_request_params)

    if @withdrawal_request.save
      redirect_to affiliate_withdrawal_requests_path, notice: 'Withdrawal request submitted. It will be reviewed by an admin shortly.'
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
    params.require(:affiliate_withdrawal_request).permit(:amount, :notes)
  end
end
