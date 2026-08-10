class CreateFranchiseStockMovements < ActiveRecord::Migration[8.0]
  def change
    create_table :franchise_stock_movements do |t|
      t.bigint  :franchise_id, null: false
      t.bigint  :product_id, null: false
      t.string  :reference_type, null: false
      t.integer :reference_id
      t.string  :movement_type, null: false
      t.decimal :quantity, precision: 10, scale: 2, null: false
      t.decimal :stock_before, precision: 10, scale: 2, null: false
      t.decimal :stock_after, precision: 10, scale: 2, null: false
      t.text    :notes

      t.timestamps
    end

    add_index :franchise_stock_movements, :franchise_id
    add_index :franchise_stock_movements, :product_id
    add_index :franchise_stock_movements, [:franchise_id, :product_id], name: "idx_franchise_stock_movements_franchise_product"
    add_index :franchise_stock_movements, [:reference_type, :reference_id], name: "idx_franchise_stock_movements_ref_type_id"
  end
end
