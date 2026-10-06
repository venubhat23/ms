# Admin > Website Traffic > Views & Traffic: page views, clicks and time on
# page across every portal, recorded by TracksPageViews / TrafficEventsController
# / PageViewTracker.
#
# Every number on the index page comes from ONE SQL statement (a single round
# trip to the remote DB) that returns all aggregates as one JSON object, cached
# in-process for CACHE_TTL so refreshes and filter flips are cheap.
require "csv"

class Admin::TrafficAnalyticsController < Admin::ApplicationController
  skip_after_action :track_page_view

  RANGES = {
    "today" => "Today",
    "yesterday" => "Yesterday",
    "7d" => "Last 7 days",
    "30d" => "Last 30 days",
    "90d" => "Last 90 days",
    "365d" => "Last 12 months"
  }.freeze
  DEFAULT_RANGE = "30d".freeze
  MAX_CUSTOM_DAYS = 366
  CACHE_TTL = 30.seconds
  STATS_CACHE = LocalTtlCache.new
  SECTIONS = TracksPageViews::SECTIONS
  EXPORT_LIMIT = 100_000
  JOURNEY_LIMIT = 400

  # Display name for whoever was logged in, from the 4 account tables. `x` is
  # the alias of the row carrying user_type / user_id.
  PERSON_JOINS = <<~SQL.squish.freeze
    LEFT JOIN users pu ON x.user_type = 'User' AND pu.id = x.user_id
    LEFT JOIN customers pc ON x.user_type = 'Customer' AND pc.id = x.user_id
    LEFT JOIN sub_agents pa ON x.user_type = 'Affiliate' AND pa.id = x.user_id
    LEFT JOIN franchises pf ON x.user_type = 'Franchise' AND pf.id = x.user_id
  SQL
  PERSON_NAME = <<~SQL.squish.freeze
    coalesce(nullif(trim(concat_ws(' ', pu.first_name, pu.last_name)), ''),
             nullif(trim(concat_ws(' ', pc.first_name, pc.last_name)), ''),
             nullif(trim(concat_ws(' ', pa.first_name, pa.last_name)), ''),
             pf.name, x.user_type || ' #' || x.user_id)
  SQL
  PERSON_ROLE = "coalesce(initcap(pu.user_type), x.user_type)".freeze
  PERSON_CONTACT = "coalesce(pu.email, pc.mobile, pa.mobile, pf.mobile)".freeze

  def index
    load_filters
    @public_url = root_url
    cache_key = [@range, @from_date, @to_date, @section]
    @stats = STATS_CACHE.fetch(cache_key, CACHE_TTL) { load_stats }
  end

  # Everything one visitor (browser) or one logged-in account did, newest first.
  def journey
    load_filters
    @visitor_id = params[:visitor].to_s[/\A\h{32}\z/]
    @user_type = %w[User Customer Affiliate Franchise].find { |t| t == params[:user_type] }
    @user_id = params[:user_id].to_s[/\A\d+\z/]&.to_i
    unless @visitor_id || (@user_type && @user_id)
      redirect_to admin_traffic_analytics_path, alert: "Pick a visitor or user to see their journey."
      return
    end
    @journey = load_journey
  end

  def export
    load_filters
    scope = filtered_scope.order(:visited_at).limit(EXPORT_LIMIT)
    columns = %w[visited_at kind section page path label target duration visitor_id new_visitor user_type user_id
                 device browser os referrer_host utm_source country region city]
    csv = CSV.generate do |out|
      out << columns
      scope.pluck(*columns).each do |row|
        row[0] = row[0].in_time_zone.strftime("%Y-%m-%d %H:%M:%S")
        out << row
      end
    end
    filename = "traffic-#{@section}-#{@from_date}-to-#{@to_date}.csv"
    send_data csv, filename: filename, type: "text/csv"
  end

  private

  def load_filters
    @section = SECTIONS.key?(params[:section]) ? params[:section] : "all"
    from = parse_date(params[:from])
    to = parse_date(params[:to])
    if from && to
      from, to = to, from if from > to
      from = [from, to - (MAX_CUSTOM_DAYS - 1)].max
      @range = "custom"
      @from_date = from
      @to_date = [to, Time.zone.today].min
    else
      @range = RANGES.key?(params[:range]) ? params[:range] : DEFAULT_RANGE
      @from_date, @to_date = range_dates(@range)
    end
    @filter_params = { section: (@section unless @section == "all") }.merge(
      @range == "custom" ? { from: @from_date, to: @to_date } : { range: @range }
    ).compact
  end

  def parse_date(value)
    Date.iso8601(value.to_s) if value.present?
  rescue Date::Error
    nil
  end

  def range_dates(range)
    today = Time.zone.today
    case range
    when "today" then [today, today]
    when "yesterday" then [today - 1, today - 1]
    when "7d" then [today - 6, today]
    when "90d" then [today - 89, today]
    when "365d" then [today - 364, today]
    else [today - 29, today]
    end
  end

  def filtered_scope
    scope = PageView.where(visited_at: @from_date.in_time_zone...(@to_date + 1).in_time_zone)
    @section == "all" ? scope : scope.where(section: @section)
  end

  def section_sql
    @section == "all" ? "" : ActiveRecord::Base.sanitize_sql_array([" AND section = ?", @section])
  end

  def load_stats
    from = @from_date.in_time_zone
    to = (@to_date + 1).in_time_zone
    prev_from = from - (to - from)
    binds = { from:, to:, prev_from:, from_date: @from_date, to_date: @to_date, tz: Time.zone.tzinfo.name }

    sql = ActiveRecord::Base.sanitize_sql_array([<<~SQL, binds])
      WITH e AS (
        SELECT visited_at, (visited_at AT TIME ZONE 'UTC') AT TIME ZONE :tz AS lt, kind, section, visitor_id, new_visitor,
               page, path, label, target, duration, device, browser, os, referrer_host, utm_source,
               country, region, city, user_type, user_id
        FROM page_views
        WHERE visited_at >= :from AND visited_at < :to#{section_sql}
      ),
      v AS (SELECT * FROM e WHERE kind = 'view'),
      prev AS (
        SELECT count(*) AS views, count(DISTINCT visitor_id) AS visitors
        FROM page_views
        WHERE kind = 'view' AND visited_at >= :prev_from AND visited_at < :from#{section_sql}
      ),
      per_visitor AS (SELECT visitor_id, count(*) AS n FROM v GROUP BY 1)
      SELECT json_build_object(
        'views', (SELECT count(*) FROM v),
        'visitors', (SELECT count(*) FROM per_visitor),
        'bounced', (SELECT count(*) FROM per_visitor WHERE n = 1),
        'new_visitors', (SELECT count(DISTINCT visitor_id) FROM v WHERE new_visitor),
        'users', (SELECT count(DISTINCT (user_type, user_id)) FROM v WHERE user_id IS NOT NULL),
        'clicks', (SELECT count(*) FROM e WHERE kind = 'click'),
        'seconds', (SELECT coalesce(sum(duration), 0) FROM e WHERE kind = 'leave'),
        'prev_views', (SELECT views FROM prev),
        'prev_visitors', (SELECT visitors FROM prev),
        'live', (SELECT count(DISTINCT visitor_id) FROM page_views WHERE visited_at >= now() - interval '5 minutes'#{section_sql}),
        'daily', (
          SELECT json_agg(json_build_array(to_char(d, 'YYYY-MM-DD'), coalesce(c.views, 0), coalesce(c.visitors, 0), coalesce(c.clicks, 0)) ORDER BY d)
          FROM generate_series(CAST(:from_date AS date), CAST(:to_date AS date), interval '1 day') d
          LEFT JOIN (
            SELECT lt::date AS day, count(*) FILTER (WHERE kind = 'view') AS views,
                   count(DISTINCT visitor_id) FILTER (WHERE kind = 'view') AS visitors,
                   count(*) FILTER (WHERE kind = 'click') AS clicks
            FROM e GROUP BY 1
          ) c ON c.day = d::date
        ),
        'heat', (
          SELECT coalesce(json_agg(json_build_array(dow, hr, views)), '[]')
          FROM (SELECT extract(isodow FROM lt)::int AS dow, extract(hour FROM lt)::int AS hr, count(*) AS views FROM v GROUP BY 1, 2) h
        ),
        'sections', (
          SELECT coalesce(json_agg(t ORDER BY t.views DESC), '[]') FROM (
            SELECT section AS name, count(*) FILTER (WHERE kind = 'view') AS views,
                   count(DISTINCT visitor_id) FILTER (WHERE kind = 'view') AS visitors,
                   count(*) FILTER (WHERE kind = 'click') AS clicks,
                   coalesce(sum(duration) FILTER (WHERE kind = 'leave'), 0) AS seconds
            FROM e GROUP BY 1
          ) t
        ),
        'pages', (
          SELECT coalesce(json_agg(t), '[]') FROM (
            SELECT page AS name, path, section, count(*) FILTER (WHERE kind = 'view') AS views,
                   count(DISTINCT visitor_id) FILTER (WHERE kind = 'view') AS visitors,
                   count(*) FILTER (WHERE kind = 'click') AS clicks,
                   coalesce(sum(duration) FILTER (WHERE kind = 'leave'), 0) AS seconds
            FROM e GROUP BY page, path, section
            HAVING count(*) FILTER (WHERE kind = 'view') > 0
            ORDER BY views DESC LIMIT 20
          ) t
        ),
        'clicked', (
          SELECT coalesce(json_agg(t), '[]') FROM (
            SELECT label, target, page, section, count(*) AS clicks, count(DISTINCT visitor_id) AS visitors
            FROM e WHERE kind = 'click'
            GROUP BY label, target, page, section ORDER BY clicks DESC LIMIT 25
          ) t
        ),
        'entries', (
          SELECT coalesce(json_agg(t), '[]') FROM (
            SELECT page AS name, count(*) AS views FROM (
              SELECT DISTINCT ON (visitor_id, lt::date) page FROM v ORDER BY visitor_id, lt::date, lt
            ) f GROUP BY 1 ORDER BY 2 DESC LIMIT 8
          ) t
        ),
        'exits', (
          SELECT coalesce(json_agg(t), '[]') FROM (
            SELECT page AS name, count(*) AS views FROM (
              SELECT DISTINCT ON (visitor_id, lt::date) page FROM v ORDER BY visitor_id, lt::date, lt DESC
            ) f GROUP BY 1 ORDER BY 2 DESC LIMIT 8
          ) t
        ),
        'people', (
          SELECT coalesce(json_agg(t), '[]') FROM (
            SELECT x.user_type, x.user_id, #{PERSON_NAME} AS name, #{PERSON_ROLE} AS role, #{PERSON_CONTACT} AS contact,
                   x.views, x.clicks, x.seconds, x.sections, x.last_seen AS last_seen
            FROM (
              SELECT user_type, user_id, count(*) FILTER (WHERE kind = 'view') AS views,
                     count(*) FILTER (WHERE kind = 'click') AS clicks,
                     coalesce(sum(duration) FILTER (WHERE kind = 'leave'), 0) AS seconds,
                     string_agg(DISTINCT section, ',') AS sections, max(lt) AS last_seen
              FROM e WHERE user_id IS NOT NULL
              GROUP BY user_type, user_id ORDER BY views DESC LIMIT 20
            ) x #{PERSON_JOINS}
            ORDER BY x.views DESC
          ) t
        ),
        'recent', (
          SELECT coalesce(json_agg(t), '[]') FROM (
            SELECT x.lt AS at, x.kind, x.section, x.page, x.path, x.label, x.target,
                   x.duration, x.device, x.city, x.country, x.visitor_id, x.user_type, x.user_id,
                   CASE WHEN x.user_id IS NOT NULL THEN #{PERSON_NAME} END AS name
            FROM (SELECT * FROM e ORDER BY visited_at DESC LIMIT 60) x #{PERSON_JOINS}
            ORDER BY x.visited_at DESC
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

  def load_journey
    who = if @visitor_id
            ActiveRecord::Base.sanitize_sql_array(["visitor_id = ?", @visitor_id])
          else
            ActiveRecord::Base.sanitize_sql_array(["user_type = ? AND user_id = ?", @user_type, @user_id])
          end
    binds = { tz: Time.zone.tzinfo.name, limit: JOURNEY_LIMIT }

    sql = ActiveRecord::Base.sanitize_sql_array([<<~SQL, binds])
      WITH j AS (
        SELECT * FROM page_views WHERE #{who} ORDER BY visited_at DESC LIMIT :limit
      )
      SELECT json_build_object(
        'summary', (
          SELECT json_build_object(
            'views', count(*) FILTER (WHERE kind = 'view'), 'clicks', count(*) FILTER (WHERE kind = 'click'),
            'seconds', coalesce(sum(duration) FILTER (WHERE kind = 'leave'), 0),
            'visitors', count(DISTINCT visitor_id),
            'first', min((visited_at AT TIME ZONE 'UTC') AT TIME ZONE :tz),
            'last', max((visited_at AT TIME ZONE 'UTC') AT TIME ZONE :tz)
          ) FROM j
        ),
        'person', (
          SELECT json_build_object('user_type', x.user_type, 'user_id', x.user_id, 'name', #{PERSON_NAME},
                                   'role', #{PERSON_ROLE}, 'contact', #{PERSON_CONTACT})
          FROM (SELECT user_type, user_id FROM j WHERE user_id IS NOT NULL ORDER BY visited_at DESC LIMIT 1) x #{PERSON_JOINS}
        ),
        'events', (
          SELECT coalesce(json_agg(json_build_object(
            'at', (visited_at AT TIME ZONE 'UTC') AT TIME ZONE :tz,
            'kind', kind, 'section', section, 'page', page, 'path', path, 'label', label, 'target', target,
            'duration', duration, 'device', device, 'browser', browser, 'os', os, 'city', city, 'country', country,
            'referrer', referrer_host, 'utm', utm_source, 'visitor_id', visitor_id
          ) ORDER BY visited_at DESC), '[]') FROM j
        )
      )
    SQL
    JSON.parse(ActiveRecord::Base.connection.select_value(sql))
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
