class WarmSidebarCacheJob < ApplicationJob
  queue_as :default

  # layouts/_sidebar.html.erb renders on every admin page, so a cold miss on
  # either of these two badge counts is a tax paid app-wide, not just on one
  # page. TTL (3 min) is kept longer than this job's schedule (1 min) so a
  # request never lands in the gap right after expiry but before the next
  # warm run. Same rationale as the other Warm*CacheJob jobs.
  def perform
    Rails.cache.fetch('sidebar/stock_transfers_pending_count', expires_in: 3.minutes) do
      StockTransfer.pending.count
    end

    Rails.cache.fetch('sidebar/milk_subscription_active_customers_count', expires_in: 3.minutes) do
      MilkSubscription.joins(:customer).where(is_active: true).select(:customer_id).distinct.count
    end
  end
end
