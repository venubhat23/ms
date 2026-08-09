class AddAffiliateCommissionCreditedAtToBookings < ActiveRecord::Migration[8.0]
  def change
    add_column :bookings, :affiliate_commission_credited_at, :datetime
  end
end
