class CreateFranchiseWithdrawalRequestBookings < ActiveRecord::Migration[8.0]
  def change
    create_table :franchise_withdrawal_request_bookings do |t|
      t.references :franchise_withdrawal_request, null: false, foreign_key: true
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end

    # A booking can only be tagged to one withdrawal request, ever.
    add_index :franchise_withdrawal_request_bookings, :booking_id, unique: true, name: "index_fwrb_on_booking_id_unique"
  end
end
