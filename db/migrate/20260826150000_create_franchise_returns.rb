class CreateFranchiseReturns < ActiveRecord::Migration[8.0]
  def change
    create_table :franchise_returns do |t|
      t.bigint :franchise_id, null: false
      t.string :status, default: "pending", null: false
      t.decimal :total_amount, precision: 10, scale: 2, default: "0.0"
      t.text :notes
      t.text :rejection_reason
      t.bigint :reviewed_by_id
      t.datetime :reviewed_at
      t.integer :items_count, default: 0, null: false

      t.timestamps
    end
    add_index :franchise_returns, :franchise_id
    add_index :franchise_returns, :status

    create_table :franchise_return_items do |t|
      t.bigint :franchise_return_id, null: false
      t.bigint :product_id, null: false
      t.decimal :quantity, precision: 10, scale: 2, null: false
      t.decimal :unit_price, precision: 10, scale: 2, null: false

      t.timestamps
    end
    add_index :franchise_return_items, :franchise_return_id, name: "idx_franchise_return_items_return"
    add_index :franchise_return_items, :product_id
  end
end
