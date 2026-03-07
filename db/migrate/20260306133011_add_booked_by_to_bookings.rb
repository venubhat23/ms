class AddBookedByToBookings < ActiveRecord::Migration[8.0]
  def change
    add_column :bookings, :booked_by, :string, default: 'admin'
    add_index :bookings, :booked_by
  end
end
