class CreateAffiliateWalletTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :affiliate_wallet_transactions do |t|
      t.bigint  :affiliate_wallet_id, null: false
      t.string  :transaction_type, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.decimal :balance_after, precision: 10, scale: 2, null: false
      t.string  :description
      t.string  :reference_number
      t.bigint  :booking_id
      t.json    :metadata

      t.timestamps
    end

    add_index :affiliate_wallet_transactions, :affiliate_wallet_id
    add_index :affiliate_wallet_transactions, :reference_number, unique: true
    add_index :affiliate_wallet_transactions, :booking_id
  end
end
