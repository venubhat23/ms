class AddFranchiseCommissionEnabledToSystemSettings < ActiveRecord::Migration[8.0]
  def change
    add_column :system_settings, :franchise_commission_enabled, :boolean, default: false
  end
end
