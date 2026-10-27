class Api::V1::Admin::PendingAmountsController < Api::V1::Admin::BaseController
  # GET /api/v1/admin/pending_amounts
  # Same data as the web Admin > Pending Amounts page (read-only).
  # Filters: status (pending/resolved/cancelled), customer_id, search, from_date, to_date
  def index
    entries = PendingAmount.includes(:customer)
    entries = entries.where(status: params[:status]) if params[:status].in?(PendingAmount.statuses.keys)
    entries = entries.where(customer_id: params[:customer_id]) if params[:customer_id].present?
    entries = entries.where('pending_date >= ?', param_date(:from_date)) if param_date(:from_date)
    entries = entries.where('pending_date <= ?', param_date(:to_date)) if param_date(:to_date)
    if params[:search].present?
      term = "%#{ActiveRecord::Base.sanitize_sql_like(params[:search].strip)}%"
      entries = entries.where(
        "pending_amounts.description ILIKE :t OR pending_amounts.customer_id IN " \
        "(SELECT id FROM customers WHERE CONCAT_WS(' ', first_name, last_name) ILIKE :t OR mobile ILIKE :t)",
        t: term
      )
    end

    status_counts = entries.group(:status).count
    summary = {
      pending_count: status_counts['pending'].to_i,
      pending_total: entries.where(status: :pending).sum(:amount).to_f,
      resolved_count: status_counts['resolved'].to_i,
      cancelled_count: status_counts['cancelled'].to_i
    }

    entries = paginate_scope(entries.order(pending_date: :desc, id: :desc))
    render_success(
      summary: summary,
      pending_amounts: entries.map { |pa| pending_amount_response(pa) },
      pagination: pagination_meta(entries)
    )
  end

  # GET /api/v1/admin/pending_amounts/:id
  # The entry plus everything else this customer owes.
  def show
    entry = PendingAmount.includes(:customer).find(params[:id])
    customer = entry.customer
    unpaid = customer.bookings.where(payment_status: %w[unpaid partially_paid]).where.not(status: 'cancelled')

    render_success(
      pending_amount_response(entry).merge(
        customer_pending_total: customer.pending_amounts.where(status: :pending).sum(:amount).to_f,
        other_pending_amounts: customer.pending_amounts.where(status: :pending).where.not(id: entry.id)
                                       .order(pending_date: :desc).map { |pa| pending_amount_response(pa, with_customer: false) },
        unpaid_bookings_amount: unpaid.sum(:total_amount).to_f,
        unpaid_bookings: unpaid.order(created_at: :desc).limit(20).map do |b|
          {
            id: b.id,
            booking_number: b.booking_number,
            status: b.status,
            payment_status: b.payment_status,
            total_amount: b.total_amount.to_f,
            created_at: b.created_at
          }
        end
      )
    )
  rescue ActiveRecord::RecordNotFound
    render_error('Pending amount not found', nil, :not_found)
  end

  private

  def pending_amount_response(entry, with_customer: true)
    data = {
      id: entry.id,
      amount: entry.amount.to_f,
      description: entry.description,
      pending_date: entry.pending_date,
      status: entry.status,
      notes: entry.notes,
      created_at: entry.created_at
    }
    if with_customer
      data[:customer] = entry.customer && {
        id: entry.customer_id,
        name: entry.customer.display_name,
        mobile: entry.customer.mobile,
        email: entry.customer.email
      }
    end
    data
  end
end
