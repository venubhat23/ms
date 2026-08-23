# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2026_08_23_064228) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "affiliate_wallet_transactions", force: :cascade do |t|
    t.bigint "affiliate_wallet_id", null: false
    t.string "transaction_type", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.decimal "balance_after", precision: 10, scale: 2, null: false
    t.string "description"
    t.string "reference_number"
    t.bigint "booking_id"
    t.json "metadata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["affiliate_wallet_id"], name: "index_affiliate_wallet_transactions_on_affiliate_wallet_id"
    t.index ["booking_id"], name: "index_affiliate_wallet_transactions_on_booking_id"
    t.index ["reference_number"], name: "index_affiliate_wallet_transactions_on_reference_number", unique: true
  end

  create_table "affiliate_wallets", force: :cascade do |t|
    t.bigint "affiliate_id", null: false
    t.decimal "balance", precision: 10, scale: 2, default: "0.0", null: false
    t.boolean "status", default: true
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["affiliate_id"], name: "index_affiliate_wallets_on_affiliate_id", unique: true
  end

  create_table "affiliate_withdrawal_requests", force: :cascade do |t|
    t.bigint "affiliate_id", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.string "status", default: "pending", null: false
    t.datetime "requested_at"
    t.datetime "approved_at"
    t.bigint "approved_by_user_id"
    t.datetime "paid_at"
    t.string "payment_reference"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["affiliate_id"], name: "index_affiliate_withdrawal_requests_on_affiliate_id"
    t.index ["approved_by_user_id"], name: "index_affiliate_withdrawal_requests_on_approved_by_user_id"
    t.index ["created_at"], name: "index_affiliate_withdrawal_requests_on_created_at"
    t.index ["status"], name: "index_affiliate_withdrawal_requests_on_status"
  end

  create_table "affiliates", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "middle_name"
    t.string "email"
    t.string "mobile"
    t.text "address"
    t.string "city"
    t.string "state"
    t.string "pincode"
    t.string "pan_no"
    t.string "gst_no"
    t.decimal "commission_percentage", precision: 5, scale: 2
    t.string "bank_name"
    t.string "account_no"
    t.string "ifsc_code"
    t.string "account_holder_name"
    t.string "account_type"
    t.string "upi_id"
    t.boolean "status", default: true
    t.text "notes"
    t.string "auto_generated_password"
    t.date "joining_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "company_name"
    t.string "username"
    t.string "affiliate_code"
    t.index ["affiliate_code"], name: "index_affiliates_on_affiliate_code", unique: true
    t.index ["email"], name: "index_affiliates_on_email", unique: true
    t.index ["mobile"], name: "index_affiliates_on_mobile", unique: true
    t.index ["status"], name: "index_affiliates_on_status"
  end

  create_table "banners", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "redirect_link"
    t.date "display_start_date"
    t.date "display_end_date"
    t.string "display_location"
    t.boolean "status", default: true
    t.integer "display_order", default: 0
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
    t.string "r2_image_url"
    t.index ["display_location"], name: "index_banners_on_display_location"
    t.index ["display_order"], name: "index_banners_on_display_order"
    t.index ["display_start_date", "display_end_date"], name: "index_banners_on_display_start_date_and_display_end_date"
    t.index ["status"], name: "index_banners_on_status"
  end

  create_table "booking_invoices", force: :cascade do |t|
    t.bigint "booking_id", null: false
    t.bigint "customer_id"
    t.string "invoice_number"
    t.datetime "invoice_date"
    t.datetime "due_date"
    t.decimal "subtotal", precision: 10, scale: 2
    t.decimal "tax_amount", precision: 10, scale: 2
    t.decimal "discount_amount", precision: 10, scale: 2
    t.decimal "total_amount", precision: 10, scale: 2
    t.integer "payment_status"
    t.integer "status"
    t.text "notes"
    t.text "invoice_items"
    t.datetime "paid_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "share_token"
    t.index ["booking_id"], name: "index_booking_invoices_on_booking_id"
    t.index ["customer_id"], name: "index_booking_invoices_on_customer_id"
    t.index ["invoice_date"], name: "index_booking_invoices_on_invoice_date"
    t.index ["invoice_number"], name: "index_booking_invoices_on_invoice_number", unique: true
    t.index ["payment_status"], name: "index_booking_invoices_on_payment_status"
    t.index ["share_token"], name: "index_booking_invoices_on_share_token", unique: true
    t.index ["status"], name: "index_booking_invoices_on_status"
  end

  create_table "booking_items", force: :cascade do |t|
    t.integer "booking_id"
    t.integer "product_id"
    t.decimal "quantity", precision: 8, scale: 2
    t.decimal "price"
    t.decimal "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_variant_id"
    t.index ["booking_id"], name: "index_booking_items_on_booking_id"
    t.index ["product_id"], name: "index_booking_items_on_product_id"
    t.index ["product_variant_id"], name: "index_booking_items_on_product_variant_id"
  end

  create_table "booking_schedules", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "product_id", null: false
    t.string "schedule_type"
    t.string "frequency"
    t.date "start_date"
    t.date "end_date"
    t.integer "quantity"
    t.time "delivery_time"
    t.text "delivery_address"
    t.string "pincode"
    t.decimal "latitude"
    t.decimal "longitude"
    t.string "status"
    t.date "next_booking_date"
    t.integer "total_bookings_generated"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_booking_schedules_on_customer_id"
    t.index ["product_id"], name: "index_booking_schedules_on_product_id"
  end

