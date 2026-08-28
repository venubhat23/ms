class AddAllowPreBookingEnabledToSystemSettings < ActiveRecord::Migration[8.0]
  def change
    add_column :system_settings, :allow_pre_booking_enabled, :boolean, default: false
  end
end
