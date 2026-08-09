class CreateAffiliateWallets < ActiveRecord::Migration[8.0]
  def change
    create_table :affiliate_wallets do |t|
      t.bigint  :affiliate_id, null: false
      t.decimal :balance, precision: 10, scale: 2, default: "0.0", null: false
      t.boolean :status, default: true
      t.text    :notes

      t.timestamps
    end

    add_index :affiliate_wallets, :affiliate_id, unique: true
  end
end
