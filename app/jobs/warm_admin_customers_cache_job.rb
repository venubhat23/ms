class WarmAdminCustomersCacheJob < ApplicationJob
  queue_as :default

  # Keeps Admin::CustomersController#index's filter-dropdown caches (customer
  # picker, delivery person picker) refreshed ahead of their expiry — same
  # rationale as WarmAdminBookingsCacheJob.
  def perform
    Rails.cache.fetch('admin_customers/filter_customers', expires_in: 2.minutes) do
      Customer.select(:id, :first_name, :middle_name, :last_name, :email, :mobile)
              .order(:first_name, :last_name).to_a
    end

    Rails.cache.fetch('admin_customers/filter_delivery_people', expires_in: 5.minutes) do
      defined?(DeliveryPerson) ? DeliveryPerson.active.order(:first_name, :last_name).to_a : []
    end
  end
end
