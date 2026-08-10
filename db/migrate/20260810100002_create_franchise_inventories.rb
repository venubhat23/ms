class CreateFranchiseInventories < ActiveRecord::Migration[8.0]
  def change
    create_table :franchise_inventories do |t|
      t.bigint  :franchise_id, null: false
      t.bigint  :product_id, null: false
      t.decimal :quantity, precision: 10, scale: 2, default: "0.0", null: false

      t.timestamps
    end

    add_index :franchise_inventories, [:franchise_id, :product_id], unique: true, name: "index_franchise_inventories_on_franchise_and_product"
    add_index :franchise_inventories, :product_id
  end
end
