class DashboardController < ApplicationController
  skip_load_and_authorize_resource

  def index
    if request.headers['X-Session-Validation'] == 'true'
      head :ok
      return
    end

    authorize! :read, :dashboard
    load_ecommerce_dashboard_data
  end

  def beautiful
    authorize! :read, :dashboard
    load_dashboard_data
    render 'beautiful_dashboard', layout: false
  end

  def ultra
    authorize! :read, :dashboard
    load_dashboard_data
    render 'ultra_attractive_dashboard', layout: false
  end

  def ecommerce
    authorize! :read, :dashboard
    load_ecommerce_dashboard_data
    render 'ecommerce_dashboard', layout: false
  end

  def dummy
    authorize! :read, :dashboard
    render 'dummy', layout: false
  end

  def modern
    authorize! :read, :dashboard
    load_ecommerce_dashboard_data
    render 'modern', layout: false
  end

  def stats
    authorize! :read, :dashboard

    result = Rails.cache.fetch('dashboard:stats_json', expires_in: 2.minutes) do
      load_ecommerce_dashboard_data

      recent_orders = Booking.includes(:customer)
                             .recent
                             .limit(10)
                             .map do |booking|
        {
          id: booking.booking_number,
          customer: booking.customer&.display_name || 'Guest Customer',
          status: booking.status.capitalize,
          amount: booking.total_amount.to_i,
          date: booking.created_at.strftime('%Y-%m-%d')
        }
      end

      # Preload categories to avoid N+1 on product.category.name
      top_product_records = Product.joins(:booking_items)
                                   .joins('JOIN bookings ON booking_items.booking_id = bookings.id')
                                   .where('bookings.status IN (?)', ['delivered', 'completed'])
                                   .group('products.id, products.name, products.category_id')
                                   .select('products.id, products.name, products.category_id,
                                           SUM(booking_items.quantity * booking_items.price) as revenue,
                                           SUM(booking_items.quantity) as sold')
                                   .order('revenue DESC')
                                   .limit(5)
      category_names = Category.where(id: top_product_records.map(&:category_id).compact)
                                .index_by(&:id)
      top_products = top_product_records.map do |product|
        {
          id: product.id,
          name: product.name,
          category: category_names[product.category_id]&.name || 'General',
          revenue: product.revenue.to_i,
          sold: product.sold.to_i
        }
      end

      # Reuse already-grouped booking counts — no extra queries
      order_status_data = {
        'Completed' => (@booking_counts['delivered'] || 0) + (@booking_counts['completed'] || 0),
        'Processing' => (@booking_counts['confirmed'] || 0) + (@booking_counts['processing'] || 0) + (@booking_counts['packed'] || 0),
        'Shipped'   => (@booking_counts['shipped'] || 0) + (@booking_counts['out_for_delivery'] || 0),
        'Cancelled' => @cancelled_bookings
      }

      activities = [
        { id: 1, type: 'order',    title: 'New Order',         description: "Order #{recent_orders.first&.dig(:id) || 'BK001'} placed",              time: 2.minutes.ago },
        { id: 2, type: 'customer', title: 'New Customer',      description: 'Customer registration completed',                                        time: 5.minutes.ago },
        { id: 3, type: 'payment',  title: 'Payment Received',  description: "Payment of ₹#{recent_orders.first&.dig(:amount) || 2500} received",     time: 8.minutes.ago }
      ]

      {
        total_revenue: @total_revenue,
        total_bookings: @total_bookings,
        total_customers: @total_customers,
        total_products: @total_products,
        active_products: @active_products,
        pending_bookings: @pending_bookings,
        completed_bookings: @completed_bookings,
        cancelled_bookings: @cancelled_bookings,
        today_revenue: @today_revenue,
        month_revenue: @month_revenue,
        avg_order_value: @avg_order_value,
        revenue_growth: @revenue_growth,
        order_growth: @order_growth,
        customer_acquisition_growth: @customer_acquisition_growth,
        monthly_revenue_trend: @monthly_revenue_trend,
        category_performance: @category_performance,
        order_status_distribution: order_status_data,
        sales_trend: @sales_trend,
        recent_orders: recent_orders,
        top_products: top_products,
        activities: activities,
        last_updated: Time.current.strftime('%Y-%m-%d %H:%M:%S'),
        cache_key: "dashboard_#{Time.current.to_i}"
      }
    end

    render json: result
  end

  private

  def load_dashboard_data
    load_ecommerce_dashboard_data

    begin
      @total_customers = Customer.count

      # Kept as 2 separate queries (not grouped into 1) so a broken/missing
      # `status` filter on the second query can't take down the plain count
      # on the first — matches the original's per-field `rescue 0` isolation.
      @total_leads     = Lead.count
      @converted_leads = (Lead.where(status: 'converted').count rescue 0)
      @lead_conversion_percentage = @total_leads > 0 ? ((@converted_leads.to_f / @total_leads) * 100).round(1) : 0

      # 2 queries per insurance model (count+premium+sum_insured aggregate, then
      # renewal-due count) instead of the old 3 helper methods × 4 models (up to
      # 14 round trips). Only computes what beautiful/ultra views actually render
      # — growth metrics, policy status/age/location breakdowns, premium-by-type
      # and expired-policy counts were computed here but never used by either
      # view template (grep confirms no @growth/@policy_status_distribution/
      # @age_distribution/@monthly_revenue_breakdown/@premium_by_type/
      # @expired_policies_count/@customer_retention references in
      # beautiful_dashboard.html.erb or ultra_attractive_dashboard.html.erb),
      # so those ~55 round trips are dropped rather than optimized.
      thirty_days_from_now = 30.days.from_now.to_date
      life   = insurance_summary(LifeInsurance, thirty_days_from_now)
      motor  = insurance_summary(MotorInsurance, thirty_days_from_now)
      other  = insurance_summary(OtherInsurance, thirty_days_from_now)

      @total_policies          = life[:count] + motor[:count] + other[:count]
      @total_premium_collected = life[:premium] + motor[:premium] + other[:premium]
      @total_sum_insured       = life[:sum_insured] + motor[:sum_insured] + other[:sum_insured]
      @renewal_due_count       = life[:renewal_due] + motor[:renewal_due] + other[:renewal_due]

      @policy_type_distribution = {
        'Life Insurance'   => { count: life[:count],   percentage: @total_policies > 0 ? (life[:count].to_f   / @total_policies * 100).round(1) : 0 },
        'Motor Insurance'  => { count: motor[:count],  percentage: @total_policies > 0 ? (motor[:count].to_f  / @total_policies * 100).round(1) : 0 },
        'Other Insurance'  => { count: other[:count],  percentage: @total_policies > 0 ? (other[:count].to_f  / @total_policies * 100).round(1) : 0 }
      }

      # Only "pending" is rendered (@pending_payouts) — paid/total totals were
      # computed here but never used by either view.
      commission_pending  = CommissionPayout.where(status: 'pending').sum(:payout_amount) || 0
      distributor_pending = (DistributorPayout.where(status: 'pending').sum(:payout_amount) rescue 0)
      @pending_payouts = commission_pending + distributor_pending
      @commissions_due = @pending_payouts

      @client_requests_count = 0
      @claims_processing     = 0
      @docs_pending           = 0
      @support_tickets        = 0

    rescue => e
      Rails.logger.error "Dashboard data loading error: #{e.message}"

      @total_customers             ||= 0
      @total_leads                 ||= 0
      @converted_leads             ||= 0
      @lead_conversion_percentage  ||= 0
      @total_policies              ||= 0
      @total_premium_collected     ||= 0
      @total_sum_insured           ||= 0
      @renewal_due_count           ||= 0
      @policy_type_distribution    ||= {
        'Life Insurance'   => { count: 0, percentage: 0 },
        'Motor Insurance'  => { count: 0, percentage: 0 },
        'Other Insurance'  => { count: 0, percentage: 0 }
      }
      @pending_payouts        ||= 0
      @commissions_due        ||= 0
      @client_requests_count  ||= 0
      @claims_processing      ||= 0
      @docs_pending            ||= 0
      @support_tickets         ||= 0
    end
  end

  # ---------------------------------------------------------------------------
  # Insurance helper methods (kept for beautiful/ultra views)
  # ---------------------------------------------------------------------------

  # 2 round trips per model: one aggregate (count/premium/sum_insured), one
  # renewal-due-in-30-days count. Individually rescued so one missing/broken
  # insurance table doesn't zero out the others (matches prior per-model rescue
  # behavior in this file).
  def insurance_summary(model, thirty_days_from_now)
    agg = model.select(
      'COUNT(*) AS cnt, COALESCE(SUM(total_premium), 0) AS premium_sum, COALESCE(SUM(sum_insured), 0) AS sum_insured_sum'
    ).take
    renewal_due = model.where('policy_end_date BETWEEN ? AND ?', Date.current, thirty_days_from_now).count
    {
      count: agg.cnt.to_i,
      premium: agg.premium_sum.to_f,
      sum_insured: agg.sum_insured_sum.to_f,
      renewal_due: renewal_due
    }
  rescue
    { count: 0, premium: 0, sum_insured: 0, renewal_due: 0 }
  end

  def calculate_percentage_change(current_value, previous_value)
    return 0   if previous_value == 0
    return 100 if previous_value == 0 && current_value > 0
    ((current_value.to_f - previous_value.to_f) / previous_value.to_f * 100).round(1)
  end

  # ---------------------------------------------------------------------------
  # E-commerce dashboard — main load method
  # ---------------------------------------------------------------------------

  def load_ecommerce_dashboard_data
    today = Date.current

    # ~20 counter/aggregate queries bundled into a single cache entry. TTL is
    # long relative to typical browsing sessions because each cache MISS costs
    # ~15-20s on our current (remote, high-latency) DB connection — a short TTL
    # just means more visitors eat that cold-start cost. Trade-off: counters can
    # be up to 15 min stale.
    counters = Rails.cache.fetch('dashboard:counters', expires_in: 15.minutes) do
      compute_dashboard_counters(today)
    end
    counters.each { |key, value| instance_variable_set(:"@#{key}", value) }

    # ── Chart data (cached longer than the counters — trends/analytics tolerate
    # more staleness than live counts, and each is its own ~15-20s cold-start cost) ──
    @category_performance = Rails.cache.fetch('dashboard:category_performance', expires_in: 30.minutes) do
      calculate_category_performance
    end

    # Single query feeds all three sales trend periods (was 7 + 30 + 13 = 50 queries → 1)
    all_sales_rows = Rails.cache.fetch('dashboard:daily_sales_90d', expires_in: 30.minutes) do
      fetch_daily_sales(90)
    end
    @sales_trend    = build_7day_trend(all_sales_rows)
    @sales_trend_30d = build_daily_trend(all_sales_rows, 30)
    @sales_trend_90d = build_weekly_trend(all_sales_rows, 90)

    # Monthly revenue: single query (was 6 queries → 1)
    @monthly_revenue_trend = Rails.cache.fetch('dashboard:monthly_revenue_trend', expires_in: 30.minutes) do
      calculate_monthly_revenue_trend
    end

    @top_customers_data = Rails.cache.fetch('dashboard:top_customers', expires_in: 30.minutes) do
      calculate_top_customers_data
    end

    @top_products_revenue = Rails.cache.fetch('dashboard:top_products_revenue', expires_in: 30.minutes) do
      calculate_top_products_revenue
    end

    # Cached + .to_a'd: an uncached/unloaded relation here means the view's
    # `.any?` (existence check) and `.each` (load) each fire their own query,
    # and a cache around a still-lazy relation caches the query definition, not
    # the results, so it would still hit the DB on every "cache hit" too.
    # Kept shorter than the rest — this is the one widget that's actually
    # operationally time-sensitive (new orders, low stock).
    @recent_bookings = begin
      Rails.cache.fetch('dashboard:recent_bookings', expires_in: 5.minutes) do
        Booking.includes(:customer).order(created_at: :desc).limit(5).to_a
      end
    rescue
      []
    end

    @low_stock_items = begin
      Rails.cache.fetch('dashboard:low_stock_items', expires_in: 5.minutes) do
        Product.includes(:category).where('stock <= 5 AND stock > 0').limit(5).to_a
      end
    rescue
      []
    end
  end

  # Bundles ~20 separate counter/aggregate queries (product/category/booking/order
  # counts, revenue sums, vendor/store/inventory/customer metrics, and the
  # derived chart/growth values that depend on them) into one payload so they
  # can be cached together instead of hitting the DB on every dashboard load.
  def compute_dashboard_counters(today)
    h = {}

    # ── Product counts (3 queries → 1) ────────────────────────────────────────
    begin
      product_counts = Product.group(:status).count
      h[:total_products]  = product_counts.values.sum
      h[:active_products] = product_counts['active'] || h[:total_products]
      h[:draft_products]  = product_counts['draft']  || 0
    rescue
      h[:total_products]  = Product.count
      h[:active_products] = h[:total_products]
      h[:draft_products]  = 0
    end

    # ── Category counts (2 queries → 1) ───────────────────────────────────────
    h[:total_categories]  = Category.count
    h[:active_categories] = Category.where(status: true).count

    # ── Booking counts by status (4 queries → 1) ──────────────────────────────
    h[:booking_counts]    = Booking.group(:status).count
    h[:total_bookings]    = h[:booking_counts].values.sum
    h[:pending_bookings]   = h[:booking_counts]['pending']   || 0
    h[:completed_bookings] = h[:booking_counts]['completed'] || 0
    h[:cancelled_bookings] = h[:booking_counts]['cancelled'] || 0

    # ── Order counts by status (5 queries → 1) ────────────────────────────────
    begin
      order_counts = Order.group(:status).count
      h[:total_orders]     = order_counts.values.sum
      h[:pending_orders]   = order_counts['pending']   || 0
      h[:shipped_orders]   = order_counts['shipped']   || 0
      h[:delivered_orders] = order_counts['delivered'] || 0
      h[:cancelled_orders] = order_counts['cancelled'] || 0
    rescue
      h[:total_orders] = h[:pending_orders] = h[:shipped_orders] = h[:delivered_orders] = h[:cancelled_orders] = 0
    end

    # ── Revenue metrics ────────────────────────────────────────────────────────
    h[:total_revenue] = Booking.sum(:total_amount) || 0
    h[:today_revenue] = Booking.where(created_at: today.beginning_of_day..today.end_of_day).sum(:total_amount) || 0
    h[:month_revenue] = Booking.where(created_at: today.beginning_of_month..today.end_of_month).sum(:total_amount) || 0
    h[:avg_order_value] = h[:total_bookings] > 0 ? (h[:total_revenue] / h[:total_bookings]).round(2) : 0

    # ── Vendor metrics ─────────────────────────────────────────────────────────
    h[:total_vendors]        = (Vendor.count rescue 0)
    h[:active_vendors]       = (Vendor.where(status: true).count rescue 0)
    h[:total_purchases]      = (VendorPurchase.count rescue 0)
    h[:pending_purchases]    = (VendorPurchase.where(status: 'pending').count rescue 0)
    h[:total_purchase_value] = (VendorPurchase.sum(:total_amount) rescue 0)
    h[:pending_payments]     = (VendorPayment.where(status: 'pending').sum(:amount) rescue 0)

    # ── Store metrics ──────────────────────────────────────────────────────────
    h[:total_stores]  = (Store.count rescue 0)
    h[:active_stores] = (Store.where(status: true).count rescue 0)

    # ── Inventory metrics (3 queries → 1) ─────────────────────────────────────
    begin
      # .take, not .first: .first adds an implicit ORDER BY products.id, which
      # Postgres rejects on a pure-aggregate SELECT with no GROUP BY — that made
      # this always raise and fall through to the 3-query fallback below, every time.
      inv = Product.select(
        'COALESCE(SUM(CAST(price AS DECIMAL) * stock), 0) AS total_stock_value, ' \
        'COUNT(CASE WHEN stock <= 5 AND stock > 0 THEN 1 END) AS low_stock, ' \
        'COUNT(CASE WHEN stock = 0 THEN 1 END) AS out_of_stock'
      ).take
      h[:total_stock_value]    = inv.total_stock_value.to_f
      h[:low_stock_products]   = inv.low_stock.to_i
      h[:out_of_stock_products] = inv.out_of_stock.to_i
    rescue
      h[:total_stock_value]     = Product.sum('price * stock') || 0
      h[:low_stock_products]    = Product.where('stock <= 5 AND stock > 0').count
      h[:out_of_stock_products] = Product.where(stock: 0).count
    end

    h[:top_categories] = calculate_top_categories

    # ── Customer metrics ───────────────────────────────────────────────────────
    h[:total_customers] = Customer.count
    h[:new_customers_this_month] = Customer.where(created_at: today.beginning_of_month..today.end_of_month).count

    h[:order_status_distribution] = {
      'Pending'   => h[:pending_orders],
      'Shipped'   => h[:shipped_orders],
      'Delivered' => h[:delivered_orders],
      'Cancelled' => h[:cancelled_orders]
    }
    h[:top_selling_products] = calculate_top_selling_products
    h[:payment_method_distribution] = calculate_payment_method_distribution
    h[:delivery_performance] = calculate_delivery_performance

    # ── Growth metrics (reuses h[:month_revenue] / h[:new_customers_this_month]) ──
    current_month_start = today.beginning_of_month
    last_month_start    = 1.month.ago.beginning_of_month
    last_month_end      = 1.month.ago.end_of_month

    current_orders = Booking.where('created_at >= ?', current_month_start).count
    last_stats     = Booking.where(created_at: last_month_start..last_month_end)
                             .select('COUNT(*) AS order_count, COALESCE(SUM(total_amount), 0) AS revenue')
                             .take
    last_orders    = last_stats.order_count.to_i
    last_revenue   = last_stats.revenue.to_f
    last_customers = Customer.where(created_at: last_month_start..last_month_end).count

    h[:revenue_growth]              = calculate_percentage_change(h[:month_revenue], last_revenue)
    h[:order_growth]                = calculate_percentage_change(current_orders, last_orders)
    h[:customer_acquisition_growth] = calculate_percentage_change(h[:new_customers_this_month], last_customers)

    h[:conversion_rate]    = h[:total_customers] > 0 ? ((h[:total_bookings].to_f / h[:total_customers]) * 100).round(2) : 0
    h[:inventory_turnover] = h[:total_stock_value] > 0 ? (h[:total_revenue] / h[:total_stock_value]).round(2) : 0
    h[:customer_location]  = calculate_customer_locations

    h
  end

  # ---------------------------------------------------------------------------
  # E-commerce chart helpers
  # ---------------------------------------------------------------------------

  def calculate_top_categories
    Category.joins(:products)
            .group('categories.name')
            .order('COUNT(products.id) DESC')
            .limit(5)
            .count
  rescue
    Category.limit(5).pluck(:name).map { |name| [name, rand(5..20)] }.to_h
  end

  # Eliminates N+1: was O(categories × products) queries → 1 aggregated query
  def calculate_category_performance
    BookingItem.joins(:booking, product: :category)
               .group('categories.name')
               .sum('booking_items.quantity * booking_items.price')
               .reject { |_, v| v == 0 }
               .sort_by { |_, v| -v }
               .to_h
  rescue
    {}
  end

  def calculate_top_selling_products
    BookingItem.joins(:product, :booking)
               .group('products.name')
               .order('SUM(booking_items.quantity) DESC')
               .limit(5)
               .sum(:quantity)
  end

  # 4 separate COUNT queries → 1 GROUP BY
  def calculate_payment_method_distribution
    rows = Booking.group(:payment_method).count
    {
      'Cash'   => rows['cash']   || 0,
      'Card'   => rows['card']   || 0,
      'UPI'    => rows['upi']    || 0,
      'Online' => rows['online'] || 0
    }
  end

  # 6 separate queries → 1 DATE-grouped query aggregated in Ruby
  def calculate_monthly_revenue_trend
    start_date = 5.months.ago.beginning_of_month
    rows = Booking.where(created_at: start_date..Time.current)
                  .group('DATE(created_at)')
                  .sum(:total_amount)
    trend = {}
    6.times do |i|
      month_date = (Date.current - i.months).beginning_of_month
      month_end  = month_date.end_of_month
      trend[month_date.strftime('%b %Y')] = rows.select { |d, _| d >= month_date && d <= month_end }.values.sum
    end
    trend.to_a.reverse.to_h
  end

  def calculate_delivery_performance
    delivered_on_time = Order.where('delivered_at <= created_at + INTERVAL \'3 days\'').count
    total_delivered   = Order.where.not(delivered_at: nil).count
    {
      on_time_percentage: total_delivered > 0 ? ((delivered_on_time.to_f / total_delivered) * 100).round(1) : 0,
      total_delivered:    total_delivered,
      avg_delivery_days:  total_delivered > 0 ? 3.2 : 0
    }
  rescue
    { on_time_percentage: 0, total_delivered: 0, avg_delivery_days: 0 }
  end

  def calculate_customer_locations
    Customer.where.not(state: [nil, ''])
            .group(:state)
            .count
            .sort_by { |_, count| -count }
            .first(10)
            .to_h
  rescue
    {}
  end

  def calculate_top_customers_data
    # .to_a: without it this returns an unloaded relation, so caching it just
    # caches the query definition — the view's .each still hits the DB on every
    # "cache hit".
    Customer.joins(:bookings)
            .select('customers.*, COUNT(bookings.id) AS booking_count, SUM(bookings.total_amount) AS total_spent')
            .group('customers.id')
            .order('total_spent DESC')
            .limit(5)
            .to_a
  rescue
    []
  end

  # Single query for 90 days — shared by all three trend periods
  def fetch_daily_sales(days)
    start_date = (days - 1).days.ago.beginning_of_day
    Booking.where(created_at: start_date..Time.current)
           .group('DATE(created_at)')
           .sum(:total_amount)
  end

  def build_7day_trend(rows)
    trend = {}
    7.times do |i|
      date = Date.current - i.days
      trend[date.strftime('%a')] = rows[date] || 0
    end
    trend.to_a.reverse.to_h
  end

  def build_daily_trend(rows, days)
    trend = {}
    days.times do |i|
      date = Date.current - i.days
      trend[date.strftime('%d %b')] = rows[date] || 0
    end
    trend.to_a.reverse.to_h
  end

  def build_weekly_trend(rows, days)
    weeks = (days / 7.0).ceil
    trend = {}
    weeks.times do |i|
      week_end   = Date.current - (i * 7).days
      week_start = week_end - 6.days
      trend[week_start.strftime('%d %b')] = rows.select { |d, _| d >= week_start && d <= week_end }.values.sum
    end
    trend.to_a.reverse.to_h
  end

  def calculate_top_products_revenue
    BookingItem.joins(:product, :booking)
               .group('products.name')
               .order(Arel.sql('SUM(booking_items.quantity * booking_items.price) DESC'))
               .limit(8)
               .sum(Arel.sql('booking_items.quantity * booking_items.price'))
  rescue
    {}
  end
end
