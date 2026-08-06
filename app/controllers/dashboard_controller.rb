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
      @active_customers = Customer.where(status: true).count rescue @total_customers
      @inactive_customers = @total_customers - @active_customers

      @total_affiliates = SubAgent.count rescue 0
      @total_sub_agents = @total_affiliates

      policy_counts = get_optimized_policy_counts
      @total_policies = policy_counts[:total_count]

      premium_data = get_optimized_premium_data
      @total_premium_collected = premium_data[:total_premium]
      @total_sum_insured       = premium_data[:total_sum_insured]

      @total_leads            = Lead.count rescue 0
      @converted_leads        = Lead.where(status: 'converted').count rescue 0
      @pending_leads          = Lead.where(status: 'pending').count rescue 0
      @lead_conversion_percentage = @total_leads > 0 ? ((@converted_leads.to_f / @total_leads) * 100).round(1) : 0

      thirty_days_from_now        = 30.days.from_now.to_date
      @renewal_due_count          = get_renewal_due_count(thirty_days_from_now)
      @expired_policies_count     = get_expired_policies_count

      payout_data      = get_optimized_payout_data
      @pending_payouts = payout_data[:pending_amount]
      @paid_payouts    = payout_data[:paid_amount]
      @total_payouts   = payout_data[:total_amount]

      total = policy_counts[:total_count]
      @policy_type_distribution = {
        'Health Insurance' => { count: policy_counts[:health_count], percentage: total > 0 ? (policy_counts[:health_count].to_f / total * 100).round(1) : 0 },
        'Life Insurance'   => { count: policy_counts[:life_count],   percentage: total > 0 ? (policy_counts[:life_count].to_f   / total * 100).round(1) : 0 },
        'Motor Insurance'  => { count: policy_counts[:motor_count],  percentage: total > 0 ? (policy_counts[:motor_count].to_f  / total * 100).round(1) : 0 },
        'Other Insurance'  => { count: policy_counts[:other_count],  percentage: total > 0 ? (policy_counts[:other_count].to_f  / total * 100).round(1) : 0 }
      }

      @customer_location      = calculate_customer_locations
      @age_distribution       = calculate_age_distribution
      @policy_status_distribution  = calculate_policy_status_distribution
      @monthly_revenue_breakdown   = calculate_monthly_revenue_breakdown
      @premium_by_type = {
        'Health Insurance' => HealthInsurance.sum(:total_premium) || 0,
        'Life Insurance'   => LifeInsurance.sum(:total_premium)   || 0,
        'Motor Insurance'  => (MotorInsurance.sum(:total_premium) rescue 0)
      }

      calculate_growth_metrics

      @client_requests_count = 0
      @claims_processing     = 0
      @docs_pending          = 0
      @commissions_due       = @pending_payouts
      @new_leads             = Lead.where('created_at >= ?', Date.current.beginning_of_month).count rescue 0
      @support_tickets       = 0

    rescue => e
      Rails.logger.error "Dashboard data loading error: #{e.message}"

      @total_customers             ||= 0
      @active_customers            ||= 0
      @inactive_customers          ||= 0
      @total_affiliates            ||= 0
      @total_sub_agents            ||= 0
      @total_policies              ||= 0
      @total_premium_collected     ||= 0
      @total_sum_insured           ||= 0
      @total_leads                 ||= 0
      @converted_leads             ||= 0
      @pending_leads               ||= 0
      @lead_conversion_percentage  ||= 0
      @renewal_due_count           ||= 0
      @expired_policies_count      ||= 0
      @pending_payouts             ||= 0
      @paid_payouts                ||= 0
      @total_payouts               ||= 0
      @policy_type_distribution    ||= {
        'Health Insurance' => { count: 0, percentage: 0 },
        'Life Insurance'   => { count: 0, percentage: 0 },
        'Motor Insurance'  => { count: 0, percentage: 0 },
        'Other Insurance'  => { count: 0, percentage: 0 }
      }
      @customer_location           ||= {}
      @age_distribution            ||= {}
      @policy_status_distribution  ||= {}
      @monthly_revenue_breakdown   ||= {}
      @premium_by_type             ||= { 'Health Insurance' => 0, 'Life Insurance' => 0, 'Motor Insurance' => 0 }
    end
  end

  # ---------------------------------------------------------------------------
  # Insurance helper methods (unchanged logic, kept for beautiful/ultra views)
  # ---------------------------------------------------------------------------

  def get_optimized_policy_counts
    health_count = HealthInsurance.count
    life_count   = LifeInsurance.count
    motor_count  = MotorInsurance.count rescue 0
    other_count  = OtherInsurance.count rescue 0
    {
      health_count: health_count,
      life_count:   life_count,
      motor_count:  motor_count,
      other_count:  other_count,
      total_count:  health_count + life_count + motor_count + other_count
    }
  end

  def get_optimized_premium_data
    health_premium = HealthInsurance.sum(:total_premium) || 0
    life_premium   = LifeInsurance.sum(:total_premium)   || 0
    motor_premium  = begin; MotorInsurance.sum(:total_premium) || 0; rescue; 0; end

    health_sum = HealthInsurance.sum(:sum_insured) || 0
    life_sum   = LifeInsurance.sum(:sum_insured)   || 0
    motor_sum  = begin; MotorInsurance.sum(:sum_insured) || 0; rescue; 0; end

    {
      total_premium:    health_premium + life_premium + motor_premium,
      total_sum_insured: health_sum + life_sum + motor_sum
    }
  end

  def get_renewal_due_count(thirty_days_from_now)
    health  = HealthInsurance.where('policy_end_date BETWEEN ? AND ?', Date.current, thirty_days_from_now).count
    life    = LifeInsurance.where('policy_end_date BETWEEN ? AND ?', Date.current, thirty_days_from_now).count
    motor   = MotorInsurance.where('policy_end_date BETWEEN ? AND ?', Date.current, thirty_days_from_now).count rescue 0
    other   = OtherInsurance.where('policy_end_date BETWEEN ? AND ?', Date.current, thirty_days_from_now).count rescue 0
    health + life + motor + other
  end

  def get_expired_policies_count
    health = HealthInsurance.where('policy_end_date < ?', Date.current).count
    life   = LifeInsurance.where('policy_end_date < ?', Date.current).count
    motor  = MotorInsurance.where('policy_end_date < ?', Date.current).count rescue 0
    other  = OtherInsurance.where('policy_end_date < ?', Date.current).count rescue 0
    health + life + motor + other
  end

  def get_optimized_payout_data
    commission_pending = CommissionPayout.where(status: 'pending').sum(:payout_amount) || 0
    commission_paid    = CommissionPayout.where(status: 'paid').sum(:payout_amount)    || 0
    commission_total   = CommissionPayout.sum(:payout_amount) || 0

    distributor_pending = DistributorPayout.where(status: 'pending').sum(:payout_amount) rescue 0
    distributor_paid    = DistributorPayout.where(status: 'paid').sum(:payout_amount)    rescue 0
    distributor_total   = DistributorPayout.sum(:payout_amount) rescue 0

    {
      pending_amount: commission_pending + distributor_pending,
      paid_amount:    commission_paid    + distributor_paid,
      total_amount:   commission_total   + distributor_total
    }
  end

  def calculate_growth_metrics
    current_month_start = Date.current.beginning_of_month
    last_month_start    = 1.month.ago.beginning_of_month
    last_month_end      = 1.month.ago.end_of_month

    current_customers  = Customer.where('created_at >= ?', current_month_start).count
    current_policies   = get_policies_count_for_period(current_month_start, Date.current)
    current_premium    = get_premium_for_period(current_month_start, Date.current)
    current_affiliates = SubAgent.where('created_at >= ?', current_month_start).count
    current_leads      = Lead.where('created_at >= ?', current_month_start).count
    current_renewals   = get_renewals_count_for_period(current_month_start, Date.current)
    current_payouts    = get_payouts_for_period(current_month_start, Date.current)
    current_sum_insured = get_sum_insured_for_period(current_month_start, Date.current)

    last_customers   = Customer.where(created_at: last_month_start..last_month_end).count
    last_policies    = get_policies_count_for_period(last_month_start, last_month_end)
    last_premium     = get_premium_for_period(last_month_start, last_month_end)
    last_affiliates  = SubAgent.where(created_at: last_month_start..last_month_end).count
    last_leads       = Lead.where(created_at: last_month_start..last_month_end).count
    last_renewals    = get_renewals_count_for_period(last_month_start, last_month_end)
    last_payouts     = get_payouts_for_period(last_month_start, last_month_end)
    last_sum_insured = get_sum_insured_for_period(last_month_start, last_month_end)

    @customer_growth   = calculate_percentage_change(current_customers,   last_customers)
    @policy_growth     = calculate_percentage_change(current_policies,    last_policies)
    @premium_growth    = calculate_percentage_change(current_premium,     last_premium)
    @affiliate_growth  = calculate_percentage_change(current_affiliates,  last_affiliates)
    @lead_growth       = calculate_percentage_change(current_leads,       last_leads)
    @renewal_growth    = calculate_percentage_change(current_renewals,    last_renewals)
    @payout_growth     = calculate_percentage_change(current_payouts,     last_payouts)
    @sum_insured_growth = calculate_percentage_change(current_sum_insured, last_sum_insured)

    @conversion_rate           = @total_leads > 0 ? ((@converted_leads.to_f / @total_leads) * 100).round(1) : 0
    @avg_policy_value          = @total_policies > 0 ? (@total_premium_collected / @total_policies).round(0) : 0
    @customer_retention        = calculate_customer_retention_rate
    @monthly_recurring_revenue = calculate_monthly_recurring_revenue
  end

  def get_policies_count_for_period(start_date, end_date)
    health = HealthInsurance.where(created_at: start_date..end_date).count
    life   = LifeInsurance.where(created_at: start_date..end_date).count
    motor  = MotorInsurance.where(created_at: start_date..end_date).count rescue 0
    other  = OtherInsurance.where(created_at: start_date..end_date).count rescue 0
    health + life + motor + other
  end

  def get_premium_for_period(start_date, end_date)
    health = HealthInsurance.where(created_at: start_date..end_date).sum(:total_premium) || 0
    life   = LifeInsurance.where(created_at: start_date..end_date).sum(:total_premium)   || 0
    motor  = MotorInsurance.where(created_at: start_date..end_date).sum(:total_premium) rescue 0
    health + life + motor
  end

  def get_renewals_count_for_period(start_date, end_date)
    thirty_days_ahead = end_date + 30.days
    health = HealthInsurance.where(created_at: start_date..end_date).where('policy_end_date BETWEEN ? AND ?', end_date, thirty_days_ahead).count
    life   = LifeInsurance.where(created_at: start_date..end_date).where('policy_end_date BETWEEN ? AND ?', end_date, thirty_days_ahead).count
    motor  = MotorInsurance.where(created_at: start_date..end_date).where('policy_end_date BETWEEN ? AND ?', end_date, thirty_days_ahead).count rescue 0
    health + life + motor
  end

  def get_payouts_for_period(start_date, end_date)
    commission  = CommissionPayout.where(created_at: start_date..end_date, status: 'pending').sum(:payout_amount) || 0
    distributor = DistributorPayout.where(created_at: start_date..end_date, status: 'pending').sum(:payout_amount) rescue 0
    commission + distributor
  end

  def get_sum_insured_for_period(start_date, end_date)
    health = HealthInsurance.where(created_at: start_date..end_date).sum(:sum_insured) || 0
    life   = LifeInsurance.where(created_at: start_date..end_date).sum(:sum_insured)   || 0
    motor  = MotorInsurance.where(created_at: start_date..end_date).sum(:sum_insured) rescue 0
    health + life + motor
  end

  def calculate_percentage_change(current_value, previous_value)
    return 0   if previous_value == 0
    return 100 if previous_value == 0 && current_value > 0
    ((current_value.to_f - previous_value.to_f) / previous_value.to_f * 100).round(1)
  end

  def calculate_customer_retention_rate
    two_months_ago = 2.months.ago.beginning_of_month
    old_customers        = Customer.where('created_at < ?', two_months_ago).count
    active_old_customers = Customer.where('created_at < ?', two_months_ago).where(status: true).count
    old_customers > 0 ? ((active_old_customers.to_f / old_customers.to_f) * 100).round(1) : 0
  end

  def calculate_monthly_recurring_revenue
    (@total_premium_collected / 12.0).round(0)
  end

  def calculate_age_distribution
    age_groups = { '18-25' => 0, '26-35' => 0, '36-45' => 0, '46-55' => 0, '56-65' => 0, '65+' => 0 }
    Customer.where.not(birth_date: nil).find_each do |customer|
      age = ((Date.current - customer.birth_date) / 365.25).to_i
      case age
      when 18..25 then age_groups['18-25'] += 1
      when 26..35 then age_groups['26-35'] += 1
      when 36..45 then age_groups['36-45'] += 1
      when 46..55 then age_groups['46-55'] += 1
      when 56..65 then age_groups['56-65'] += 1
      else age_groups['65+'] += 1 if age > 65
      end
    end
    age_groups
  end

  def calculate_policy_status_distribution
    active_policies = HealthInsurance.where('policy_end_date > ?', Date.current).count +
                      LifeInsurance.where('policy_end_date > ?', Date.current).count +
                      (MotorInsurance.where('policy_end_date > ?', Date.current).count rescue 0)

    expired_policies = HealthInsurance.where('policy_end_date < ?', Date.current).count +
                       LifeInsurance.where('policy_end_date < ?', Date.current).count +
                       (MotorInsurance.where('policy_end_date < ?', Date.current).count rescue 0)

    expiring_soon = HealthInsurance.where('policy_end_date BETWEEN ? AND ?', Date.current, 30.days.from_now).count +
                    LifeInsurance.where('policy_end_date BETWEEN ? AND ?', Date.current, 30.days.from_now).count +
                    (MotorInsurance.where('policy_end_date BETWEEN ? AND ?', Date.current, 30.days.from_now).count rescue 0)

    { 'Active' => active_policies, 'Expired' => expired_policies, 'Expiring Soon' => expiring_soon }
  end

  def calculate_monthly_revenue_breakdown
    # Preload all relevant categories upfront — eliminates Category.find_by in loop
    categories = Category.where(name: ['Electronics', 'Clothing', 'Home & Garden', 'Home', 'Garden'])
                         .pluck(:name, :id).to_h
    electronics_id = categories['Electronics']
    clothing_id    = categories['Clothing']
    home_id        = categories['Home & Garden'] || categories['Home'] || categories['Garden']

    start_date = 5.months.ago.beginning_of_month

    # Single query for all category revenues grouped by day (was 3 × 6 = 18 queries)
    relevant_ids = [electronics_id, clothing_id, home_id].compact
    cat_revenues = relevant_ids.any? ? BookingItem.joins(:booking, :product)
                                                   .where(bookings: { created_at: start_date..Time.current })
                                                   .where(products: { category_id: relevant_ids })
                                                   .group('products.category_id, DATE(bookings.created_at)')
                                                   .sum('booking_items.quantity * booking_items.price') : {}

    # Single query for total monthly revenue grouped by day (was 6 queries)
    monthly_totals = Booking.where(created_at: start_date..Time.current)
                            .group('DATE(created_at)')
                            .sum(:total_amount)

    revenue_breakdown = {}
    6.times do |i|
      month_date = (Date.current - i.months).beginning_of_month
      month_end  = month_date.end_of_month
      month_name = month_date.strftime('%b')

      electronics_revenue = cat_revenues.select { |k, _| k[0] == electronics_id && k[1] >= month_date && k[1] <= month_end }.values.sum
      clothing_revenue    = cat_revenues.select { |k, _| k[0] == clothing_id    && k[1] >= month_date && k[1] <= month_end }.values.sum
      home_revenue        = cat_revenues.select { |k, _| k[0] == home_id        && k[1] >= month_date && k[1] <= month_end }.values.sum
      total_monthly       = monthly_totals.select { |d, _| d >= month_date && d <= month_end }.values.sum

      if electronics_revenue == 0 && clothing_revenue == 0 && home_revenue == 0 && total_monthly > 0
        electronics_revenue = (total_monthly * 0.4).round(0)
        clothing_revenue    = (total_monthly * 0.35).round(0)
        home_revenue        = (total_monthly * 0.25).round(0)
      end

      revenue_breakdown[month_name] = {
        electronics: electronics_revenue,
        clothing:    clothing_revenue,
        home:        home_revenue,
        total:       electronics_revenue + clothing_revenue + home_revenue
      }
    end

    revenue_breakdown.to_a.reverse.to_h
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
