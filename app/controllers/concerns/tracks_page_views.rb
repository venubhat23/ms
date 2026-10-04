# Records a hit on a public storefront page for Admin > Traffic Analytics.
# Hands the hit to PageViewTracker's in-memory buffer (no DB call here) after
# the response is rendered; only successful HTML GETs by real browsers count.
#
#   track_page_views                          # every action
#   track_page_views only: [:public_view]     # some actions
module TracksPageViews
  extend ActiveSupport::Concern

  VISITOR_COOKIE = :_mvid

  # Friendly page names, keyed by "controller_path#action".
  PAGE_NAMES = {
    "home#index" => "Home",
    "storefront/carts#show" => "Cart",
    "storefront/checkout#show" => "Checkout",
    "storefront/checkout#confirmation" => "Order Confirmed",
    "order_tracking#index" => "Track Order",
    "order_tracking#show" => "Order Status",
    "order_tracking#invoice" => "Order Invoice",
    "booking_invoices#public_view" => "Shared Invoice",
    "customer/sessions#new" => "Customer Login",
    "customer/registrations#new" => "Customer Sign Up",
    "public_pages#adhika_privacy_policy" => "Privacy Policy",
    "public_pages#adhika_account_deletion_policy" => "Account Deletion Policy"
  }.freeze

  BOT_UA = /bot|crawl|spider|slurp|facebookexternalhit|whatsapp\/|telegram|preview|monitor|uptime|curl|wget|python|ruby|java\/|go-http|okhttp|axios|node-fetch|headless|lighthouse|pingdom|httpclient|scrapy/i

  class_methods do
    def track_page_views(**options)
      after_action :track_page_view, **options
    end
  end

  private

  def track_page_view
    return unless request.get? && response.status == 200 && response.media_type == "text/html"
    return if request.xhr? || params[:preview_theme].present? || prefetch_request?

    user_agent = request.user_agent.to_s
    return if user_agent.blank? || user_agent.match?(BOT_UA)

    visitor_id = cookies[VISITOR_COOKIE].to_s
    new_visitor = !visitor_id.match?(/\A\h{32}\z/)
    if new_visitor
      visitor_id = SecureRandom.hex(16)
      cookies.permanent[VISITOR_COOKIE] = { value: visitor_id, httponly: true, same_site: :lax }
    end

    PageViewTracker.record(
      visited_at: Time.current,
      path: tracked_path,
      page: PAGE_NAMES["#{controller_path}##{action_name}"] || "#{controller_path}##{action_name}".titleize,
      visitor_id: visitor_id,
      new_visitor: new_visitor,
      device: device_type(user_agent),
      browser: browser_name(user_agent),
      os: os_name(user_agent),
      referrer_host: external_referrer_host,
      utm_source: params[:utm_source].presence&.to_s&.first(100),
      country: request.headers["CF-IPCountry"].presence,
      region: request.headers["CF-Region"].presence,
      city: request.headers["CF-IPCity"].presence,
      ip: request.remote_ip
    )
  rescue => e
    Rails.logger.warn("[TracksPageViews] #{e.class}: #{e.message}")
  end

  # Pages with ids in the URL (e.g. /track-order/BK123) are stored by their
  # route pattern so they group together and no booking/invoice id is kept.
  def tracked_path
    path = request.path_parameters.except(:controller, :action, :format).any? ? request.route_uri_pattern.to_s.delete_suffix("(.:format)") : request.path
    path.presence&.first(255) || "/"
  end

  def prefetch_request?
    purpose = request.headers["Sec-Purpose"] || request.headers["Purpose"] || request.headers["X-Moz"]
    purpose.to_s.include?("prefetch")
  end

  # Only off-site referrers; navigation inside the store is not a "source".
  def external_referrer_host
    host = URI.parse(request.referer.to_s).host
    host if host.present? && host != request.host
  rescue URI::InvalidURIError
    nil
  end

  def device_type(ua)
    if ua.match?(/iPad|Tablet|PlayBook|Silk/i) || (ua.match?(/Android/i) && !ua.match?(/Mobile/i))
      "Tablet"
    elsif ua.match?(/Mobi|iPhone|iPod|Android|Opera Mini|IEMobile/i)
      "Mobile"
    else
      "Desktop"
    end
  end

  def browser_name(ua)
    case ua
    when /Instagram/ then "Instagram App"
    when /FBAN|FBAV/ then "Facebook App"
    when /Edg/ then "Edge"
    when /OPR|Opera/ then "Opera"
    when /SamsungBrowser/ then "Samsung Internet"
    when /CriOS|Chrome/ then "Chrome"
    when /FxiOS|Firefox/ then "Firefox"
    when /Safari/ then "Safari"
    else "Other"
    end
  end

  def os_name(ua)
    case ua
    when /Android/ then "Android"
    when /iPhone|iPad|iPod/ then "iOS"
    when /Windows/ then "Windows"
    when /CrOS/ then "ChromeOS"
    when /Mac OS X|Macintosh/ then "macOS"
    when /Linux/ then "Linux"
    else "Other"
    end
  end
end
