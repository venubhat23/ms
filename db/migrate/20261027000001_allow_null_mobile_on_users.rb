# Customers may register with only an email (web or mobile app), so their
# login User row has no mobile. The unique index still allows many NULLs.
class AllowNullMobileOnUsers < ActiveRecord::Migration[8.0]
  def change
    change_column_null :users, :mobile, true
  end
end
