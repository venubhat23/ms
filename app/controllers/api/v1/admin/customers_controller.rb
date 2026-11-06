class Api::V1::Admin::CustomersController < Api::V1::Admin::BaseController
  # GET /api/v1/admin/customers
  def index
    customers = Customer.all
    customers = customers.search_customers(params[:search]) if params[:search].present? && params[:search].to_s.strip.length >= 4
    customers = customers.where(status: params[:status] == 'active') if params[:status].in?(%w[active inactive])
    customers = customers.order(created_at: :desc)

    page = params[:page] || 1
    per_page = params[:per_page] || 20
    customers = customers.page(page).per(per_page)

    wallet_balances = CustomerWallet.where(customer_id: customers.map(&:id)).pluck(:customer_id, :balance).to_h

    render_success(
      customers: customers.map { |c| customer_response(c, wallet_balance: wallet_balances[c.id]) },
      pagination: {
        current_page: customers.current_page,
        total_pages: customers.total_pages,
        total_count: customers.total_count,
        per_page: customers.limit_value
      }
    )
  end

  # GET /api/v1/admin/customers/:id
  def show
    customer = Customer.find(params[:id])
    # Every list below is independent, so fire them all now and let their
    # round trips overlap with the one aggregate query in customer_response.
    @detail_lists = {
      wallet: CustomerWallet.where(customer_id: customer.id).limit(1).load_async,
      wallet_txns: WalletTransaction.joins(:customer_wallet).where(customer_wallets: { customer_id: customer.id })
                                    .includes(:booking).recent.load_async,
      pending_amounts: customer.pending_amounts.order(pending_date: :desc).limit(20).load_async,
      addresses: customer.customer_addresses.order(is_default: :desc).load_async,
      recent_bookings: customer.bookings.order(created_at: :desc).limit(10).load_async
    }
    wallet = @detail_lists[:wallet].first
    render_success(customer_response(customer, detailed: true, wallet_balance: wallet&.balance,
                                     wallet_history: wallet && wallet_history_rows(@detail_lists[:wallet_txns])))
  rescue ActiveRecord::RecordNotFound
    render_error('Customer not found', nil, :not_found)
  end

  # PATCH /api/v1/admin/customers/:id/toggle_status
  def toggle_status
    customer = Customer.find(params[:id])
    current_status = customer.status.nil? ? true : customer.status
    customer.update!(status: !current_status)

    render_success(customer_response(customer), "Customer #{customer.status ? 'enabled' : 'disabled'}")
  rescue ActiveRecord::RecordNotFound
    render_error('Customer not found', nil, :not_found)
  end

  private

  def customer_response(customer, detailed: false, wallet_balance: nil, wallet_history: nil)
    data = {
      id: customer.id,
      name: customer.display_name,
      first_name: customer.first_name,
      last_name: customer.last_name,
      email: customer.email,
      mobile: customer.mobile,
      status: customer.status.nil? ? true : customer.status,
      wallet_balance: (wallet_balance || 0).to_f,
      created_at: customer.created_at
    }

    if detailed
      data[:whatsapp_number] = customer.whatsapp_number
      data[:address] = customer.address
      lists = @detail_lists || {}
      # All six booking/order/pending figures in one round trip (was six).
      bookings_count, bookings_total, unpaid_count, unpaid_amount, orders_count, total_spent, pending_total =
        customer_totals(customer)
      data[:bookings_count] = bookings_count.to_i
      data[:orders_count] = orders_count.to_i
      data[:total_spent] = total_spent.to_f
      data[:bookings_total] = bookings_total.to_f
      data[:unpaid_bookings_count] = unpaid_count.to_i
      data[:unpaid_bookings_amount] = unpaid_amount.to_f
      data[:pending_amount_total] = pending_total.to_f
      data[:pending_amounts] = (lists[:pending_amounts] || customer.pending_amounts.order(pending_date: :desc).limit(20)).map do |pa|
        { id: pa.id, amount: pa.amount.to_f, description: pa.description, pending_date: pa.pending_date, status: pa.status }
      end
      data[:addresses] = (lists[:addresses] || customer.customer_addresses.order(is_default: :desc)).map do |a|
        a.slice(:id, :name, :mobile, :address_type, :address, :landmark, :city, :state, :pincode, :is_default)
      end
      data[:recent_bookings] = (lists[:recent_bookings] || customer.bookings.order(created_at: :desc).limit(10)).map do |b|
        {
          id: b.id,
          booking_number: b.booking_number,
          status: b.status,
          payment_status: b.payment_status,
          total_amount: b.total_amount.to_f,
          created_at: b.created_at
        }
      end
      data[:wallet_history] = wallet_history || []
    end

    data
  end

  # Same figures the old per-figure queries returned: != 'cancelled' (NULL
  # statuses excluded, as before), SUM over no rows -> 0 via to_f.
  def customer_totals(customer)
    not_cancelled = "bookings.status <> 'cancelled'"
    unpaid = "#{not_cancelled} AND bookings.payment_status IN ('unpaid', 'partially_paid')"
    id = customer.id.to_i
    Booking.where(customer_id: id).pick(
      Arel.sql('COUNT(*)'),
      Arel.sql("SUM(bookings.total_amount) FILTER (WHERE #{not_cancelled})"),
      Arel.sql("COUNT(*) FILTER (WHERE #{unpaid})"),
      Arel.sql("SUM(bookings.total_amount) FILTER (WHERE #{unpaid})"),
      Arel.sql("(SELECT COUNT(*) FROM orders WHERE orders.customer_id = #{id})"),
      Arel.sql("(SELECT COALESCE(SUM(orders.total_amount), 0) FROM orders WHERE orders.customer_id = #{id})"),
      Arel.sql("(SELECT SUM(pending_amounts.amount) FROM pending_amounts WHERE pending_amounts.customer_id = #{id} " \
               "AND pending_amounts.status = #{PendingAmount.statuses.fetch('pending').to_i})")
    )
  end

  def wallet_history(wallet)
    return [] unless wallet

    wallet_history_rows(wallet.wallet_transactions.includes(:booking).recent)
  end

  def wallet_history_rows(transactions)
    transactions.map do |txn|
      {
        id: txn.id,
        transaction_type: txn.transaction_type,
        amount: txn.amount.to_f,
        formatted_amount: txn.formatted_amount,
        balance_after: txn.balance_after.to_f,
        description: txn.description,
        reference_number: txn.reference_number,
        booking_id: txn.booking_id,
        booking_number: txn.booking&.booking_number,
        created_at: txn.created_at.iso8601
      }
    end
  end
end
