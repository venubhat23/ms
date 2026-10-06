# Records every page load across all portals (public store, customer portal,
# affiliate, franchise, store admin, admin) for Admin > Traffic Analytics.
# Included once in ApplicationController; a controller opts out with
# `skip_after_action :track_page_view`.
#
# The hit goes to PageViewTracker's in-memory buffer (no DB call here) after
# the response is rendered; only successful full-page HTML GETs by real
# browsers count. The same after_action injects a tiny beacon script before
# </body> that reports clicks and time-on-page to TrafficEventsController.
#
# Who: the logged-in account is read straight from the session (no query) and
# stored as user_type + user_id; names are resolved on the dashboard.
module TracksPageViews
  extend ActiveSupport::Concern

  VISITOR_COOKIE = :_mvid

  SECTIONS = {
    "store" => "Public Store",
    "customer" => "Customer Portal",
    "affiliate" => "Affiliate Portal",
    "franchise" => "Franchise Portal",
    "store_admin" => "Store Admin",
    "admin" => "Admin Panel"
  }.freeze

  # Friendly page names, keyed by "controller_path#action". Anything not
  # listed gets "<Controller> · <Action>" (see #default_page_name).
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
    "affiliate/sessions#new" => "Affiliate Login",
    "affiliate/registrations#new" => "Affiliate Sign Up",
    "franchise/sessions#new" => "Franchise Login",
    "store_admin/sessions#new" => "Store Admin Login",
    "user/sessions#new" => "Admin Login",
    "users/sessions#new" => "Admin Login",
    "dashboard#index" => "Dashboard",
    "public_pages#adhika_privacy_policy" => "Privacy Policy",
    "public_pages#adhika_account_deletion_policy" => "Account Deletion Policy"
  }.freeze

  ACTION_LABELS = { "index" => nil, "show" => "Details", "new" => "New", "edit" => "Edit" }.freeze

  BOT_UA = /bot|crawl|spider|slurp|facebookexternalhit|whatsapp\/|telegram|preview|monitor|uptime|curl|wget|python|ruby|java\/|go-http|okhttp|axios|node-fetch|headless|lighthouse|pingdom|httpclient|scrapy/i

  # Runs once per full page load. Keeps a single state object on window so
  # Turbo navigations (which re-run this script) close out the previous page.
  # Sends text/plain via sendBeacon (no CORS preflight, survives unload).
  BEACON_JS = <<~JS.squish.freeze
    (function(w,d){var s=d.currentScript;if(!s)return;
    var T=w.__mvt;if(!T){T=w.__mvt={q:[],url:s.dataset.url};
    T.send=function(){clearTimeout(T.tm);if(!T.q.length)return;var b=JSON.stringify({e:T.q.splice(0,30)});
    if(!(navigator.sendBeacon&&navigator.sendBeacon(T.url,b))){try{fetch(T.url,{method:"POST",body:b,keepalive:true,credentials:"same-origin"})}catch(_){}}};
    T.later=function(){if(T.q.length>=10)T.send();else{clearTimeout(T.tm);T.tm=setTimeout(T.send,4000)}};
    T.pause=function(){var c=T.cur;if(!c||!c.since)return;c.ms+=Date.now()-c.since;c.since=0};
    T.leave=function(){var c=T.cur;if(!c)return;T.pause();var sec=Math.min(Math.round(c.ms/1000),1800);c.ms=0;
    if(sec>0)T.q.push({k:"l",d:sec,p:c.page,u:c.path,s:c.section})};
    d.addEventListener("visibilitychange",function(){if(d.visibilityState==="hidden"){T.leave();T.send()}else if(T.cur){T.cur.since=Date.now()}});
    w.addEventListener("pagehide",function(){T.leave();T.send()});
    d.addEventListener("click",function(e){var c=T.cur,el=e.target&&e.target.closest&&e.target.closest("a,button,summary,[role=button],[data-track],input[type=submit],input[type=button]");
    if(!c||!el)return;var img=el.querySelector&&el.querySelector("img[alt]");
    var l=(el.getAttribute("data-track")||el.getAttribute("aria-label")||el.innerText||el.value||el.title||(img&&img.alt)||"").replace(/\\s+/g," ").trim().slice(0,120);
    var h=el.getAttribute("href")||(el.form&&el.form.getAttribute("action"))||"",t="";
    if(h&&h.charAt(0)!=="#"&&!/^(javascript|mailto|tel):/i.test(h)){try{var u=new URL(h,location.href);t=u.host===location.host?u.pathname:u.host+u.pathname}catch(_){}}
    else if(/^(mailto|tel):/i.test(h)){t=h.split(":")[0]}
    T.q.push({k:"c",l:l||el.tagName.toLowerCase(),t:t,p:c.page,u:c.path,s:c.section});T.later()},true)}
    T.leave();T.cur={page:s.dataset.page,path:s.dataset.path,section:s.dataset.section,ms:0,since:d.visibilityState==="visible"?Date.now():0};T.later()
    })(window,document);
  JS

  included do
    after_action :track_page_view
  end

  private

  def track_page_view
    return unless request.get? && response.status == 200 && response.media_type == "text/html"
    return if request.xhr? || request.headers["Turbo-Frame"].present? || params[:preview_theme].present? || prefetch_request?

    user_agent = request.user_agent.to_s
    return if user_agent.blank? || user_agent.match?(BOT_UA)

    visitor_id = cookies[VISITOR_COOKIE].to_s
    new_visitor = !visitor_id.match?(/\A\h{32}\z/)
    if new_visitor
      visitor_id = SecureRandom.hex(16)
      cookies.permanent[VISITOR_COOKIE] = { value: visitor_id, httponly: true, same_site: :lax }
    end

    section = tracked_section
    page = PAGE_NAMES["#{controller_path}##{action_name}"] || default_page_name
    path = tracked_path
    user_type, user_id = tracked_identity(section)

    PageViewTracker.record(
      **visitor_attributes(user_agent),
      kind: "view",
      section: section,
      visited_at: Time.current,
      path: path,
      page: page,
      visitor_id: visitor_id,
      new_visitor: new_visitor,
      user_type: user_type,
      user_id: user_id,
      referrer_host: external_referrer_host,
      utm_source: params[:utm_source].presence&.to_s&.first(100)
    )
    inject_tracking_beacon(page, path, section)
  rescue => e
    Rails.logger.warn("[TracksPageViews] #{e.class}: #{e.message}")
  end

  # Device / browser / location fields shared by page views and beacon events.
  def visitor_attributes(user_agent)
    {
      device: device_type(user_agent),
      browser: browser_name(user_agent),
      os: os_name(user_agent),
      country: request.headers["CF-IPCountry"].presence,
      region: request.headers["CF-Region"].presence,
      city: request.headers["CF-IPCity"].presence,
      ip: request.remote_ip
    }
  end

  def inject_tracking_beacon(page, path, section)
    body = response.body
    return unless body.is_a?(String) && (at = body.rindex("</body>"))

    tag = %(<script data-mvt data-url="#{traffic_events_path}" data-page="#{ERB::Util.h(page)}" ) +
          %(data-path="#{ERB::Util.h(path)}" data-section="#{section}">#{BEACON_JS}</script>)
    response.body = body.dup.insert(at, tag)
  end

  def tracked_section
    case controller_path
    when %r{\Aaffiliate/} then "affiliate"
    when %r{\Afranchise/} then "franchise"
    when %r{\Acustomer/} then "customer"
    when %r{\Astore_admin/} then "store_admin"
    when %r{\A(admin|user|users|devise)/}, "dashboard", "sessions", "vendor_invoices" then "admin"
    else "store"
    end
  end

  # Read from the session only (no DB query). Each portal has its own login.
  def tracked_identity(section)
    warden_user_id = Array(Array(session["warden.user.user.key"]).first).first
    candidates =
      case section
      when "affiliate" then [["Affiliate", session[:affiliate_id]], ["User", warden_user_id]]
      when "franchise" then [["Franchise", session[:franchise_id]], ["User", warden_user_id]]
      when "store", "customer" then [["Customer", session[:customer_id]], ["User", warden_user_id]]
      else [["User", warden_user_id]]
      end
    type, id = candidates.find { |_, value| value.to_s.match?(/\A\d+\z/) }
    type ? [type, id.to_i] : [nil, nil]
  rescue StandardError
    [nil, nil]
  end

  def default_page_name
    name = controller_name.humanize
    label = ACTION_LABELS.fetch(action_name) { action_name.humanize }
    label ? "#{name} · #{label}" : name
  end

  # Pages with ids in the URL (e.g. /track-order/BK123) are stored by their
  # route pattern so they group together and no booking/invoice id is kept.
  def tracked_path
    path = request.path_parameters.except(:controller, :action, :format).any? ? request.route_uri_pattern.to_s.delete_suffix("(.:format)") : request.path
    path.presence&.first(255) || "/"
  end

  def prefetch_request?
    purpose = request.headers["Sec-Purpose"] || request.headers["X-Sec-Purpose"] || request.headers["Purpose"] || request.headers["X-Moz"]
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
