class AddPerformanceIndexes < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    # delivery_people had zero indexes; index/status/city/vehicle_type/created_at
    # are all filtered/ordered on in Admin::DeliveryPeopleController#index,
    # and email/mobile/vehicle_number/license_number are validated unique at the
    # app level but scanned without an index on every create/update.
    add_index :delivery_people, :status, algorithm: :concurrently
    add_index :delivery_people, :city, algorithm: :concurrently
    add_index :delivery_people, :vehicle_type, algorithm: :concurrently
    add_index :delivery_people, :created_at, algorithm: :concurrently
    add_index :delivery_people, :email, unique: true, algorithm: :concurrently
    add_index :delivery_people, :mobile, unique: true, algorithm: :concurrently
    add_index :delivery_people, :vehicle_number, unique: true, algorithm: :concurrently
    add_index :delivery_people, :license_number, unique: true, algorithm: :concurrently

    # customers#index filters by status and orders by created_at with no index
    add_index :customers, :status, algorithm: :concurrently
    add_index :customers, :created_at, algorithm: :concurrently

    # Product.recent (default admin/products#index sort) orders by created_at
    add_index :products, :created_at, algorithm: :concurrently

    # Admin::BookingsController#index filters on is_b2b
    add_index :bookings, :is_b2b, algorithm: :concurrently

    # Banner.current / expired_banners stat range-scan these date columns
    add_index :banners, [:display_start_date, :display_end_date], algorithm: :concurrently
  end
end
