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
    wallet = CustomerWallet.find_by(customer_id: customer.id)
    render_success(customer_response(customer, detailed: true, wallet_balance: wallet&.balance, wallet_history: wallet_history(wallet)))
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
      data[:bookings_count] = customer.bookings.count
      orders_count, total_spent = customer.orders.pick(
        Arel.sql("COUNT(*)"), Arel.sql("COALESCE(SUM(total_amount), 0)")
      )
      data[:orders_count] = orders_count
      data[:total_spent] = total_spent.to_f
      data[:wallet_history] = wallet_history || []
    end

    data
  end

  def wallet_history(wallet)
    return [] unless wallet

    wallet.wallet_transactions.recent.map do |txn|
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
