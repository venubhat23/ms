class AddMissingIndexesToCoreTables < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    # orders: virtually unindexed (only booking_id) despite being one of the
    # largest, most-queried tables in the app — every "my orders" page,
    # admin order list/filter, and status lookup was a full table scan.
    # bookings (a near-identical table) already has all of these.
    add_index :orders, :customer_id, algorithm: :concurrently, if_not_exists: true
    add_index :orders, :user_id, algorithm: :concurrently, if_not_exists: true
    add_index :orders, :status, algorithm: :concurrently, if_not_exists: true
    add_index :orders, :order_stage, algorithm: :concurrently, if_not_exists: true
    add_index :orders, :payment_status, algorithm: :concurrently, if_not_exists: true
    add_index :orders, :created_at, algorithm: :concurrently, if_not_exists: true

    # order_items: order.order_items (has_many) had no index on the FK at
    # all — every order detail page load was a full table scan of
    # order_items to find its rows.
    add_index :order_items, :order_id, algorithm: :concurrently, if_not_exists: true
    add_index :order_items, :product_id, algorithm: :concurrently, if_not_exists: true

    add_index :booking_items, :product_id, algorithm: :concurrently, if_not_exists: true
    add_index :invoices, :payout_id, algorithm: :concurrently, if_not_exists: true
    add_index :stock_transfers, :product_variant_id, algorithm: :concurrently, if_not_exists: true

    add_index :sub_agents, :role_id, algorithm: :concurrently, if_not_exists: true
    add_index :sub_agents, :distributor_id, algorithm: :concurrently, if_not_exists: true

    add_index :users, :role_id, algorithm: :concurrently, if_not_exists: true
    add_index :users, :reporting_manager_id, algorithm: :concurrently, if_not_exists: true

    add_index :affiliate_withdrawal_requests, :approved_by_user_id, algorithm: :concurrently, if_not_exists: true
    add_index :franchise_withdrawal_requests, :approved_by_user_id, algorithm: :concurrently, if_not_exists: true
  end
end
