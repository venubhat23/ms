class AddDeliveryOnlyAtShopToSystemSettings < ActiveRecord::Migration[8.0]
  def change
    add_column :system_settings, :delivery_only_at_shop, :boolean
    add_column :system_settings, :shop_addresses, :text
  end
end
