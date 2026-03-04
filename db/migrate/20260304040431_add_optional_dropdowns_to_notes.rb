class AddOptionalDropdownsToNotes < ActiveRecord::Migration[8.0]
  def change
    add_column :notes, :paid_from, :string
    add_column :notes, :paid_to_category, :string
  end
end
