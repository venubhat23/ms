class Franchise::DashboardController < Franchise::BaseController
  def index
    # Get bookings for the current franchise
    # Since bookings are associated with franchises, not users directly
    @bookings = current_franchise.bookings.includes(:customer, :booking_items)

    # All status counts, revenue sums, and today's stats used to be ~15
    # separate .count/.sum round trips. FILTER lets Postgres compute every
    # conditional aggregate in one pass over the table instead.
    month_range = Date.current.beginning_of_month..Date.current.end_of_month
    today_range = Date.current.all_day
    quoted_connection = Booking.connection

    stats = current_franchise.bookings
      .pick(
        Arel.sql('COUNT(*)'),
        Arel.sql("COUNT(*) FILTER (WHERE status = 'draft')"),
        Arel.sql("COUNT(*) FILTER (WHERE status = 'ordered_and_delivery_pending')"),
        Arel.sql("COUNT(*) FILTER (WHERE status = 'confirmed')"),
        Arel.sql("COUNT(*) FILTER (WHERE status IN ('processing', 'packed'))"),
        Arel.sql("COUNT(*) FILTER (WHERE status IN ('shipped', 'out_for_delivery'))"),
        Arel.sql("COUNT(*) FILTER (WHERE status IN ('delivered', 'completed'))"),
        Arel.sql("COUNT(*) FILTER (WHERE status IN ('cancelled', 'returned'))"),
        Arel.sql("COALESCE(SUM(total_amount) FILTER (WHERE status IN ('delivered', 'completed')), 0)"),
        Arel.sql("COALESCE(SUM(total_amount) FILTER (WHERE status NOT IN ('cancelled', 'returned')), 0)"),
        Arel.sql("COALESCE(SUM(total_amount) FILTER (WHERE status IN ('delivered', 'completed') AND created_at BETWEEN #{quoted_connection.quote(month_range.begin)} AND #{quoted_connection.quote(month_range.end)}), 0)"),
        Arel.sql("COUNT(*) FILTER (WHERE created_at BETWEEN #{quoted_connection.quote(today_range.begin)} AND #{quoted_connection.quote(today_range.end)})"),
        Arel.sql("COALESCE(SUM(total_amount) FILTER (WHERE status IN ('delivered', 'completed') AND created_at BETWEEN #{quoted_connection.quote(today_range.begin)} AND #{quoted_connection.quote(today_range.end)}), 0)")
      )

    (
      @total_bookings, @draft_bookings, @pending_bookings, @confirmed_bookings,
      @processing_bookings, @shipped_bookings, @delivered_bookings, @cancelled_bookings,
      @total_revenue, @pending_revenue, @this_month_revenue,
      @today_bookings, @today_revenue
    ) = stats

    @average_order_value = @delivered_bookings > 0 ? (@total_revenue / @delivered_bookings) : 0

    # Recent bookings
    @recent_bookings = @bookings.recent.limit(5)
  end
end