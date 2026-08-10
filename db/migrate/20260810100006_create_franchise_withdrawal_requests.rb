class CreateFranchiseWithdrawalRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :franchise_withdrawal_requests do |t|
      t.bigint   :franchise_id, null: false
      t.decimal  :amount, precision: 10, scale: 2, null: false
      t.string   :status, default: "pending", null: false
      t.datetime :requested_at
      t.datetime :approved_at
      t.bigint   :approved_by_user_id
      t.datetime :paid_at
      t.string   :payment_reference
      t.text     :notes

      t.timestamps
    end

    add_index :franchise_withdrawal_requests, :franchise_id
    add_index :franchise_withdrawal_requests, :status
  end
end
