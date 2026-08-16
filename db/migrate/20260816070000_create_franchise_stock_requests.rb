class CreateFranchiseStockRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :franchise_stock_requests do |t|
      t.bigint   :franchise_id, null: false
      t.string   :status, null: false, default: "pending"
      t.text     :notes
      t.string   :discount_type
      t.decimal  :discount_value, precision: 10, scale: 2
      t.decimal  :discount_amount, precision: 10, scale: 2
      t.bigint   :booking_id
      t.bigint   :reviewed_by_id
      t.datetime :reviewed_at
      t.text     :rejection_reason
      t.integer  :items_count, null: false, default: 0

      t.timestamps
    end

    add_index :franchise_stock_requests, [:franchise_id, :status], name: "idx_franchise_stock_requests_franchise_status"
    add_index :franchise_stock_requests, :status
    add_index :franchise_stock_requests, :booking_id

    create_table :franchise_stock_request_items do |t|
      t.bigint  :franchise_stock_request_id, null: false
      t.bigint  :product_id, null: false
      t.bigint  :product_variant_id
      t.decimal :quantity, precision: 10, scale: 2, null: false

      t.timestamps
    end

    add_index :franchise_stock_request_items, :franchise_stock_request_id, name: "idx_franchise_stock_request_items_request"
    add_index :franchise_stock_request_items, :product_id
    add_index :franchise_stock_request_items, :product_variant_id
  end
end
