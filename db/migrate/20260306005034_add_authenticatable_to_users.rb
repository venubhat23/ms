class AddAuthenticatableToUsers < ActiveRecord::Migration[8.0]
  def change
    add_reference :users, :authenticatable, polymorphic: true, null: true
  end
end
