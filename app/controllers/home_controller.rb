class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  skip_load_and_authorize_resource
  skip_before_action :set_cache_control_headers
  skip_before_action :ensure_session_security

  TOP_CATEGORY_TTL = 30.minutes
  BEST_SELLERS_TTL = 30.minutes
  ACTIVE_CATEGORIES_TTL = 30.minutes

  # Cacheable stand-in for a Category row — only what the homepage banners
  # need, so a cache hit needs zero AR/ActiveStorage objects rebuilt.
  CategoryBanner = Struct.new(:id, :name, :display_image_url)

  # Rails.cache is Solid Cache here, and Solid Cache's `cache` database
  # (config/database.yml) points at the same cross-region Postgres as the
  # primary DB — so a Rails.cache "hit" still pays a full network round trip,
  # same as an uncached query would. On this deployment that round trip runs
  # ~700-900ms (see config/initializers/warm_db_connections.rb), and a single
  # homepage request makes ~9-10 of them (theme lookup + version counters +
  # category/best-seller cache reads + the always-uncached catalog query).
  #
  # This second, in-process cache sits in front of all of that. A hit here is
  # a plain Ruby object read with no network hop at all, so it turns every
  # request landing inside the TTL window into a near-zero-latency response;
  # only one request per worker, once per window, pays the full remote cost
  # to repopulate it. Short TTLs keep staleness imperceptible — well under
  # the 30-minute TTLs the underlying Rails.cache entries already tolerate.
  PAYLOAD_LOCAL_TTL = 15.seconds
  THEME_LOCAL_TTL = 60.seconds

  @payload_mutex = Mutex.new
  @theme_mutex = Mutex.new

  class << self
    attr_accessor :cached_payload, :payload_expires_at, :cached_theme, :theme_expires_at
    attr_reader :payload_mutex, :theme_mutex
  end

  def index
    # `preview_theme` (used only by the admin theme-picker's Preview links) is
    # always checked against WEBSITE_THEMES's fixed key set below, never used
    # to build a path directly — no arbitrary file read is possible here.
    theme_key = params[:preview_theme].presence_in(SystemSetting::WEBSITE_THEMES.keys) || cached_website_theme

    payload = cached_home_payload
    @products_by_category = payload[:products_by_category]
    @total_products = payload[:total_products]
    @best_seller_ids = payload[:best_seller_ids]
    @new_arrivals = payload[:new_arrivals]
    @new_arrival_ids = payload[:new_arrival_ids]
    @top_category = payload[:top_category]
    @secondary_category = payload[:secondary_category]

    render template: "home/#{theme_key.underscore}", layout: false
  end

  private

  # Local (in-process, per-worker) memoization of SystemSetting.website_theme
  # — otherwise an uncached DB query on every single homepage request for a
  # value that only ever changes when an admin edits it in Settings.
  def cached_website_theme
    now = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    klass = self.class
    return klass.cached_theme if klass.cached_theme && klass.theme_expires_at.to_f > now

    klass.theme_mutex.synchronize do
      return klass.cached_theme if klass.cached_theme && klass.theme_expires_at.to_f > now
      klass.cached_theme = SystemSetting.website_theme
      klass.theme_expires_at = now + THEME_LOCAL_TTL
    end
    klass.cached_theme
  end

  # Local (in-process, per-worker) memoization of the whole homepage data
  # bundle. See PAYLOAD_LOCAL_TTL above for why this exists on top of the
  # already-Rails.cache-backed methods it calls.
  def cached_home_payload
    now = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    klass = self.class
    return klass.cached_payload if klass.cached_payload && klass.payload_expires_at.to_f > now

    klass.payload_mutex.synchronize do
      return klass.cached_payload if klass.cached_payload && klass.payload_expires_at.to_f > now
      klass.cached_payload = build_home_payload
      klass.payload_expires_at = now + PAYLOAD_LOCAL_TTL
    end
    klass.cached_payload
  end

  def build_home_payload
    all_products = load_catalog_products
    load_top_categories

    # Same rows load_catalog_products already fetched — reordering them in
    # Ruby avoids a second full products round trip that was otherwise
    # identical to the first query bar the ORDER BY/LIMIT.
    new_arrivals = all_products.sort_by(&:created_at).reverse.first(8)

    {
      products_by_category: @products_by_category,
      total_products: @total_products,
      best_seller_ids: cached_best_seller_ids.to_set,
      new_arrivals: new_arrivals,
      new_arrival_ids: new_arrivals.map(&:id).to_set,
      top_category: @top_category,
      secondary_category: @secondary_category
    }
  end

  # Guest cart count for the storefront nav badge — same session[:cart] the
  # Storefront::CartsController reads/writes.
  def cart_count
    items = session[:cart].try(:[], 'items') || session[:cart].try(:[], :items)
    return 0 if items.blank?
    items.sum { |item| item['quantity'].to_i }
  end
  helper_method :cart_count

  # Per-product active stock, aggregated once instead of once per product
  # (avoids the total_batch_stock N+1 that in_stock?/low_stock? would
  # otherwise trigger for every card rendered on the page).
  def stock_subquery
    StockBatch.where(status: 'active')
              .where('quantity_remaining > 0')
              .select('product_id, SUM(quantity_remaining) AS total_stock')
              .group(:product_id)
  end

  # Real catalog data, grouped by category, shared by every theme template.
  # Returns the flat product array too, so callers (e.g. new-arrivals) can
  # reorder it in Ruby instead of paying for a second DB round trip.
  def load_catalog_products
    products = Product.active
                       .select("products.*, COALESCE(sq.total_stock, 0) AS cached_stock")
                       .joins("LEFT JOIN (#{stock_subquery.to_sql}) sq ON sq.product_id = products.id")
                       .includes(:category, image_attachment: :blob)
                       .references(:category)
                       .order(Arel.sql("categories.display_order ASC NULLS LAST, categories.name ASC, products.name ASC"))
                       .to_a

    @products_by_category = products.group_by { |p| p.category&.name.presence || 'Other' }
    @total_products = products.size
    products
  end

  # Top-selling + secondary category banners for the homepage hero. Both the
  # sales ranking (expensive join across products/booking_items/bookings) and
  # the resolved category rows themselves (name + image URL, so a cache hit
  # touches zero AR/ActiveStorage objects) are cached — categories are
  # admin-managed and change rarely, so this is the biggest single cut to
  # per-request DB round trips on this page.
  # Cache keys ride on MobileApiCache's product/category version counters,
  # already bumped on every product/category write and on booking placement
  # (Booking's stock-change path calls MobileApiCache.bust_booking! ->
  # bust_products!), so this invalidates itself with no new plumbing.
  def load_top_categories
    categories_key = "home/active_category_banners/#{MobileApiCache.category_version}"
    banners = Rails.cache.fetch(categories_key, expires_in: ACTIVE_CATEGORIES_TTL) do
      Category.active.includes(image_attachment: :blob).ordered.to_a.map do |c|
        CategoryBanner.new(c.id, c.name, c.display_image_url)
      end
    end

    ranking_key = "home/top_selling_category_id/#{MobileApiCache.product_version}/#{MobileApiCache.category_version}"
    top_id = Rails.cache.fetch(ranking_key, expires_in: TOP_CATEGORY_TTL) { Category.top_selling&.id }

    @top_category = banners.find { |c| c.id == top_id } || banners.first
    @secondary_category = banners.find { |c| c.id != @top_category&.id }
  end

  # Best-seller ids for the "Bestseller" badge — same expensive sales join
  # as load_top_categories, cached the same way.
  def cached_best_seller_ids
    cache_key = "home/best_seller_ids/#{MobileApiCache.product_version}"
    Rails.cache.fetch(cache_key, expires_in: BEST_SELLERS_TTL) { Product.best_seller_ids }
  end
end