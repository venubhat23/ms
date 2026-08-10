class Franchise::WalletController < Franchise::BaseController
  before_action :ensure_franchise_commission_enabled

  def show
    @wallet = current_franchise.franchise_wallet || current_franchise.create_franchise_wallet!(balance: 0)
    @transactions = @wallet.franchise_wallet_transactions.recent.page(params[:page]).per(20)
  end
end
