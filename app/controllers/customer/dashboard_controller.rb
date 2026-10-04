class Customer::DashboardController < Customer::BaseController
  def index
    # All dashboard aggregates are independent — start them together (async)
    # so their round trips to the remote DB overlap, then resolve below.
    if current_customer
      bookings = current_customer.bookings
      # Cart = items of the customer's first pending booking (same row
      # `.where(status: 'pending').first` picked), summed in one query.
      cart_items = BookingItem.where(booking_id: bookings.where(status: 'pending').order(:id).limit(1).select(:id))
                              .async_sum(:quantity)
      recent_orders = bookings.where('created_at > ?', 30.days.ago).async_count
      active_subscriptions = current_customer.milk_subscriptions.where(is_active: true).async_count
      activity_counts = order_activity_scope.async_count
      monthly_sums = monthly_spending_scope.async_sum(:total_amount)
    end

    # Customer's cart count for the action cards (using pending booking items as cart)
    @cart_items_count = cart_items&.value || 0

    # Customer's recent orders count
    @recent_orders_count = recent_orders&.value || 0

    # Customer's active subscriptions count
    @active_subscriptions_count = active_subscriptions&.value || 0

    # Chart data for Order Activity (Last 7 days)
    @order_activity_data = build_order_activity_data(activity_counts&.value || {})

    # Chart data for Monthly Spending (This year)
    @monthly_spending_data = build_monthly_spending_data(monthly_sums&.value || {})

    # Dashboard Banners - Show only once per login session
    # For debugging - clear session if needed
    if params[:clear_banner_session] == 'true'
      session[:dashboard_banners_shown] = nil
      Rails.logger.debug "🎯 Banner Debug: Session cleared"
    end

    @dashboard_banners = fetch_dashboard_banners_for_session

    # Additional debug - force show banner for testing
    if params[:force_banner] == 'true'
      @dashboard_banners = Banner.where(status: true, display_location: 'dashboard')
      Rails.logger.debug "🎯 FORCE Banner Debug: Found #{@dashboard_banners.count} banners (ignoring session and dates)"
    end
  end

  private

  def fetch_dashboard_banners_for_session
    Rails.logger.debug "🎯 Banner Debug: Session shown status: #{session[:dashboard_banners_shown]}"

    # For debugging - temporarily disable session check
    # return [] if session[:dashboard_banners_shown]

    # Fetch active, current, dashboard banners — load once (.to_a) and reuse
    # the loaded array for size/any? below instead of re-querying; .count
    # always issues a fresh SQL COUNT even when the relation was already
    # loaded, so calling it twice here was 2 extra round trips on every
    # dashboard visit.
    banners = Banner.where(status: true, display_location: 'dashboard')
                    .where('display_start_date <= ? AND display_end_date >= ?', Date.current, Date.current)
                    .order(:display_order)
                    .to_a

    Rails.logger.debug "🎯 Banner Debug: Found #{banners.size} banners"
    banners.each do |banner|
      Rails.logger.debug "🎯 Banner: ID=#{banner.id}, Title='#{banner.title}', Status=#{banner.status}, Location=#{banner.display_location}"
      Rails.logger.debug "🎯 Banner Dates: Start=#{banner.display_start_date}, End=#{banner.display_end_date}, Current=#{Date.current}"
      Rails.logger.debug "🎯 Banner Image: R2=#{banner.r2_image_url.present?}, Cloudinary=#{banner.image_url.present?}, Local=#{banner.banner_image.attached?}"
    end

    # If banners exist, mark them as shown for this session (disabled for debugging)
    if banners.any?
      # session[:dashboard_banners_shown] = true
      Rails.logger.debug "🎯 Banner Debug: Returning #{banners.size} banners to view"
      banners
    else
      Rails.logger.debug "🎯 Banner Debug: No banners found"
      []
    end
  end

  # Order counts for the last 7 days — one grouped query instead of 8
  # separate .count round trips (one per day).
  def order_activity_scope
    current_customer.bookings
                    .where(booking_date: 7.days.ago.beginning_of_day..Date.current.end_of_day)
                    .group("DATE(booking_date)")
  end

  def build_order_activity_data(counts_by_date)
    labels = []

    order_data = 7.downto(0).map do |days_ago|
      date = Date.current - days_ago.days
      labels << date.strftime('%a')
      counts_by_date[date] || counts_by_date[date.to_s] || 0
    end

    # If no data exists, provide sample data with message
    if order_data.sum == 0
      {
        labels: labels,
        data: [0, 0, 0, 0, 0, 0, 0],
        has_data: false,
        message: 'No orders in the last 7 days'
      }
    else
      {
        labels: labels,
        data: order_data,
        has_data: true,
        message: nil
      }
    end
  end

  # Spending for the current year by month — one grouped query instead of
  # 12 separate .sum round trips (one per month).
  def monthly_spending_scope
    year_start = Date.new(Date.current.year, 1, 1)
    current_customer.bookings
                    .where(booking_date: year_start..year_start.end_of_year)
                    .where.not(total_amount: nil)
                    .group("EXTRACT(MONTH FROM booking_date)")
  end

  def build_monthly_spending_data(sums_by_month)
    labels = []

    spending_data = (1..12).map do |month|
      labels << Date::MONTHNAMES[month][0, 3] # Jan, Feb, etc.
      (sums_by_month[month] || sums_by_month[month.to_f] || sums_by_month[month.to_s] || 0).to_f
    end

    # If no data exists, provide sample data with message
    if spending_data.sum == 0
      {
        labels: labels,
        data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        has_data: false,
        message: 'No spending data for this year'
      }
    else
      {
        labels: labels,
        data: spending_data,
        has_data: true,
        message: nil
      }
    end
  end
end