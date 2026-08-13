class AddMorePerformanceIndexesRound2 < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    # customers.email: looked up on nearly every mobile API request that
    # touches the current customer (Customer.find_by(email: ...)), and in the
    # uniqueness validation now guarded in app/models/customer.rb.
    add_index :customers, :email, algorithm: :concurrently, if_not_exists: true

    # leads: duplicate-detection lookups (Lead.find_by(contact_number:)/
    # find_by(email:)) on every mobile "add lead" submission, plus a filter
    # column with no index.
    add_index :leads, :contact_number, algorithm: :concurrently, if_not_exists: true
    add_index :leads, :email, algorithm: :concurrently, if_not_exists: true
    add_index :leads, :product_subcategory, algorithm: :concurrently, if_not_exists: true

    # vendors: filtered by status (already indexed) and sorted/searched by
    # name (order(:name), name ILIKE) with no supporting index.
    add_index :vendors, :name, algorithm: :concurrently, if_not_exists: true

    # vendor_purchases: only vendor_id was indexed. status is filtered
    # directly and via pending/completed/cancelled scopes; created_at is the
    # default sort (recent scope) on every index load.
    add_index :vendor_purchases, :status, algorithm: :concurrently, if_not_exists: true
    add_index :vendor_purchases, :created_at, algorithm: :concurrently, if_not_exists: true

    # subscription_templates: filtered directly by is_active (`active` scope).
    add_index :subscription_templates, :is_active, algorithm: :concurrently, if_not_exists: true

    # affiliate_withdrawal_requests / franchise_withdrawal_requests: both
    # order by created_at (recent scope) as the default index sort, with no
    # supporting index.
    add_index :affiliate_withdrawal_requests, :created_at, algorithm: :concurrently, if_not_exists: true
    add_index :franchise_withdrawal_requests, :created_at, algorithm: :concurrently, if_not_exists: true

    # pending_amounts: default sort is created_at desc, and index is also
    # filtered by a pending_date range — neither column was indexed.
    add_index :pending_amounts, :created_at, algorithm: :concurrently, if_not_exists: true
    add_index :pending_amounts, :pending_date, algorithm: :concurrently, if_not_exists: true
  end
end
