class AddPerformanceIndexesToOtherInsuranceAndPayouts < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    # other_insurances: same access pattern as its life/health/motor siblings
    # (already indexed in 20260813090000) — created_at sort, policy_end_date
    # range scans for renewal/expiry stats, customer_id join.
    if table_exists?(:other_insurances)
      add_index :other_insurances, :created_at, algorithm: :concurrently, if_not_exists: true
      add_index :other_insurances, :policy_end_date, algorithm: :concurrently, if_not_exists: true
      add_index :other_insurances, :customer_id, algorithm: :concurrently, if_not_exists: true
    end

    # commission_payouts / distributor_payouts: status is filtered on every
    # pending/paid lookup (dashboard payout totals, admin payout screens);
    # policy_type+policy_id is the lookup key used by Payout#policy and
    # #preload_policies; created_at backs the `recent`/period-range scopes.
    if table_exists?(:commission_payouts)
      add_index :commission_payouts, :status, algorithm: :concurrently, if_not_exists: true
      add_index :commission_payouts, :created_at, algorithm: :concurrently, if_not_exists: true
      add_index :commission_payouts, [:policy_type, :policy_id], algorithm: :concurrently, if_not_exists: true
    end

    if table_exists?(:distributor_payouts)
      add_index :distributor_payouts, :status, algorithm: :concurrently, if_not_exists: true
      add_index :distributor_payouts, :created_at, algorithm: :concurrently, if_not_exists: true
      add_index :distributor_payouts, [:policy_type, :policy_id], algorithm: :concurrently, if_not_exists: true
    end
  end
end
