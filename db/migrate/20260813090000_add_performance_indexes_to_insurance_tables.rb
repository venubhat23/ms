class AddPerformanceIndexesToInsuranceTables < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    # life_insurances / health_insurances / motor_insurances / policies aren't
    # present in every environment (this local DB's checked-in db/schema.rb
    # doesn't define them at all), so guard on table_exists? — no-ops where a
    # table doesn't exist, adds the missing indexes where it does (e.g. prod).
    if table_exists?(:life_insurances)
      # order(created_at: :desc) on every /admin/insurance/life load.
      add_index :life_insurances, :created_at, algorithm: :concurrently, if_not_exists: true
      # active/expired/expiring_soon scopes and the "Expiring Soon" stat.
      add_index :life_insurances, :policy_end_date, algorithm: :concurrently, if_not_exists: true
      # joins(:customer) for the covered-lives stat query.
      add_index :life_insurances, :customer_id, algorithm: :concurrently, if_not_exists: true
      # Dhanvantari vs Non-Dhanvantari tab filtering (calculate_tab_statistics
      # and the index action's own tab WHERE clause) — composite index lets
      # Postgres satisfy both tab conditions without a full table scan.
      add_index :life_insurances, [:is_admin_added, :is_customer_added, :is_agent_added],
                name: 'index_life_insurances_on_added_by_flags',
                algorithm: :concurrently, if_not_exists: true
    end

    if table_exists?(:health_insurances)
      add_index :health_insurances, :created_at, algorithm: :concurrently, if_not_exists: true
      add_index :health_insurances, :policy_end_date, algorithm: :concurrently, if_not_exists: true
      add_index :health_insurances, :customer_id, algorithm: :concurrently, if_not_exists: true
    end

    if table_exists?(:motor_insurances)
      add_index :motor_insurances, :created_at, algorithm: :concurrently, if_not_exists: true
      add_index :motor_insurances, :policy_end_date, algorithm: :concurrently, if_not_exists: true
      add_index :motor_insurances, :customer_id, algorithm: :concurrently, if_not_exists: true
      add_index :motor_insurances, :status, algorithm: :concurrently, if_not_exists: true
    end

    if table_exists?(:policies)
      add_index :policies, :created_at, algorithm: :concurrently, if_not_exists: true
      add_index :policies, :insurance_type, algorithm: :concurrently, if_not_exists: true
      add_index :policies, :customer_id, algorithm: :concurrently, if_not_exists: true
      add_index :policies, :status, algorithm: :concurrently, if_not_exists: true
    end
  end
end
