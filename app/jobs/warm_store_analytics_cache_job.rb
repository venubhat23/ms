class WarmStoreAnalyticsCacheJob < ApplicationJob
  queue_as :default

  # Refreshes Admin::StoreAnalyticsController's comparison/top_products/peak_hours
  # cache entries ahead of their expiry, for the current month and every store
  # (nil = "all stores", plus each individual store shown in the dropdown), so a
  # real admin visit never pays the cold-cache DB round trips. Reuses the
  # controller's own private cache methods directly (no request/session/params
  # needed) instead of duplicating the cache keys/logic here, which would drift
  # out of sync over time.
  def perform
    controller = Admin::StoreAnalyticsController.new
    month = Date.current.beginning_of_month
    store_ids = controller.send(:store_list).map(&:id)

    controller.send(:comparison_data, month)

    ([nil] + store_ids).each do |store_id|
      controller.send(:top_products_data, month, store_id)
      controller.send(:peak_hours_data, store_id)
    end
  end
end
