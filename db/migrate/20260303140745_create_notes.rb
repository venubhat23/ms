class CreateNotes < ActiveRecord::Migration[8.0]
  def change
    create_table :notes do |t|
      t.string :title, null: false
      t.string :paid_to, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.string :payment_method, null: false
      t.string :reference_number
      t.text :description
      t.string :status, default: 'pending'
      t.date :note_date, null: false, default: -> { 'CURRENT_DATE' }
      t.references :created_by_user, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :notes, :note_date
    add_index :notes, :status
    add_index :notes, :payment_method
  end
end
