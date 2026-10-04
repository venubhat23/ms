class AddHotPathCompositeIndexes < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    if table_exists?(:stock_batches)
      # Product#total_batch_stock / Product.preload_batch_stock /
      # StockBatch.available_for_product all filter on the `active` scope
      # (status = 'active' AND quantity_remaining > 0) by product (+ store)
      # and SUM quantity_remaining — the most frequent query in the app.
      # Partial + INCLUDE lets Postgres answer it with an index-only scan.
      add_index :stock_batches, [:product_id, :store_id], include: [:quantity_remaining],
        where: "status = 'active' AND quantity_remaining > 0",
        name: "index_stock_batches_active_on_product_and_store",
        algorithm: :concurrently, if_not_exists: true
    end

    # Latest-transaction lookups per wallet (admin wallets index DISTINCT ON,
    # wallet.wallet_transactions.recent) — filter + sort from one index.
    if table_exists?(:wallet_transactions)
      add_index :wallet_transactions, [:customer_wallet_id, :created_at],
        algorithm: :concurrently, if_not_exists: true
    end

    # customer.bookings.recent (customer portal orders, mobile bookings API,
    # admin customer page) — filter by customer and sort by created_at.
    if table_exists?(:bookings)
      add_index :bookings, [:customer_id, :created_at],
        algorithm: :concurrently, if_not_exists: true
    end

    # Stock transfer group pages: WHERE transfer_group_id = ? ORDER BY created_at DESC.
    if table_exists?(:stock_transfers)
      add_index :stock_transfers, [:transfer_group_id, :created_at],
        algorithm: :concurrently, if_not_exists: true
    end

    # Storefront/customer product listings: WHERE status = 'active' ORDER BY name.
    if table_exists?(:products)
      add_index :products, [:status, :name],
        algorithm: :concurrently, if_not_exists: true
    end
  end
end
