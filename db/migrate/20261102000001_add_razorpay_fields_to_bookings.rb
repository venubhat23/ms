# Razorpay replaces Cashfree. The cashfree_* columns stay for past orders.
class AddRazorpayFieldsToBookings < ActiveRecord::Migration[8.0]
  def change
    add_column :bookings, :razorpay_order_id, :string
    add_column :bookings, :razorpay_payment_id, :string
    add_index :bookings, :razorpay_order_id
    add_index :bookings, :razorpay_payment_id
  end
end
