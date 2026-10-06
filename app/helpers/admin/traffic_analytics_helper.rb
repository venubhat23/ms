module Admin::TrafficAnalyticsHelper
  TRAFFIC_KIND_ICONS = { "view" => "bi-eye", "click" => "bi-hand-index", "leave" => "bi-hourglass-split" }.freeze

  # 75 -> "1m 15s", 3700 -> "1h 1m"
  def traffic_duration(seconds)
    seconds = seconds.to_f.round
    return "0s" if seconds <= 0
    return "#{seconds}s" if seconds < 60
    return "#{seconds / 60}m #{format('%02d', seconds % 60)}s" if seconds < 3600

    "#{seconds / 3600}h #{(seconds % 3600) / 60}m"
  end

  def traffic_section_badge(section)
    content_tag(:span, TracksPageViews::SECTIONS[section] || section.to_s.humanize, class: "ta-badge s-#{section}")
  end

  def traffic_kind_icon(kind)
    content_tag(:span, content_tag(:i, nil, class: "bi #{TRAFFIC_KIND_ICONS[kind]}"), class: "ta-kind #{kind}", title: kind.to_s.humanize)
  end

  # Dashboard times arrive as local wall-clock ISO strings from SQL.
  def traffic_time(value)
    value.present? ? Time.zone.parse(value.to_s) : nil
  end

  def traffic_ago(value)
    time = traffic_time(value)
    return "" unless time

    time > 1.minute.ago ? "just now" : "#{time_ago_in_words(time)} ago"
  end

  # Journey link for a dashboard row: the logged-in account when known,
  # otherwise the anonymous browser.
  def traffic_journey_path(row, filter_params = {})
    if row["user_id"].present? && row["user_type"].present?
      admin_traffic_analytics_journey_path(filter_params.merge(user_type: row["user_type"], user_id: row["user_id"]))
    elsif row["visitor_id"].present?
      admin_traffic_analytics_journey_path(filter_params.merge(visitor: row["visitor_id"]))
    end
  end

  def traffic_initials(name)
    name.to_s.split.first(2).map { |part| part[0] }.join.upcase.presence || "?"
  end
end
