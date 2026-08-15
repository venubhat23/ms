class AddMissingIndexesToPayoutTables < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    # commission_payouts backs admin/payouts, admin/commission_tracking, and
    # admin/{distributor,affiliate}_payouts — every index/summary action on
    # those pages filters/groups by these columns. status/created_at/
    # [policy_type,policy_id] are already added by migration 20260814030000
    # (if_not_exists: true makes the overlap harmless either way, but this
    # only adds what that one doesn't).
    if table_exists?(:commission_payouts)
      add_index :commission_payouts, :payout_to, algorithm: :concurrently, if_not_exists: true
      add_index :commission_payouts, :payout_date, algorithm: :concurrently, if_not_exists: true
      add_index :commission_payouts, :lead_id, algorithm: :concurrently, if_not_exists: true
    end

    # distributor_payouts: filtered by distributor_id (show page). status/
    # [policy_type,policy_id] already added by migration 20260814030000.
    if table_exists?(:distributor_payouts)
      add_index :distributor_payouts, :distributor_id, algorithm: :concurrently, if_not_exists: true
    end

    # payouts: looked up by policy_type+policy_id constantly (every
    # find_policy_by_lead_id / commission calculation call site).
    if table_exists?(:payouts)
      add_index :payouts, [:policy_type, :policy_id], algorithm: :concurrently, if_not_exists: true
      add_index :payouts, :payout_date, algorithm: :concurrently, if_not_exists: true
    end
  end
end
