class Api::V1::Admin::DashboardController < Api::V1::Admin::BaseController
  # GET /api/v1/admin/dashboard
  def index
    render_success(self.class.summary)
  end

  def self.summary
    Rails.cache.fetch('api:admin:dashboard:v2', expires_in: 5.minutes) do
      today = Date.current
      booking_counts = Booking.group(:status).count
      totals = booking_totals(today)
      products = Product.stock_status_counts
      pending_count, pending_total = PendingAmount.where(status: :pending).pick(Arel.sql('COUNT(*)'), Arel.sql('COALESCE(SUM(amount), 0)'))
      customers_count, new_customers = Customer.pick(
        Arel.sql('COUNT(*)'),
        Arel.sql(Customer.sanitize_sql_array(['COUNT(*) FILTER (WHERE created_at BETWEEN ? AND ?)', today.beginning_of_month.beginning_of_day, today.end_of_day]))
      )

      {
        total_revenue: totals[:total_revenue],
        today_revenue: totals[:today_revenue],
        month_revenue: totals[:month_revenue],
        today_bookings: totals[:today_bookings],
        total_bookings: booking_counts.values.sum,
        pending_bookings: %w[ordered_and_delivery_pending confirmed processing packed].sum { |s| booking_counts[s].to_i },
        shipped_bookings: %w[shipped out_for_delivery].sum { |s| booking_counts[s].to_i },
        completed_bookings: %w[delivered completed].sum { |s| booking_counts[s].to_i },
        cancelled_bookings: booking_counts['cancelled'].to_i,
        bookings_by_status: booking_counts,
        unpaid_bookings_count: totals[:unpaid_count],
        unpaid_bookings_amount: totals[:unpaid_amount],
        pending_amount_count: pending_count,
        pending_amount_total: pending_total.to_f,
        total_products: products[:total],
        active_products: Product.active.count,
        low_stock_products: products[:low_stock],
        out_of_stock_products: products[:out_of_stock],
        total_customers: customers_count,
        new_customers_this_month: new_customers,
        recent_bookings: Booking.includes(:customer).order(created_at: :desc).limit(5).map do |b|
          {
            id: b.id,
            booking_number: b.booking_number,
            customer_name: b.customer_name.presence || b.customer&.display_name,
            status: b.status,
            payment_status: b.payment_status,
            total_amount: b.total_amount.to_f,
            created_at: b.created_at
          }
        end
      }
    end
  end

  # Booking money and counts in one query.
  def self.booking_totals(today)
    today_range = ['created_at BETWEEN ? AND ?', today.beginning_of_day, today.end_of_day]
    month_range = ['created_at BETWEEN ? AND ?', today.beginning_of_month.beginning_of_day, today.end_of_month.end_of_day]
    unpaid = "payment_status IN ('unpaid', 'partially_paid') AND status <> 'cancelled'"
    today_sql = Booking.sanitize_sql_array(today_range)
    month_sql = Booking.sanitize_sql_array(month_range)

    total, day, month, day_count, unpaid_count, unpaid_amount = Booking.pick(
      Arel.sql('COALESCE(SUM(total_amount), 0)'),
      Arel.sql("COALESCE(SUM(total_amount) FILTER (WHERE #{today_sql}), 0)"),
      Arel.sql("COALESCE(SUM(total_amount) FILTER (WHERE #{month_sql}), 0)"),
      Arel.sql("COUNT(*) FILTER (WHERE #{today_sql})"),
      Arel.sql("COUNT(*) FILTER (WHERE #{unpaid})"),
      Arel.sql("COALESCE(SUM(total_amount) FILTER (WHERE #{unpaid}), 0)")
    )

    {
      total_revenue: total.to_f, today_revenue: day.to_f, month_revenue: month.to_f,
      today_bookings: day_count, unpaid_count: unpaid_count, unpaid_amount: unpaid_amount.to_f
    }
  end
  private_class_method :booking_totals
end
