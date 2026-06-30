class AddAffiliateIdToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :affiliate_id, :bigint
    add_index  :bookings, :affiliate_id
  end
end
