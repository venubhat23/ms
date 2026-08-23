class FranchiseWithdrawalRequestBooking < ApplicationRecord
  belongs_to :franchise_withdrawal_request
  belongs_to :booking

  validates :booking_id, uniqueness: true
end
