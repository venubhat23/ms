class WarmAdminBookingsCacheJob < ApplicationJob
  queue_as :default

  # Refreshes the shared, filter-independent Admin::BookingsController#index cache
  # entries ahead of their expiry (categories/affiliates/customers dropdowns, the
  # pagination setting, and the base "all bookings" status counts) so the common
  # case — a staff member opening the unfiltered list — never pays the cold-cache
  # DB round trips. Per-filter listing results aren't warmed here: there's no
  # fixed set of filter/page combinations to pre-populate.
  def perform
    Rails.cache.fetch('admin_bookings/filter_categories', expires_in: 5.minutes) do
      Category.where(status: true).order(:display_order, :name).to_a
    end

    Rails.cache.fetch('admin_bookings/filter_affiliates', expires_in: 5.minutes) do
      Affiliate.where(status: true).order(:first_name, :last_name).to_a
    end

    Rails.cache.fetch('system_setting/default_pagination_per_page', expires_in: 5.minutes) do
      SystemSetting.default_pagination_per_page
    end

    Rails.cache.fetch('admin_bookings/filter_customers', expires_in: 2.minutes) do
      Customer.select(:id, :first_name, :middle_name, :last_name, :email, :mobile)
              .order(:first_name, :last_name).to_a
    end

    Rails.cache.write('admin_bookings/status_counts/all', Booking.group(:status).count, expires_in: 3.minutes)
  end
end
