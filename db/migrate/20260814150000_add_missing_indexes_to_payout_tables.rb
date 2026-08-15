class AddMissingIndexesToPayoutTables < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    # commission_payouts backs admin/payouts, admin/commission_tracking, and
    # admin/{distributor,affiliate}_payouts — every index/summary action on
    # those pages filters/groups by these columns.
    add_index :commission_payouts, :payout_to, algorithm: :concurrently, if_not_exists: true
    add_index :commission_payouts, :status, algorithm: :concurrently, if_not_exists: true
    add_index :commission_payouts, [:policy_type, :policy_id], algorithm: :concurrently, if_not_exists: true
    add_index :commission_payouts, :payout_date, algorithm: :concurrently, if_not_exists: true
    add_index :commission_payouts, :created_at, algorithm: :concurrently, if_not_exists: true
    add_index :commission_payouts, :lead_id, algorithm: :concurrently, if_not_exists: true

    # distributor_payouts: filtered by distributor_id (show page) and looked
    # up by policy_type+policy_id+distributor_id (mark_as_paid dedup check).
    add_index :distributor_payouts, :distributor_id, algorithm: :concurrently, if_not_exists: true
    add_index :distributor_payouts, [:policy_type, :policy_id], algorithm: :concurrently, if_not_exists: true
    add_index :distributor_payouts, :status, algorithm: :concurrently, if_not_exists: true

    # payouts: looked up by policy_type+policy_id constantly (every
    # find_policy_by_lead_id / commission calculation call site).
    add_index :payouts, [:policy_type, :policy_id], algorithm: :concurrently, if_not_exists: true
    add_index :payouts, :payout_date, algorithm: :concurrently, if_not_exists: true
  end
end
