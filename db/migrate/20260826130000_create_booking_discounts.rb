class CreateBookingDiscounts < ActiveRecord::Migration[8.0]
  def up
    create_table :booking_discounts do |t|
      t.references :booking, null: false, foreign_key: true
      t.string  :source,          null: false   # 'manual' | 'franchise' | 'coupon'
      t.string  :discount_type,   null: false   # 'fixed' | 'percentage'
      t.decimal :value,           precision: 10, scale: 2, null: false, default: "0.0"
      t.decimal :computed_amount, precision: 10, scale: 2, null: false, default: "0.0"
      t.bigint  :coupon_id
      t.timestamps
    end
    add_index :booking_discounts, [:booking_id, :source], unique: true,
              name: "index_booking_discounts_on_booking_and_source"

    # Backfill from the existing combined discount_amount so historical
    # bookings' manual/franchise/coupon breakdown is recoverable — discount_type
    # and value for backfilled rows are a best-effort reconstruction (franchise
    # from the booking's own stored config, coupon from the coupon's *current*
    # config); computed_amount is always exact since it's copied straight from
    # the existing columns.
    execute <<~SQL
      INSERT INTO booking_discounts (booking_id, source, discount_type, value, computed_amount, created_at, updated_at)
      SELECT id, 'franchise', COALESCE(franchise_discount_type, 'fixed'),
             COALESCE(franchise_discount_value, franchise_discount_amount), franchise_discount_amount, NOW(), NOW()
      FROM bookings WHERE COALESCE(franchise_discount_amount, 0) > 0;

      INSERT INTO booking_discounts (booking_id, source, discount_type, value, computed_amount, coupon_id, created_at, updated_at)
      SELECT b.id, 'coupon', COALESCE(c.discount_type, 'fixed'), COALESCE(c.discount_value, b.coupon_discount_amount),
             b.coupon_discount_amount, b.coupon_id, NOW(), NOW()
      FROM bookings b LEFT JOIN coupons c ON c.id = b.coupon_id
      WHERE COALESCE(b.coupon_discount_amount, 0) > 0;

      INSERT INTO booking_discounts (booking_id, source, discount_type, value, computed_amount, created_at, updated_at)
      SELECT id, 'manual', 'fixed',
             GREATEST(COALESCE(discount_amount,0) - COALESCE(franchise_discount_amount,0) - COALESCE(coupon_discount_amount,0), 0),
             GREATEST(COALESCE(discount_amount,0) - COALESCE(franchise_discount_amount,0) - COALESCE(coupon_discount_amount,0), 0),
             NOW(), NOW()
      FROM bookings
      WHERE COALESCE(discount_amount,0) - COALESCE(franchise_discount_amount,0) - COALESCE(coupon_discount_amount,0) > 0;
    SQL
  end

  def down
    drop_table :booking_discounts
  end
end
