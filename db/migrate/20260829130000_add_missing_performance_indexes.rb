class AddMissingPerformanceIndexes < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    # Real foreign keys with no index at all — Rails doesn't auto-index
    # belongs_to columns, only add_reference/add_index does.
    add_index :booking_discounts, :coupon_id, algorithm: :concurrently, if_not_exists: true
    add_index :franchise_returns, :reviewed_by_id, algorithm: :concurrently, if_not_exists: true
    add_index :franchise_stock_requests, :reviewed_by_id, algorithm: :concurrently, if_not_exists: true

    # Backs the model's own uniqueness validations (ProductRating validates
    # customer_id/user_id uniqueness scoped to product_id), which today rely
    # on the validation alone with no DB constraint enforcing it.
    add_index :product_ratings, [:customer_id, :product_id], unique: true,
      where: "customer_id IS NOT NULL", algorithm: :concurrently, if_not_exists: true,
      name: "index_product_ratings_on_customer_id_and_product_id"
    add_index :product_ratings, [:user_id, :product_id], unique: true,
      where: "user_id IS NOT NULL", algorithm: :concurrently, if_not_exists: true,
      name: "index_product_ratings_on_user_id_and_product_id"
  end
end
