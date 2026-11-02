# The admin all_data API filters these lists by date (last 30 days by default).
class AddDateIndexesForAdminLists < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  INDEXES = {
    expenses: :expense_date,
    vendor_purchases: :purchase_date,
    vendor_payments: :payment_date,
    staff_payments: :payment_date
  }.freeze

  def up
    INDEXES.each do |table, column|
      next unless table_exists?(table)

      add_index table, column, algorithm: :concurrently, if_not_exists: true
    end
  end

  def down
    INDEXES.each do |table, column|
      next unless table_exists?(table)

      remove_index table, column, algorithm: :concurrently, if_exists: true
    end
  end
end
