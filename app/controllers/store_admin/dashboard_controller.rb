class StoreAdmin::DashboardController < StoreAdmin::ApplicationController
  def index
    @inventory_summary = {
      total_products: 0,
      total_stock_value: 0,
      low_stock_count: 0,
      pending_incoming_transfers: 0,
      pending_outgoing_transfers: 0,
      recent_bookings_count: @current_store.bookings.where(created_at: 1.week.ago..Time.current).count
    }
    @recent_bookings = @current_store.bookings.order(created_at: :desc).limit(5).includes(:customer, booking_items: :product)
    @daily_sales = calculate_daily_sales_trend
  end

  private

  def calculate_daily_sales_trend
    start_date = 7.days.ago.to_date
    end_date = Date.current

    # Was 2 queries (sum + count) per day in the range — 16 round trips for
    # one chart. Pull the week's rows once and group by day in Ruby instead.
    rows = @current_store.bookings
                         .where(created_at: start_date.beginning_of_day..end_date.end_of_day)
                         .where.not(status: ['cancelled', 'returned'])
                         .pluck(:created_at, :total_amount)
    rows_by_date = rows.group_by { |created_at, _amount| created_at.to_date }

    (start_date..end_date).map do |date|
      day_rows = rows_by_date[date] || []
      {
        date: date.strftime('%m/%d'),
        sales: day_rows.sum { |_created_at, amount| amount || 0 },
        bookings_count: day_rows.size
      }
    end
  end
end
