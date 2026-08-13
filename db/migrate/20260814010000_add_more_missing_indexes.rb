class AddMoreMissingIndexes < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    # customers.mobile: validated unique in the model but the DB already has
    # a duplicate pair (ids 533/534, same name+email+mobile, created 0.2s
    # apart — a double-submit, not two people sharing a number), so a UNIQUE
    # index would fail to build. Plain index still gives full lookup speed;
    # the duplicate is a data-cleanup decision, not something to paper over
    # here.
    add_index :customers, :mobile, algorithm: :concurrently, if_not_exists: true

    # bookings/orders: number columns used for lookup, both verified free of
    # duplicates in the current data.
    add_index :bookings, :booking_number, unique: true, algorithm: :concurrently, if_not_exists: true
    add_index :orders, :order_number, unique: true, algorithm: :concurrently, if_not_exists: true

    # referrals: both validated unique in the model, both verified free of
    # duplicates.
    add_index :referrals, :referred_mobile, unique: true, algorithm: :concurrently, if_not_exists: true
    add_index :referrals, :referred_email, unique: true, algorithm: :concurrently, if_not_exists: true
    # date-range filters in reports_controller#referrals-related stats.
    add_index :referrals, :created_at, algorithm: :concurrently, if_not_exists: true

    # client_requests: submitted_at is the default sort on every
    # admin/client_requests index/pending/in_progress/resolved action;
    # priority is filtered on the same page.
    add_index :client_requests, :submitted_at, algorithm: :concurrently, if_not_exists: true
    add_index :client_requests, :priority, algorithm: :concurrently, if_not_exists: true

    # stores.status: scope :active used across bookings/staff_members/invoices
    # controllers.
    add_index :stores, :status, algorithm: :concurrently, if_not_exists: true

    # vendors: filtered by status and ordered by created_at on every
    # admin/vendors index load, previously had zero indexes.
    add_index :vendors, :status, algorithm: :concurrently, if_not_exists: true
    add_index :vendors, :created_at, algorithm: :concurrently, if_not_exists: true

    # booking_invoices.payment_status: pending_payment/overdue_invoices
    # scopes and admin/invoices_controller's status filter.
    add_index :booking_invoices, :payment_status, algorithm: :concurrently, if_not_exists: true

    # stock_batches: store_analytics_controller filters
    # where(store_id: ..., status: 'active') — composite lets Postgres
    # satisfy both conditions without a scan filtered only by store_id.
    add_index :stock_batches, [:store_id, :status], algorithm: :concurrently, if_not_exists: true
  end
end
