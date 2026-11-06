class DeliveryCharge < ApplicationRecord
  validates :pincode, presence: true, uniqueness: true
  validates :charge_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }
  scope :bangalore_pincodes, -> { where('pincode LIKE ?', '56%') }

  def self.for_pincode(pincode)
    find_by(pincode: pincode, is_active: true)
  end

  def self.charge_for_pincode(pincode)
    charge = for_pincode(pincode)
    charge&.charge_amount || 0.0
  end

  # Returns the effective charge for a given order amount,
  # applying free delivery if allowed and threshold is met.
  def effective_charge_for(order_amount)
    return charge_amount.to_f unless free_delivery_allowed?
    order_amount.to_f >= min_order_for_free_delivery.to_f ? 0.0 : charge_amount.to_f
  end

  # Free-delivery fields for API responses. With an order_amount, also
  # returns the charge actually applied and how much more is needed for
  # free delivery. Pass nil for record-less (not serviceable) pincodes via
  # DeliveryCharge.free_delivery_info_for.
  def free_delivery_info(order_amount = nil)
    min_for_free = min_order_for_free_delivery.to_f
    info = {
      free_delivery_allowed: free_delivery_allowed?,
      min_order_for_free_delivery: min_for_free,
      free_delivery_message: free_delivery_allowed? ? "Free delivery on orders above ₹#{min_for_free % 1 == 0 ? min_for_free.to_i : min_for_free.round(2)}" : nil
    }
    return info if order_amount.nil?

    effective = effective_charge_for(order_amount)
    info.merge(
      order_amount: order_amount.to_f.round(2),
      effective_delivery_charge: effective,
      is_free_delivery: effective.zero?,
      amount_left_for_free_delivery: free_delivery_allowed? && effective > 0 ? (min_for_free - order_amount.to_f).round(2) : 0.0
    )
  end

  def self.free_delivery_info_for(record, order_amount = nil)
    return record.free_delivery_info(order_amount) if record

    info = { free_delivery_allowed: false, min_order_for_free_delivery: 0.0, free_delivery_message: nil }
    order_amount.nil? ? info : info.merge(order_amount: order_amount.to_f.round(2), effective_delivery_charge: 0.0,
                                          is_free_delivery: false, amount_left_for_free_delivery: 0.0)
  end

  def formatted_charge
    "₹#{charge_amount}"
  end

  def free_delivery_threshold
    "₹#{min_order_for_free_delivery}"
  end

  def status_text
    is_active? ? 'Active' : 'Inactive'
  end
end