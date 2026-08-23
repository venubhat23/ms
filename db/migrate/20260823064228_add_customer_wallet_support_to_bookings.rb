class AddCustomerWalletSupportToBookings < ActiveRecord::Migration[8.0]
  def change
    add_column :system_settings, :customer_wallet_enabled, :boolean, default: false

    add_column :bookings, :wallet_amount_used, :decimal, precision: 10, scale: 2, default: "0.0"
    add_reference :bookings, :wallet_transaction, null: true, foreign_key: true, index: true

    add_reference :wallet_transactions, :booking, null: true, foreign_key: true, index: true
  end
end
