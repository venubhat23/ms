class Affiliate::WalletController < Affiliate::ApplicationController
  def show
    @wallet = current_affiliate.affiliate_wallet || current_affiliate.create_affiliate_wallet!(balance: 0)
    @transactions = @wallet.affiliate_wallet_transactions.recent.page(params[:page]).per(20)
    @referred_customers_count = current_affiliate.referred_customers.count
  end
end
