class AddCouponToBookings < ActiveRecord::Migration[8.0]
  def change
    add_column :bookings, :coupon_id, :bigint
    add_column :bookings, :coupon_code, :string
    add_column :bookings, :coupon_discount_amount, :decimal, precision: 10, scale: 2, default: "0.0"
    add_index :bookings, :coupon_id
  end
end
