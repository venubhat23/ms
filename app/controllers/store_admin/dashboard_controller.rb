class StoreAdmin::DashboardController < StoreAdmin::ApplicationController
  def index
    # Every query on this page is independent — fire them all on background
    # connections up front so their round trips overlap, resolve below.
    bookings = @current_store.bookings
    recent_bookings_count = bookings.where(created_at: 1.week.ago..Time.current).async_count
    @pending_bookings_count = bookings.where(status: ['draft', 'ordered_and_delivery_pending', 'confirmed']).async_count
    @completed_bookings_count = bookings.where(status: ['delivered', 'completed']).async_count
    @recent_bookings = bookings.order(created_at: :desc).limit(5).includes(:customer, booking_items: :product).load_async
    @daily_sales = calculate_daily_sales_trend

    @inventory_summary = {
      total_products: 0,
      total_stock_value: 0,
      low_stock_count: 0,
      pending_incoming_transfers: 0,
      pending_outgoing_transfers: 0,
      recent_bookings_count: recent_bookings_count.value
    }
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
