# Admin > Website Traffic > Views & Traffic: visits to the public storefront,
# recorded by TracksPageViews / PageViewTracker.
#
# Every number on the page comes from ONE SQL statement (a single round trip
# to the remote DB) that returns all aggregates as one JSON object, cached
# in-process for CACHE_TTL so refreshes and range flips are free.
class Admin::TrafficAnalyticsController < Admin::ApplicationController
  RANGES = {
    "today" => "Today",
    "7d" => "Last 7 days",
    "30d" => "Last 30 days",
    "90d" => "Last 90 days",
    "365d" => "Last 12 months"
  }.freeze
  DEFAULT_RANGE = "30d".freeze
  CACHE_TTL = 30.seconds
  STATS_CACHE = LocalTtlCache.new

  def index
    @range = RANGES.key?(params[:range]) ? params[:range] : DEFAULT_RANGE
    @from_date = range_start(@range)
    @to_date = Time.zone.today
    @public_url = root_url
    @stats = STATS_CACHE.fetch([@range, @to_date], CACHE_TTL) { load_stats(@from_date, @to_date) }
  end

  private

  def range_start(range)
    case range
    when "today" then Time.zone.today
    when "7d" then 6.days.ago.to_date
    when "90d" then 89.days.ago.to_date
    when "365d" then 364.days.ago.to_date
    else 29.days.ago.to_date
    end
  end

  def load_stats(from_date, to_date)
    from = from_date.in_time_zone
    to = (to_date + 1).in_time_zone
    prev_from = from - (to - from)

    sql = ActiveRecord::Base.sanitize_sql_array([<<~SQL, { from:, to:, prev_from:, from_date:, to_date:, tz: Time.zone.tzinfo.name }])
      WITH v AS (
        SELECT (visited_at AT TIME ZONE 'UTC') AT TIME ZONE :tz AS lt, visitor_id, new_visitor,
               page, path, device, browser, os, referrer_host, utm_source, country, region, city
        FROM page_views
        WHERE visited_at >= :from AND visited_at < :to
      ),
      prev AS (
        SELECT count(*) AS views, count(DISTINCT visitor_id) AS visitors
        FROM page_views
        WHERE visited_at >= :prev_from AND visited_at < :from
      )
      SELECT json_build_object(
        'views', (SELECT count(*) FROM v),
        'visitors', (SELECT count(DISTINCT visitor_id) FROM v),
        'new_visitors', (SELECT count(DISTINCT visitor_id) FROM v WHERE new_visitor),
        'prev_views', (SELECT views FROM prev),
        'prev_visitors', (SELECT visitors FROM prev),
        'live', (SELECT count(DISTINCT visitor_id) FROM page_views WHERE visited_at >= now() - interval '5 minutes'),
        'daily', (
          SELECT json_agg(json_build_array(to_char(d, 'YYYY-MM-DD'), coalesce(c.views, 0), coalesce(c.visitors, 0)) ORDER BY d)
          FROM generate_series(CAST(:from_date AS date), CAST(:to_date AS date), interval '1 day') d
          LEFT JOIN (
            SELECT lt::date AS day, count(*) AS views, count(DISTINCT visitor_id) AS visitors FROM v GROUP BY 1
          ) c ON c.day = d::date
        ),
        'heat', (
          SELECT coalesce(json_agg(json_build_array(dow, hr, views)), '[]')
          FROM (SELECT extract(isodow FROM lt)::int AS dow, extract(hour FROM lt)::int AS hr, count(*) AS views FROM v GROUP BY 1, 2) h
        ),
        'pages', (
          SELECT coalesce(json_agg(t), '[]') FROM (
            SELECT page AS name, path, count(*) AS views, count(DISTINCT visitor_id) AS visitors
            FROM v GROUP BY page, path ORDER BY views DESC LIMIT 12
          ) t
        ),
        'devices', #{top_sql("device")},
        'browsers', #{top_sql("browser")},
        'os', #{top_sql("os")},
        'referrers', #{top_sql("coalesce(referrer_host, 'Direct')", limit: 10)},
        'campaigns', #{top_sql("utm_source", limit: 10, skip_null: true)},
        'countries', #{top_sql("country", limit: 10)},
        'cities', #{top_sql("concat_ws(', ', city, region)", limit: 12, skip_null: true, where: "city IS NOT NULL")}
      ) AS stats
    SQL

    stats = JSON.parse(ActiveRecord::Base.connection.select_value(sql))
    hourly = Array.new(24, 0)
    weekday = Array.new(7, 0)
    stats["heat"].each do |dow, hour, views|
      hourly[hour] += views
      weekday[dow - 1] += views
    end
    stats.merge("hourly" => hourly, "weekday" => weekday)
  end

  # `expr` is always a fixed column expression from this file, never user input.
  def top_sql(expr, limit: 6, skip_null: false, where: nil)
    conditions = [("#{expr} IS NOT NULL" if skip_null), where].compact
    filter = conditions.any? ? "WHERE #{conditions.join(' AND ')}" : ""
    <<~SQL.squish
      (SELECT coalesce(json_agg(t), '[]') FROM (
        SELECT coalesce(#{expr}, 'Unknown') AS name, count(*) AS views, count(DISTINCT visitor_id) AS visitors
        FROM v #{filter} GROUP BY 1 ORDER BY views DESC LIMIT #{limit.to_i}
      ) t)
    SQL
  end
end
