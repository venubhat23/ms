class CustomerAddress < ApplicationRecord
  belongs_to :customer

  def full_address
    [address, landmark.presence, city, state, pincode].compact.join(', ')
  end

  def phone
    mobile
  end
end
