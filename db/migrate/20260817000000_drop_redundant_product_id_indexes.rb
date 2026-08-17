class DropRedundantProductIdIndexes < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    # Each of these single-column product_id indexes is a redundant subset of
    # an existing composite index starting with product_id (Postgres can use
    # the leftmost prefix of a composite index for a plain product_id lookup),
    # so they add write cost on these high-churn tables with no query benefit.

    # Exact duplicate of idx_stock_movements_product_id, and both are already
    # covered by idx_stock_movements_product_created (product_id, created_at).
    if table_exists?(:stock_movements)
      remove_index :stock_movements, name: "index_stock_movements_on_product_id", algorithm: :concurrently, if_exists: true
      remove_index :stock_movements, name: "idx_stock_movements_product_id", algorithm: :concurrently, if_exists: true
    end

    # Covered by index_product_ratings_on_product_id_and_rating.
    if table_exists?(:product_ratings)
      remove_index :product_ratings, name: "index_product_ratings_on_product_id", algorithm: :concurrently, if_exists: true
    end

    # Covered by index_product_reviews_on_product_id_and_created_at.
    if table_exists?(:product_reviews)
      remove_index :product_reviews, name: "index_product_reviews_on_product_id", algorithm: :concurrently, if_exists: true
    end

    # Covered by index_stock_batches_on_product_id_and_store_id.
    if table_exists?(:stock_batches)
      remove_index :stock_batches, name: "index_stock_batches_on_product_id", algorithm: :concurrently, if_exists: true
    end
  end
end
