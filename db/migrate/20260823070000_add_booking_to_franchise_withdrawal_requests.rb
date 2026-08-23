class AddBookingToFranchiseWithdrawalRequests < ActiveRecord::Migration[8.0]
  def change
    add_reference :franchise_withdrawal_requests, :booking, null: true, foreign_key: true
  end
end
