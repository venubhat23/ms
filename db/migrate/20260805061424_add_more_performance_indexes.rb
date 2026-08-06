class AddMorePerformanceIndexes < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    # Admin::StockTransfersController#index orders the whole (unpaginated)
    # base scope by created_at with no index.
    add_index :stock_transfers, :created_at, algorithm: :concurrently

    # Admin::InvoiceCheckController filters milk_subscriptions by is_active
    # (get_customers_for_check, calculate_customer_subscription_amount) and
    # Admin::SubscriptionsController#index orders by created_at — neither
    # column was indexed.
    add_index :milk_subscriptions, :is_active, algorithm: :concurrently
    add_index :milk_subscriptions, :created_at, algorithm: :concurrently

    # Admin::CustomerFormatsController#index filters by status/pattern and
    # orders by created_at on every load — none were indexed.
    add_index :customer_formats, :status, algorithm: :concurrently
    add_index :customer_formats, :pattern, algorithm: :concurrently
    add_index :customer_formats, :created_at, algorithm: :concurrently

    # Admin::InvoiceCheckController/Admin::ReportsController#enhanced_sales
    # both filter booking_invoices by invoice_date with no index.
    add_index :booking_invoices, :invoice_date, algorithm: :concurrently

    # Admin::ReportsController#profit_loss filters bookings by booking_date
    # (distinct from the already-indexed created_at) with no index.
    add_index :bookings, :booking_date, algorithm: :concurrently

    # Admin::StoreFinancialsController#commission/#gst_report both filter
    # bookings by store_id + created_at together — the existing single-column
    # indexes on each can't satisfy that combination as efficiently as one
    # composite index.
    add_index :bookings, [:store_id, :created_at], algorithm: :concurrently

    # Admin::ClientRequestsController filters/groups by status constantly
    # (index, 4 model scopes) and includes(:resolved_by) on every action.
    add_index :client_requests, :status, algorithm: :concurrently
    add_index :client_requests, :resolved_by_id, algorithm: :concurrently

    # Admin::ReferralsController#index/#affiliate_referrals filter/group by
    # status on every load.
    add_index :referrals, :status, algorithm: :concurrently

    # Admin::FranchisesController#index filters/groups by status on every load.
    add_index :franchises, :status, algorithm: :concurrently

    # Admin::AffiliatesController#index filters/groups by status on every load.
    add_index :affiliates, :status, algorithm: :concurrently
  end
end
