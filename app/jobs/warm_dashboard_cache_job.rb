class WarmDashboardCacheJob < ApplicationJob
  queue_as :default

  # Refreshes the same Rails.cache keys DashboardController#index reads, ahead of
  # their expiry, so real visitors never land on a cold cache. Reuses the
  # controller's own caching method directly (no request/session/params needed —
  # load_ecommerce_dashboard_data and everything it calls only touch the DB and
  # Rails.cache) instead of duplicating the cache keys/logic here, which would
  # drift out of sync over time.
  def perform
    DashboardController.new.send(:load_ecommerce_dashboard_data)
  end
end
