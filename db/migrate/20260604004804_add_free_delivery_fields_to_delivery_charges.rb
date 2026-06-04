class AddFreeDeliveryFieldsToDeliveryCharges < ActiveRecord::Migration[8.0]
  def change
    add_column :delivery_charges, :free_delivery_allowed, :boolean, default: false, null: false
    add_column :delivery_charges, :min_order_for_free_delivery, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
