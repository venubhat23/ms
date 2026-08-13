class AddPerformanceIndexesToLeadsSubAgentsDistributors < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    # leads: previously had zero indexes — every filter (current_stage,
    # lead_source, product_category, affiliate_id) and the default
    # `order(created_at: :desc)` on /admin/leads forced a full table scan.
    add_index :leads, :current_stage,   algorithm: :concurrently, if_not_exists: true
    add_index :leads, :lead_source,     algorithm: :concurrently, if_not_exists: true
    add_index :leads, :product_category, algorithm: :concurrently, if_not_exists: true
    add_index :leads, :affiliate_id,    algorithm: :concurrently, if_not_exists: true
    add_index :leads, :created_at,      algorithm: :concurrently, if_not_exists: true

    # sub_agents: had unique indexes on aadhar_no/email/mobile/pan_no but
    # nothing on status (filtered on every index load) or created_at (the
    # default sort column).
    add_index :sub_agents, :status,     algorithm: :concurrently, if_not_exists: true
    add_index :sub_agents, :created_at, algorithm: :concurrently, if_not_exists: true

    # distributors / distributor_assignments: not present in every environment
    # (e.g. this DB), so guard on table_exists? — no-ops where the tables
    # don't exist, adds the same missing indexes where they do.
    if table_exists?(:distributors)
      add_index :distributors, :status,     algorithm: :concurrently, if_not_exists: true
      add_index :distributors, :created_at, algorithm: :concurrently, if_not_exists: true
    end

    if table_exists?(:distributor_assignments)
      add_index :distributor_assignments, :distributor_id, algorithm: :concurrently, if_not_exists: true
      add_index :distributor_assignments, :sub_agent_id,    algorithm: :concurrently, if_not_exists: true
    end
  end
end
