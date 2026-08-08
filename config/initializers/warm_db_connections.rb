# The DB is remote (Render, Ohio) — establishing a fresh Postgres connection
# (TCP + TLS + auth round trips) costs ~1.5-2.5s from here, on top of the
# ~200-400ms every query pays just for network RTT. Rails opens pool
# connections lazily on first use, so whichever request happens to be the
# first to need the Nth pooled connection eats that ~2s tax on its own
# critical path — this is what produced the 3.7s "Booking Load" spike in
# production logs even though the query itself runs in <1ms server-side.
#
# Opening every configured pool's connections once, up front at boot,
# moves that cost out of request latency entirely: by the time the first
# request arrives, every connection the pool can hand out has already paid
# its connection-establishment cost and is just sitting there idle, ready
# to reuse.
#
# Runs in a detached background thread (doesn't block `rails server` from
# accepting connections) and only runs under `rails server` (not
# console/rake/tests, which don't serve concurrent requests and don't
# benefit from a pre-filled pool).
#
# Deliberately fires one checkout per pool slot *simultaneously*, all at
# once, rather than a handful at a time: ConnectionPool#checkout only
# creates a genuinely new connection when no idle one is available, so
# anything short of `pool.size` connections being checked out at the same
# instant just has later checkouts reuse the few connections opened by the
# first batch — leaving most of the pool cold. All-at-once was measured to
# make each individual handshake slower under the contention (~4.3s ->
# ~6.3s as more piled on), but that's a one-time background cost, not
# something any request waits on, and it's the only way to actually end up
# with `pool.size` distinct warm connections sitting in the pool.
#
# Boot isn't the only time a connection goes cold, though: the network path
# to a remote DB also drops connections that just sit idle for a while
# (minutes, not hours — an admin dashboard checked once an hour will hit
# this on every visit). So beyond the one-time boot warm-up, the same
# routine is re-run on a timer for as long as the server is up, to catch
# connections that went idle long enough to be dropped and silently bring
# them back before a real request needs them.
if defined?(Rails::Server)
  warm_db_connection_pools = lambda do
    started = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    pools = ActiveRecord::Base.connection_handler.connection_pools
    pools.each do |pool|
      Array.new(pool.size) do
        Thread.new do
          pool.with_connection { |conn| conn.execute("SELECT 1") }
        rescue => e
          Rails.logger.warn("[warm_db_connections] failed to warm a connection for #{pool.db_config.name}: #{e.class}: #{e.message}")
        end
      end.each(&:join)
    end

    elapsed_ms = ((Process.clock_gettime(Process::CLOCK_MONOTONIC) - started) * 1000).round
    Rails.logger.info("[warm_db_connections] warmed #{pools.sum(&:size)} connections across #{pools.size} pool(s) in #{elapsed_ms}ms")
  end

  Rails.application.config.after_initialize do
    Thread.new { warm_db_connection_pools.call }

    # Re-warm well inside whatever idle window drops a connection, so the
    # pool never gets the chance to go fully cold between requests on a
    # quiet admin app.
    Concurrent::TimerTask.new(execution_interval: 3.minutes, timeout_interval: 30) do
      warm_db_connection_pools.call
    end.execute
  end
end
