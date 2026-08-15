class AddMissingStatusIndexes < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    # roles#index groups by :status (admin/roles_controller.rb).
    if table_exists?(:roles)
      add_index :roles, :status, algorithm: :concurrently, if_not_exists: true
    end

    # invoices is filtered/summarized by :status on the invoices index page.
    if table_exists?(:invoices)
      add_index :invoices, :status, algorithm: :concurrently, if_not_exists: true
    end

    # coupons#index groups by :status (active/inactive breakdown).
    if table_exists?(:coupons)
      add_index :coupons, :status, algorithm: :concurrently, if_not_exists: true
    end

    # booking_invoices is filtered by :status (admin/booking_invoices_controller.rb);
    # payment_status is already indexed but status was missed.
    if table_exists?(:booking_invoices)
      add_index :booking_invoices, :status, algorithm: :concurrently, if_not_exists: true
    end

    # pending_amounts#index groups/filters by :status on every page load
    # (admin/pending_amounts_controller.rb).
    if table_exists?(:pending_amounts)
      add_index :pending_amounts, :status, algorithm: :concurrently, if_not_exists: true
    end
  end
end
