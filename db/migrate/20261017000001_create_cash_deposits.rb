# Cash taken out of a shop's till and deposited to the bank (Admin > POS >
# Current Cash Stock). store_id NULL = the main shop, matching bookings.store_id.
class CreateCashDeposits < ActiveRecord::Migration[8.0]
  def change
    create_table :cash_deposits do |t|
      t.references :store, null: true, foreign_key: true
      t.decimal :amount, precision: 12, scale: 2, null: false
      t.date :deposited_on, null: false
      t.string :bank_name
      t.string :reference_number
      t.text :notes
      t.references :created_by, null: true, foreign_key: { to_table: :users }
      t.timestamps
    end
    add_index :cash_deposits, :deposited_on
  end
end
