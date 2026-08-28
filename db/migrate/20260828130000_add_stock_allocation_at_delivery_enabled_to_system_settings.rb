class AddStockAllocationAtDeliveryEnabledToSystemSettings < ActiveRecord::Migration[8.0]
  def change
    add_column :system_settings, :stock_allocation_at_delivery_enabled, :boolean, default: false
  end
end
