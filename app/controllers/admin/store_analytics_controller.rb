class Admin::StoreAnalyticsController < Admin::ApplicationController
  before_action :authenticate_user!
  before_action(only: [:comparison]) { require_sidebar_permission!('store_analytics_comparison') }
  before_action(only: [:top_products]) { require_sidebar_permission!('store_analytics_top_products') }
  before_action(only: [:peak_hours]) { require_sidebar_permission!('store_analytics_peak_hours') }

  def comparison
    @month = params[:month].present? ? Date.parse(params[:month]) : Date.current.beginning_of_month
    @store_data, @totals = comparison_data(@month)
  end

  def top_products
    @stores = store_list
    @selected_store_id = params[:store_id].presence
    @month = params[:month].present? ? Date.parse(params[:month]) : Date.current.beginning_of_month
    @top_products = top_products_data(@month, @selected_store_id)
  end

  def peak_hours
    @stores = store_list
    @selected_store_id = params[:store_id].presence
    @day_labels  = %w[Sun Mon Tue Wed Thu Fri Sat]
    @hour_labels = (0..23).map { |h| format('%02d:00', h) }
    @heatmap, @max_count = peak_hours_data(@selected_store_id)
  end

  private

  # Shared by #comparison and WarmStoreAnalyticsCacheJob so the cache key/logic
  # lives in one place instead of drifting out of sync between the two.
  def comparison_data(month)
    # Whole result cached per month — this page has no per-user data, so every
    # admin viewing the same month hits the same key. The DB is remote (every
    # query round trip is ~200-400ms regardless of complexity), so a cache hit
    # skips the connection entirely instead of just skipping query execution.
    cache_key = "admin_store_analytics/comparison/#{month.strftime('%Y-%m')}"
    Rails.cache.fetch(cache_key, expires_in: 5.minutes) do
      stores = Store.all.order(:name).to_a
      store_ids = stores.map(&:id)
      period = month.beginning_of_month..month.end_of_month

      # Previously ran up to 4 queries PER store (bookings sum, bookings count,
      # expenses sum, stock sum) — for 3 stores that's ~12 sequential round
      # trips. Replaced with one GROUP BY per metric across all stores at once
      # (4 queries total, not 4*stores), fired concurrently via async_sum/
      # async_count on separate pooled connections so their round trips
      # overlap instead of stacking.
      revenue_promise  = Booking.where(store_id: store_ids, created_at: period).group(:store_id).async_sum(:total_amount)
      count_promise    = Booking.where(store_id: store_ids, created_at: period).group(:store_id).async_count
      expenses_promise = Expense.where(store_id: store_ids)
                                 .by_date_range(month.beginning_of_month, month.end_of_month)
                                 .group(:store_id).async_sum(:amount)
      stock_promise    = StockBatch.where(store_id: store_ids, status: 'active').where('quantity_remaining > 0')
                                    .group(:store_id).async_sum('quantity_remaining * purchase_price')

      revenue_by_store  = revenue_promise.value
      count_by_store    = count_promise.value
      expenses_by_store = expenses_promise.value
      stock_by_store    = stock_promise.value

      store_data = stores.map do |store|
        revenue     = revenue_by_store[store.id].to_f
        expense_sum = expenses_by_store[store.id].to_f

        {
          store: store,
          revenue: revenue,
          bookings_count: count_by_store[store.id].to_i,
          expenses_total: expense_sum,
          stock_value: stock_by_store[store.id].to_f,
          net: revenue - expense_sum
        }
      end

      totals = {
        revenue:        store_data.sum { |d| d[:revenue] },
        bookings_count: store_data.sum { |d| d[:bookings_count] },
        expenses_total: store_data.sum { |d| d[:expenses_total] },
        stock_value:    store_data.sum { |d| d[:stock_value] },
        net:            store_data.sum { |d| d[:net] }
      }

      [store_data, totals]
    end
  end

  def top_products_data(month, store_id)
    cache_key = "admin_store_analytics/top_products/#{month.strftime('%Y-%m')}/store=#{store_id}"
    Rails.cache.fetch(cache_key, expires_in: 5.minutes) do
      period = month.beginning_of_month..month.end_of_month

      booking_scope = Booking.where(created_at: period)
      booking_scope = booking_scope.where(store_id: store_id) if store_id.present?

      booking_ids = booking_scope.pluck(:id)

      SaleItem
        .where(booking_id: booking_ids)
        .joins(:product)
        .group('products.id', 'products.name')
        .select(
          'products.id   AS product_id',
          'products.name AS product_name',
          'SUM(sale_items.quantity)   AS total_qty',
          'SUM(sale_items.line_total) AS total_revenue',
          'SUM(sale_items.profit_amount) AS total_profit'
        )
        .order('total_qty DESC')
        .limit(20)
        .to_a
    end
  end

  def peak_hours_data(store_id)
    # Keyed by today's date (not just store) so the rolling 3-month window
    # advances once a day instead of staying pinned to whatever day first
    # populated the cache; a 30-minute expiry keeps it fresh within a day too.
    cache_key = "admin_store_analytics/peak_hours/#{Date.current}/store=#{store_id}"
    Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
      scope = Booking.where(created_at: 3.months.ago..Time.current)
      scope = scope.where(store_id: store_id) if store_id.present?

      raw = scope
        .select(
          "EXTRACT(DOW FROM created_at AT TIME ZONE 'Asia/Kolkata')::INTEGER AS day_num",
          "EXTRACT(HOUR FROM created_at AT TIME ZONE 'Asia/Kolkata')::INTEGER AS hour_num",
          'COUNT(*) AS cnt'
        )
        .group('day_num', 'hour_num')
        .map { |r| { day: r.day_num.to_i, hour: r.hour_num.to_i, count: r.cnt.to_i } }

      heatmap = Array.new(7) { Array.new(24, 0) }
      max_count = 1
      raw.each do |r|
        heatmap[r[:day]][r[:hour]] = r[:count]
        max_count = [max_count, r[:count]].max
      end

      [heatmap, max_count]
    end
  end

  # Store dropdown list shared by top_products/peak_hours — 3 rows, but on a
  # remote DB even a trivial query pays ~200-400ms of network round trip, so
  # caching it skips that entirely on repeat visits.
  def store_list
    Rails.cache.fetch('admin_store_analytics/stores', expires_in: 5.minutes) do
      Store.all.order(:name).to_a
    end
  end
end
