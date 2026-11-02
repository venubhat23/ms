# One call that returns every admin module for the admin app.
#
# Every section lists its columns explicitly so a new column is private until
# someone adds it here. Never add passwords, password digests, tokens, gateway
# payloads or PAN/Aadhaar/bank details. SystemSetting is left out on purpose:
# it holds the payment gateway keys.
#
# Sections with a date_column are activity and follow the date filter. The rest
# are master data (products, customers, ...) and always come back whole.
class Api::V1::Admin::AllDataController < Api::V1::Admin::BaseController
  DEFAULT_LIMIT = 50
  MAX_LIMIT = 200
  DEFAULT_DAYS = 30

  SECTIONS = {
    # Sales
    bookings: {
      scope: -> { Booking.all },
      date_column: 'created_at',
      columns: %w[booking_number booking_date status payment_status subtotal tax_amount discount_amount total_amount
                  final_amount_after_discount wallet_amount_used coupon_code coupon_discount_amount shipping_charges
                  refund_amount customer_id customer_name customer_email customer_phone delivery_address store_id
                  franchise_id affiliate_id delivery_person_id delivery_mode courier_service tracking_number
                  expected_delivery_date delivered_at is_b2b is_pre_booking booked_by invoice_number payment_gateway
                  payment_completed_at cancellation_reason notes],
      # The raw column is junk: a string holding an integer enum value.
      extras: ->(b) { { payment_method: b.payment_method_display } }
    },
    orders: {
      scope: -> { Order.all },
      date_column: 'created_at',
      columns: %w[order_number order_date status payment_status payment_method subtotal tax_amount discount_amount
                  shipping_amount total_amount customer_id customer_name customer_email customer_phone delivery_address
                  tracking_number delivered_at cancellation_reason refund_amount booking_id notes]
    },
    booking_invoices: {
      scope: -> { BookingInvoice.all },
      date_column: 'created_at',
      columns: %w[booking_id customer_id invoice_number invoice_date due_date subtotal tax_amount discount_amount
                  total_amount payment_status status paid_at]
    },
    pending_amounts: {
      scope: -> { PendingAmount.all },
      date_column: 'pending_date',
      columns: %w[customer_id amount description pending_date status notes]
    },
    milk_subscriptions: {
      scope: -> { MilkSubscription.all },
      columns: %w[customer_id product_id quantity unit start_date end_date delivery_time delivery_pattern total_amount
                  status is_active delivery_person_id]
    },

    # Customers
    customers: {
      scope: -> { Customer.all },
      columns: %w[first_name middle_name last_name email mobile whatsapp_number address gender birth_date company_name
                  status referred_by_affiliate_id]
    },
    customer_wallets: {
      scope: -> { CustomerWallet.all },
      columns: %w[customer_id balance status]
    },
    product_reviews: {
      scope: -> { ProductReview.all },
      date_column: 'created_at',
      columns: %w[product_id customer_id reviewer_name title rating comment status verified_purchase]
    },
    client_requests: {
      scope: -> { ClientRequest.all },
      date_column: 'created_at',
      columns: %w[ticket_number title description status priority stage department customer_id name email phone_number
                  admin_response submitted_at resolved_at]
    },
    leads: {
      scope: -> { Lead.all },
      date_column: 'created_at',
      columns: %w[name first_name last_name contact_number email company_name current_stage lead_source product_category
                  customer_type affiliate_id]
    },

    # Catalog and stock
    products: {
      scope: -> { Product.with_total_stock.includes(image_attachment: :blob) },
      columns: %w[name sku barcode category_id price discount_price buying_price b2b_price stock status unit_type
                  has_multiple_quantities gst_enabled gst_percentage hsn_code minimum_stock_alert],
      extras: lambda { |p|
        { total_stock: p.computed_total_stock.to_i,
          stock_status: Product.stock_status_for(p.computed_total_stock),
          main_image_url: p.main_image_url }
      }
    },
    product_variants: {
      scope: -> { ProductVariant.all },
      columns: %w[product_id weight unit buying_price selling_price b2b_selling_price discount_enabled discount_type
                  discount_value final_price_with_gst available_stock low_stock_threshold is_default]
    },
    categories: {
      scope: -> { Category.all },
      columns: %w[name description status display_order]
    },
    stock_movements: {
      scope: -> { StockMovement.all },
      date_column: 'created_at',
      columns: %w[product_id movement_type quantity stock_before stock_after reference_type reference_id notes]
    },
    coupons: {
      scope: -> { Coupon.all },
      columns: %w[code description discount_type discount_value minimum_amount maximum_discount usage_limit used_count
                  valid_from valid_until status]
    },
    banners: {
      scope: -> { Banner.all },
      columns: %w[title description redirect_link display_location display_start_date display_end_date status
                  display_order image_url]
    },

    # Shops and franchises
    stores: {
      scope: -> { Store.all },
      columns: %w[name address city state pincode contact_person contact_mobile email status is_main_inventory
                  commission_percentage]
    },
    franchises: {
      scope: -> { Franchise.all },
      columns: %w[name email mobile contact_person_name business_type address city state pincode territory
                  commission_percentage status]
    },
    franchise_inventories: {
      scope: -> { FranchiseInventory.all },
      columns: %w[franchise_id product_id quantity]
    },
    franchise_wallets: {
      scope: -> { FranchiseWallet.all },
      columns: %w[franchise_id balance status]
    },
    franchise_withdrawal_requests: {
      scope: -> { FranchiseWithdrawalRequest.all },
      date_column: 'created_at',
      columns: %w[franchise_id booking_id amount status requested_at approved_at paid_at payment_reference notes]
    },
    franchise_stock_requests: {
      scope: -> { FranchiseStockRequest.all },
      date_column: 'created_at',
      columns: %w[franchise_id booking_id status items_count discount_amount reviewed_at rejection_reason notes]
    },
    franchise_returns: {
      scope: -> { FranchiseReturn.all },
      date_column: 'created_at',
      columns: %w[franchise_id status total_amount items_count reviewed_at rejection_reason notes]
    },

    # Partners and delivery
    delivery_people: {
      scope: -> { DeliveryPerson.all },
      columns: %w[first_name last_name email mobile vehicle_type vehicle_number city state pincode delivery_areas status]
    },
    affiliates: {
      scope: -> { Affiliate.all },
      columns: %w[first_name last_name email mobile city state company_name affiliate_code commission_percentage
                  joining_date status]
    },
    affiliate_wallets: {
      scope: -> { AffiliateWallet.all },
      columns: %w[affiliate_id balance status]
    },
    affiliate_withdrawal_requests: {
      scope: -> { AffiliateWithdrawalRequest.all },
      date_column: 'created_at',
      columns: %w[affiliate_id amount status requested_at approved_at paid_at payment_reference notes]
    },
    referrals: {
      scope: -> { Referral.all },
      date_column: 'created_at',
      columns: %w[affiliate_id referring_customer_id customer_id referred_name referred_mobile referred_email
                  referral_date referral_source status converted_at notes]
    },
    sub_agents: {
      scope: -> { SubAgent.all },
      columns: %w[first_name last_name email mobile company_name city state joining_date status]
    },

    # Money out
    vendors: {
      scope: -> { Vendor.all },
      columns: %w[name phone email address payment_type opening_balance status]
    },
    vendor_purchases: {
      scope: -> { VendorPurchase.all },
      date_column: 'purchase_date',
      columns: %w[vendor_id purchase_date total_amount paid_amount status notes]
    },
    vendor_payments: {
      scope: -> { VendorPayment.all },
      date_column: 'payment_date',
      columns: %w[vendor_id vendor_purchase_id amount_paid payment_date payment_mode notes]
    },
    expenses: {
      scope: -> { Expense.all },
      date_column: 'expense_date',
      columns: %w[store_id title description amount category expense_date]
    },
    cash_deposits: {
      scope: -> { CashDeposit.all },
      date_column: 'deposited_on',
      columns: %w[store_id amount deposited_on bank_name reference_number notes]
    },

    # Admin only: salaries and logins stay hidden from read-only admin_viewer accounts.
    staff_members: {
      admin_only: true,
      scope: -> { StaffMember.all },
      columns: %w[store_id name mobile email designation monthly_salary joining_date status]
    },
    staff_payments: {
      admin_only: true,
      scope: -> { StaffPayment.all },
      date_column: 'payment_date',
      columns: %w[staff_member_id amount payment_date month year notes]
    },
    users: {
      admin_only: true,
      scope: -> { User.all },
      columns: %w[first_name last_name email mobile user_type status department designation last_sign_in_at]
    }
  }.freeze

  COMPUTED_SECTIONS = %i[summary cash_in_hand].freeze

  # GET /api/v1/admin/all_data
  # GET /api/v1/mobile/admin/all_data
  # Params: from_date, to_date (YYYY-MM-DD, default last 30 days), sections (comma
  # list, default all), limit (rows per list, default 50, max 200), page (for
  # walking a long list one section at a time).
  def index
    wanted = requested_sections
    unknown = wanted - available_sections
    return render_error('Unknown sections', { unknown: unknown, available: available_sections }) if unknown.any?

    dates = date_range
    return render_error('Invalid date range, use YYYY-MM-DD with from_date before to_date') unless dates

    limit = (params[:limit].presence || DEFAULT_LIMIT).to_i.clamp(1, MAX_LIMIT)
    page = [params[:page].to_i, 1].max
    data = { generated_at: Time.current, from_date: dates.begin, to_date: dates.end, limit: limit, page: page,
             section_errors: {} }

    wanted.each do |name|
      data[name] = COMPUTED_SECTIONS.include?(name) ? computed_section(name) : list_section(SECTIONS[name], dates, limit, page)
    rescue StandardError => e
      # One broken module must not blank the whole app screen.
      Rails.logger.error("[AllData] #{name}: #{e.class}: #{e.message}")
      data[:section_errors][name] = 'Could not load this section'
    end

    render_success(data)
  end

  private

  def available_sections
    lists = SECTIONS.reject { |_, section| section[:admin_only] && !@current_user.admin? }.keys
    COMPUTED_SECTIONS + lists
  end

  def requested_sections
    names = params[:sections].to_s.split(',').map { |name| name.strip.to_sym }.reject(&:blank?)
    names.presence || available_sections
  end

  # from..to as Dates, or nil when a given date is unreadable or the range is
  # backwards. Each side defaults from the other, ending today.
  def date_range
    return if [:from_date, :to_date].any? { |key| params[key].present? && param_date(key).nil? }

    to = param_date(:to_date) || Date.current
    from = param_date(:from_date) || (to - DEFAULT_DAYS.days)
    from..to if from <= to
  end

  def computed_section(name)
    name == :summary ? Api::V1::Admin::DashboardController.summary : cash_in_hand
  end

  def list_section(section, dates, limit, page)
    scope = section[:scope].call
    date_column = section[:date_column]
    scope = scope.where(date_column => dates.begin.beginning_of_day..dates.end.end_of_day) if date_column
    records = scope.order(id: :desc).limit(limit).offset((page - 1) * limit)

    {
      date_filtered: date_column.present?,
      total_count: scope.except(:select, :includes).count,
      items: records.map { |record| row(record, section) }
    }
  end

  def row(record, section)
    values = section[:columns].index_with { |column| json_number(record[column]) }
    { id: record.id, created_at: record.created_at }.merge(values).merge(section[:extras]&.call(record) || {})
  end

  # BigDecimal would otherwise serialize as a JSON string.
  def json_number(value)
    value.is_a?(BigDecimal) ? value.to_f : value
  end

  # Same figures as the web POS cash page. store_id nil is the main shop.
  def cash_in_hand
    collected = CashDeposit.collected_by_store
    deposited = CashDeposit.deposited_by_store
    names = Store.where(id: (collected.keys | deposited.keys).compact).pluck(:id, :name).to_h

    (collected.keys | deposited.keys).map do |store_id|
      cash = (collected[store_id] || [0, 0.to_d]).last
      banked = deposited[store_id] || 0.to_d
      {
        store_id: store_id,
        store_name: store_id ? names[store_id] : CashDeposit::MAIN_STORE_LABEL,
        collected: cash.to_f,
        deposited: banked.to_f,
        in_hand: (cash - banked).to_f
      }
    end
  end
end
