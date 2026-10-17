# Admin > POS: cash collected on bookings per shop (weekly / monthly), the
# cash each shop is holding right now, and deposits of that cash to the bank.
# The main shop is store_id NULL throughout (same as bookings.store_id).
class Admin::PosController < Admin::ApplicationController
  before_action :require_pos_permission

  PERIODS = %w[week month].freeze

  def index
    @period = PERIODS.include?(params[:period]) ? params[:period] : 'week'
    @offset = params[:offset].to_i.clamp(-120, 0)
    @range = period_range(@period, @offset)
    @store_key = params[:store].presence

    # The booking list is fired first so it loads on the async pool while
    # the shop list and per-shop totals below run.
    bookings = CashDeposit.cash_bookings
                          .where(Arel.sql("#{CashDeposit::COLLECTED_AT_SQL} BETWEEN ? AND ?"), @range.begin, @range.end)
    bookings = bookings.where(store_id: @store_key == 'main' ? nil : @store_key) if @store_key
    @bookings = bookings.includes(:store)
                        .order(Arel.sql("#{CashDeposit::COLLECTED_AT_SQL} DESC"))
                        .limit(300)
                        .load_async

    @shops = shop_list
    collected = CashDeposit.collected_by_store(@range)
    @rows = @shops.map do |shop|
      count, amount = collected[shop[:id]] || [0, 0.to_d]
      shop.merge(count: count, amount: amount)
    end
    @total_amount = @rows.sum { |r| r[:amount] }
    @total_count = @rows.sum { |r| r[:count] }
  end

  def cash_stock
    # Deposit history loads on the async pool while the totals below run.
    @history_store = params[:store].presence
    history = CashDeposit.includes(:store, :created_by).order(deposited_on: :desc, id: :desc)
    history = history.for_store_key(@history_store) if @history_store
    @deposits = history.limit(300).load_async

    @shops = shop_list
    collected = CashDeposit.collected_by_store
    deposited = CashDeposit.deposited_by_store
    @rows = @shops.map do |shop|
      cash = (collected[shop[:id]] || [0, 0.to_d]).last
      dep = deposited[shop[:id]] || 0.to_d
      shop.merge(collected: cash, deposited: dep, in_hand: cash - dep)
    end
    @totals = %i[collected deposited in_hand].index_with { |k| @rows.sum { |r| r[k] } }
    @deposit = CashDeposit.new(deposited_on: Date.current)
  end

  def create_deposit
    store_key = params.dig(:cash_deposit, :store_key).to_s
    store_id = store_key == 'main' ? nil : Store.find(store_key).id
    deposit = CashDeposit.new(deposit_params.merge(store_id: store_id, created_by: current_user))

    if deposit.save
      remaining = CashDeposit.cash_in_hand(store_id)
      redirect_to admin_pos_cash_stock_path,
                  notice: "₹#{fmt(deposit.amount)} from #{deposit.store_label} deposited to bank. " \
                          "Cash remaining at #{deposit.store_label}: ₹#{fmt(remaining)}."
    else
      redirect_to admin_pos_cash_stock_path, alert: "Deposit not saved: #{deposit.errors.full_messages.to_sentence}"
    end
  end

  # Undo a deposit entered by mistake; the cash goes back to the shop's balance.
  def destroy_deposit
    deposit = CashDeposit.find(params[:id])
    deposit.destroy!
    redirect_to admin_pos_cash_stock_path,
                notice: "Deposit of ₹#{fmt(deposit.amount)} from #{deposit.store_label} removed; the cash is back in that shop's balance."
  end

  private

  # Visible to anyone with the POS permission, or the Bookings permission
  # (where the cash is collected) so existing admins see it without a role edit.
  def require_pos_permission
    return if current_user.has_sidebar_permission?('pos') || current_user.has_sidebar_permission?('bookings')

    redirect_to dashboard_path, alert: 'You do not have access to POS.'
  end

  def shop_list
    [{ id: nil, key: 'main', name: CashDeposit::MAIN_STORE_LABEL }] +
      Store.order(:name).pluck(:id, :name).map { |id, name| { id: id, key: id.to_s, name: name } }
  end

  def period_range(period, offset)
    if period == 'month'
      start = Date.current.beginning_of_month.advance(months: offset)
      start.beginning_of_day..start.end_of_month.end_of_day
    else
      start = Date.current.beginning_of_week.advance(weeks: offset)
      start.beginning_of_day..start.end_of_week.end_of_day
    end
  end

  def deposit_params
    params.require(:cash_deposit).permit(:amount, :deposited_on, :bank_name, :reference_number, :notes)
  end

  def fmt(amount)
    ActiveSupport::NumberHelper.number_to_rounded(amount.to_d, precision: 2, delimiter: ',', strip_insignificant_zeros: true)
  end
end
