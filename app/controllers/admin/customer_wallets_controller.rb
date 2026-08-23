class Admin::CustomerWalletsController < Admin::ApplicationController
  include ConfigurablePagination
  before_action :ensure_customer_wallet_enabled
  before_action :set_customer_wallet, only: [:show, :edit, :update, :destroy, :add_money, :deduct_money, :transaction_history]

  def index
    backfill_missing_wallets

    @customer_wallets = CustomerWallet.joins(:customer).includes(:customer)
    @customer_wallets = @customer_wallets.where("customers.first_name ILIKE ? OR customers.last_name ILIKE ? OR customers.email ILIKE ?",
                                               "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
    @customer_wallets = paginate_records(@customer_wallets.order('customers.first_name'))

    total_wallets, active_wallets, total_balance, avg_balance = CustomerWallet.pick(
      Arel.sql("COUNT(*)"),
      Arel.sql("COUNT(*) FILTER (WHERE status = true)"),
      Arel.sql("COALESCE(SUM(balance), 0)"),
      Arel.sql("COALESCE(AVG(balance), 0)")
    )
    @stats = {
      total_wallets: total_wallets,
      active_wallets: active_wallets,
      total_balance: total_balance,
      avg_balance: avg_balance
    }
  end

  def show
    @transactions = @customer_wallet.wallet_transactions.recent.limit(10)
  end

  def new
    @customer_wallet = CustomerWallet.new
    @customers = Customer.where.not(id: CustomerWallet.select(:customer_id)).order(:first_name)
  end

  def create
    @customer_wallet = CustomerWallet.new(customer_wallet_params)

    if @customer_wallet.save
      redirect_to admin_customer_wallet_path(@customer_wallet), notice: 'Customer wallet was successfully created.'
    else
      @customers = Customer.where.not(id: CustomerWallet.select(:customer_id)).order(:first_name)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @customer_wallet.update(customer_wallet_params)
      redirect_to admin_customer_wallet_path(@customer_wallet), notice: 'Customer wallet was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @customer_wallet.destroy
    redirect_to admin_customer_wallets_path, notice: 'Customer wallet was successfully deleted.'
  end

  def add_money
    amount = params[:amount].to_f
    description = params[:description]

    if amount > 0 && @customer_wallet.add_money(amount, description)
      redirect_to admin_customer_wallet_path(@customer_wallet), notice: "₹#{amount} added to wallet successfully."
    else
      redirect_to admin_customer_wallet_path(@customer_wallet), alert: 'Failed to add money to wallet.'
    end
  end

  def deduct_money
    amount = params[:amount].to_f
    description = params[:description]

    if amount > 0 && @customer_wallet.deduct_money(amount, description)
      redirect_to admin_customer_wallet_path(@customer_wallet), notice: "₹#{amount} deducted from wallet successfully."
    else
      redirect_to admin_customer_wallet_path(@customer_wallet), alert: 'Failed to deduct money from wallet. Insufficient balance.'
    end
  end

  def transaction_history
    @transactions = @customer_wallet.wallet_transactions.recent
    @transactions = paginate_records(@transactions)
  end

  private

  def ensure_customer_wallet_enabled
    unless SystemSetting.customer_wallet_enabled?
      redirect_to admin_settings_system_path, alert: 'Enable the Customer Wallet feature (Settings > System) to manage customer wallets.'
    end
  end

  # Every customer should show up in the wallet list with a balance, even
  # before an admin has ever added money to it — so any customer missing a
  # wallet row is lazily backfilled at 0 balance rather than requiring the
  # manual "Create Wallet" flow first.
  def backfill_missing_wallets
    missing_customer_ids = Customer.where.not(id: CustomerWallet.select(:customer_id)).pluck(:id)
    return if missing_customer_ids.empty?

    now = Time.current
    rows = missing_customer_ids.map { |id| { customer_id: id, balance: 0, status: true, created_at: now, updated_at: now } }
    CustomerWallet.insert_all(rows)
  end

  def set_customer_wallet
    @customer_wallet = CustomerWallet.find(params[:id])
  end

  def customer_wallet_params
    params.require(:customer_wallet).permit(:customer_id, :balance, :status, :notes)
  end
end
