# Tracks whether a customer's current password is still Customer::DEFAULT_PASSWORD
# (ms@123), so the admin customers list can say "default" vs "custom" without
# storing or decrypting real passwords. Kept in sync by Customer#sync_password_is_default;
# backfill existing rows with `bin/rails customers:apply_default_passwords`.
class AddPasswordIsDefaultToCustomers < ActiveRecord::Migration[8.0]
  def change
    return unless table_exists?(:customers)

    add_column :customers, :password_is_default, :boolean, default: false, null: false, if_not_exists: true
  end
end
