class AddStockAllocatedAtToBookings < ActiveRecord::Migration[8.0]
  def change
    # Set once actual stock (central or franchise) has been deducted for a
    # booking under the "stock allocation at delivery" flow — guards against
    # double-deducting if delivery is confirmed twice, and lets the admin
    # "deliver from admin" button know a booking is already spoken for.
    add_column :bookings, :stock_allocated_at, :datetime
  end
end
