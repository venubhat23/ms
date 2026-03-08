class AddSelectedShopAddressToBookings < ActiveRecord::Migration[8.0]
  def change
    add_column :bookings, :delivery_store, :text
  end
end
