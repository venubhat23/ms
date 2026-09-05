class AddDeliveredAtToBookings < ActiveRecord::Migration[8.0]
  def change
    add_column :bookings, :delivered_at, :datetime
  end
end
