# Receives the tracking beacon injected by TracksPageViews: batched clicks
# ('c') and time-on-page segments ('l') as text/plain JSON via sendBeacon.
# Events go to PageViewTracker's in-memory buffer, so this costs no DB call.
# Always answers 204 so a bad payload never shows up as a browser error.
class TrafficEventsController < ActionController::Base
  include TracksPageViews
  skip_after_action :track_page_view
  skip_forgery_protection

  MAX_EVENTS = 30
  MAX_BODY = 16.kilobytes
  KINDS = { "c" => "click", "l" => "leave" }.freeze

  def create
    record_events if trusted_request?
    head :no_content
  end

  private

  def trusted_request?
    user_agent = request.user_agent.to_s
    return false if user_agent.blank? || user_agent.match?(BOT_UA)
    return false if request.content_length.to_i > MAX_BODY
    return false unless cookies[VISITOR_COOKIE].to_s.match?(/\A\h{32}\z/)

    origin = request.origin.presence || request.referer.presence
    origin.nil? || URI.parse(origin).host == request.host
  rescue URI::InvalidURIError
    false
  end

  def record_events
    events = JSON.parse(request.raw_post)["e"]
    return unless events.is_a?(Array)

    base = visitor_attributes(request.user_agent.to_s).merge(
      visited_at: Time.current, visitor_id: cookies[VISITOR_COOKIE].to_s, new_visitor: false
    )
    identities = {}

    events.first(MAX_EVENTS).each do |event|
      next unless event.is_a?(Hash) && (kind = KINDS[event["k"]]) && SECTIONS.key?(event["s"])

      section = event["s"]
      user_type, user_id = identities[section] ||= tracked_identity(section)
      attrs = base.merge(
        kind: kind, section: section, user_type: user_type, user_id: user_id,
        page: clean(event["p"], 255) || "Unknown", path: clean(event["u"], 255) || "/"
      )
      if kind == "click"
        attrs[:label] = mask_label(clean(event["l"], 120))
        attrs[:target] = normalize_target(clean(event["t"], 255))
      else
        seconds = event["d"].to_i
        next unless seconds.between?(1, 1800)

        attrs[:duration] = seconds
      end
      PageViewTracker.record(attrs)
    end
  rescue JSON::ParserError
    nil
  end

  def clean(value, limit)
    value.is_a?(String) ? value.squish.first(limit).presence : nil
  end

  # Button/link text can hold phone numbers or emails (e.g. a customer row on
  # an admin list); keep the shape, drop the personal data.
  def mask_label(label)
    label&.gsub(/[\w.+-]+@[\w-]+\.[\w.]+/, "[email]")&.gsub(/\d{6,}/, "••••")
  end

  # /admin/bookings/123/edit -> /admin/bookings/:id/edit so targets group.
  def normalize_target(target)
    return if target.blank?

    target.split("/", -1).map { |seg| seg.match?(/\A\d+\z|\A(?=.*\d)[\w-]{12,}\z/) ? ":id" : seg }.join("/")
  end
end
