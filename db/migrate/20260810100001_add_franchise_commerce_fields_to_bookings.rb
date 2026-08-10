class AddFranchiseCommerceFieldsToBookings < ActiveRecord::Migration[8.0]
  def change
    add_column :bookings, :franchise_discount_type, :string
    add_column :bookings, :franchise_discount_value, :decimal, precision: 10, scale: 2
    add_column :bookings, :franchise_discount_amount, :decimal, precision: 10, scale: 2, default: "0.0"
    add_column :bookings, :wholesale_stock_credited_at, :datetime

    add_column :bookings, :delivery_mode, :string, default: "delivery_person"
    add_reference :bookings, :delivery_franchise, null: true, foreign_key: { to_table: :franchises }, index: true

    add_column :bookings, :franchise_commission_amount, :decimal, precision: 10, scale: 2, default: "0.0"
    add_column :bookings, :franchise_commission_credited_at, :datetime
  end
end
