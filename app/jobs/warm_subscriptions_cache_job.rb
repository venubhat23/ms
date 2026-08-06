class WarmSubscriptionsCacheJob < ApplicationJob
  queue_as :default

  # Keeps Admin::SubscriptionsController#index's filter-dropdown and stats
  # cache entries warm ahead of their expiry — same rationale as the other
  # Warm*CacheJob jobs.
  def perform
    Rails.cache.fetch('admin_subscriptions/filter_customers', expires_in: 5.minutes) do
      Customer.order(:first_name, :last_name).pluck(:first_name, :last_name, :id).map { |f, l, id| ["#{f} #{l}".strip, id] }
    end

    Rails.cache.fetch('admin_subscriptions/filter_products', expires_in: 5.minutes) do
      Product.where(product_type: 'milk').order(:name).pluck(:name, :id)
    end

    Rails.cache.fetch('admin_subscriptions/filter_delivery_people', expires_in: 5.minutes) do
      DeliveryPerson.where(status: true).order(:first_name, :last_name).pluck(:first_name, :last_name, :id).map { |f, l, id| ["#{f} #{l}".strip, id] }
    end

    Rails.cache.fetch('admin_subscriptions/stats', expires_in: 2.minutes) do
      status_counts = MilkSubscription.group(:status).count

      today_deliveries = MilkDeliveryTask.for_today.count
      pending_today = MilkDeliveryTask.for_today.pending.count

      total_delivery_people = DeliveryPerson.where(status: true).count
      assigned_delivery_people = MilkDeliveryTask
        .joins(:delivery_person)
        .where(status: ['pending', 'assigned'])
        .where(delivery_people: { status: true })
        .select(:delivery_person_id)
        .distinct
        .count

      {
        total: status_counts.values.sum,
        active: status_counts['active'] || 0,
        paused: status_counts['paused'] || 0,
        expired: status_counts['expired'] || 0,
        today_deliveries: today_deliveries,
        pending_today: pending_today,
        total_delivery_people: total_delivery_people,
        assigned_delivery_people: assigned_delivery_people
      }
    end
  end
end
