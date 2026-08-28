class AddFranchiseDeliveryAssignmentEnabledToSystemSettings < ActiveRecord::Migration[8.0]
  def change
    add_column :system_settings, :franchise_delivery_assignment_enabled, :boolean, default: false
  end
end
