require "net/http"

# Buffers page hits and beacon events (clicks, time on page) in process memory and writes them to
# page_views in bulk from one background thread, so tracking a visit costs
# the request zero DB round trips (the DB here is remote, ~60ms+ per trip).
#
# Each flush is a single INSERT (insert_all) of up to every hit buffered since
# the last flush, plus at most one batched geo-IP HTTP call for IPs not seen
# before. Trade-off: hits from the last FLUSH_INTERVAL show up on the
# dashboard after that delay, and a hard kill of the process loses them.
# A clean shutdown flushes via at_exit.
class PageViewTracker
  FLUSH_INTERVAL = 15 # seconds
  FLUSH_AT = 200      # flush early once this many hits are waiting
  MAX_BUFFER = 5_000  # stop buffering (drop hits) if the DB is unreachable

  # ip-api.com batch endpoint: up to 100 IPs per POST, no key needed. Set
  # TRAFFIC_GEO_LOOKUP=off to never send visitor IPs to it (location then
  # comes only from CDN headers such as Cloudflare's CF-IPCountry).
  GEO_ENDPOINT = URI("http://ip-api.com/batch?fields=status,country,regionName,city,query")
  GEO_BATCH = 100
  GEO_CACHE_MAX = 20_000
  PRIVATE_IP = /\A(127\.|10\.|192\.168\.|172\.(1[6-9]|2\d|3[01])\.|::1\z|fc|fd|fe80)/i

  # insert_all needs identical keys on every row; page views and beacon
  # events (clicks / time on page) fill different columns.
  ROW_TEMPLATE = {
    kind: "view", section: "store", visited_at: nil, path: "/", page: "Unknown", visitor_id: nil,
    new_visitor: false, device: nil, browser: nil, os: nil, referrer_host: nil, utm_source: nil,
    country: nil, region: nil, city: nil, user_type: nil, user_id: nil, label: nil, target: nil, duration: nil
  }.freeze

  @mutex = Mutex.new
  @wakeup = ConditionVariable.new
  @buffer = []
  @geo_cache = {}

  class << self
    # attrs: the page_views columns plus :ip (used for geo lookup, never stored).
    def record(attrs)
      @mutex.synchronize do
        ensure_flusher_running
        return if @buffer.size >= MAX_BUFFER

        @buffer << attrs
        @wakeup.signal if @buffer.size >= FLUSH_AT
      end
    end

    def flush
      batch = @mutex.synchronize { @buffer.slice!(0..) }
      return if batch.empty?

      resolve_locations(batch)
      rows = batch.map { |hit| ROW_TEMPLATE.merge(hit.except(:ip)) }
      Rails.application.executor.wrap do
        PageView.insert_all(rows, returning: false)
      end
    rescue => e
      Rails.logger.error("[PageViewTracker] flush of #{batch&.size} hits failed: #{e.class}: #{e.message}")
    end

    private

    # Threads don't survive fork, so (re)start per process.
    def ensure_flusher_running
      return if @pid == Process.pid && @thread&.alive?

      if @pid != Process.pid
        @buffer = []
        @pid = Process.pid
        at_exit { flush }
      end
      @thread = Thread.new { run_flusher }
      @thread.name = "page_view_tracker" if @thread.respond_to?(:name=)
    end

    def run_flusher
      loop do
        @mutex.synchronize { @wakeup.wait(@mutex, FLUSH_INTERVAL) if @buffer.size < FLUSH_AT }
        flush
      end
    end

    def resolve_locations(batch)
      lookup_ips = batch.filter_map { |hit| hit[:ip] if hit[:country].blank? && hit[:ip].present? }.uniq
      lookup_ips.reject! { |ip| @geo_cache.key?(ip) }
      local, remote = lookup_ips.partition { |ip| ip.match?(PRIVATE_IP) }
      local.each { |ip| @geo_cache[ip] = { country: "Local network" } }
      fetch_geo(remote) if remote.any? && ENV["TRAFFIC_GEO_LOOKUP"] != "off"

      batch.each do |hit|
        next if hit[:country].present?

        geo = @geo_cache[hit[:ip]]
        hit.merge!(geo) if geo
      end
    end

    def fetch_geo(ips)
      @geo_cache.clear if @geo_cache.size > GEO_CACHE_MAX
      ips.each_slice(GEO_BATCH) do |slice|
        response = Net::HTTP.start(GEO_ENDPOINT.host, GEO_ENDPOINT.port, open_timeout: 2, read_timeout: 3) do |http|
          http.post(GEO_ENDPOINT.request_uri, slice.to_json, "Content-Type" => "application/json")
        end
        next unless response.is_a?(Net::HTTPSuccess)

        JSON.parse(response.body).each do |row|
          next unless row["status"] == "success"

          @geo_cache[row["query"]] = { country: row["country"], region: row["regionName"], city: row["city"] }.compact_blank
        end
      end
    rescue => e
      # Location is best-effort: hits still get saved, just without a place.
      Rails.logger.warn("[PageViewTracker] geo lookup failed: #{e.class}: #{e.message}")
    end
  end
end
