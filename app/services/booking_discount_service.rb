# Recomputes a booking's manual/franchise/coupon discounts server-side from
# the raw request params — the single source of truth used by both
# Admin::BookingsController#create and #update, so editing a booking no
# longer silently skips franchise/coupon recomputation the way it used to.
class BookingDiscountService
  Result = Struct.new(
    :discount_amount, :franchise_discount_amount, :coupon_discount_amount,
    :coupon, :rows, :error_field, :error_message,
    keyword_init: true
  ) do
    def error?
      error_message.present?
    end
  end

  def self.compute(booking:, manual_discount_param:, coupon_code_param:)
    new(booking, manual_discount_param, coupon_code_param).compute
  end

  def initialize(booking, manual_discount_param, coupon_code_param)
    @booking = booking
    @manual_discount_param = manual_discount_param
    @coupon_code_param = coupon_code_param
    @rows = []
  end

  def compute
    manual_amount = clean_manual_discount(@manual_discount_param)
    @rows << row('manual', 'fixed', manual_amount, manual_amount) if manual_amount > 0

    franchise_amount, franchise_error = compute_franchise_discount
    return franchise_error if franchise_error

    coupon, coupon_amount, coupon_error = compute_coupon_discount
    return coupon_error if coupon_error

    Result.new(
      discount_amount: manual_amount + franchise_amount + coupon_amount,
      franchise_discount_amount: franchise_amount,
      coupon_discount_amount: coupon_amount,
      coupon: coupon,
      rows: @rows
    )
  end

  private

  # Same whitespace-stripped .to_f, floored at 0, as the pre-refactor inline
  # logic in Admin::BookingsController#create.
  def clean_manual_discount(raw)
    return 0 if raw.blank?

    cleaned = raw.to_s.gsub(/\s+/, '').strip.to_f
    cleaned > 0 ? cleaned : 0
  end

  # Wholesale "Franchise Booking" discount — recomputed server-side (never
  # trusted from the client) and folded into discount_amount so the standard
  # total calculation picks it up. Mirrors the pre-refactor logic exactly.
  def compute_franchise_discount
    unless @booking.franchise_id.present? && SystemSetting.franchise_commission_enabled?
      @booking.franchise_id = nil
      return [0, nil]
    end

    # Run the real totals calculation now (it also runs again automatically
    # before save) so subtotal/tax_amount reflect the actual GST-exclusive
    # split from booking_items, instead of the GST-inclusive fallback that
    # calculated_subtotal uses for a still-unsaved booking.
    @booking.calculate_totals
    bill_total = (@booking.subtotal.to_f + @booking.tax_amount.to_f).round(2)
    value = @booking.franchise_discount_value.to_f

    case @booking.franchise_discount_type
    when 'percentage'
      if value > 100
        return [0, Result.new(error_field: :franchise_discount_value, error_message: "cannot exceed 100% for a percentage discount")]
      end

      amount = (bill_total * value / 100.0).round(2)
    when 'fixed'
      amount = value.round(2)
    else
      amount = 0
    end

    if amount > bill_total
      return [0, Result.new(error_field: :franchise_discount_value, error_message: "cannot exceed the bill total (₹#{'%.2f' % bill_total})")]
    end

    @rows << row('franchise', @booking.franchise_discount_type, value, amount)
    [amount, nil]
  end

  # Coupon discount — validated & recomputed server-side, the same way the
  # wholesale Franchise Booking discount above is. Applied on top of whatever
  # discount is already set (manual/franchise). Falls back to the booking's
  # already-applied coupon_code when no code param is submitted, so an
  # edit that has no coupon UI still recomputes an existing coupon against a
  # possibly-changed bill_total instead of silently dropping it.
  def compute_coupon_discount
    code = @coupon_code_param.presence || @booking.coupon_code
    code = code.to_s.strip.upcase
    return [nil, 0, nil] if code.blank?

    @booking.calculate_totals
    bill_total = (@booking.subtotal.to_f + @booking.tax_amount.to_f).round(2)
    coupon = Coupon.find_by(code: code)

    error_message =
      if coupon.nil?
        "Coupon code '#{code}' not found"
      elsif !coupon.status
        "Coupon '#{code}' is inactive"
      elsif coupon.expired?
        "Coupon '#{code}' has expired"
      elsif coupon.upcoming?
        "Coupon '#{code}' is not active yet"
      elsif coupon.usage_limit.present? && coupon.used_count >= coupon.usage_limit
        coupon.usage_limit == 1 ? "Coupon '#{code}' has already been used" : "Coupon '#{code}' has reached its usage limit"
      elsif bill_total < coupon.minimum_amount.to_f
        "Coupon '#{code}' requires a minimum order of ₹#{'%.2f' % coupon.minimum_amount}"
      end

    return [nil, 0, Result.new(error_field: :base, error_message: error_message)] if error_message

    amount = coupon.apply_discount(bill_total).round(2)
    @rows << row('coupon', coupon.discount_type, coupon.discount_value, amount, coupon.id)
    [coupon, amount, nil]
  end

  def row(source, discount_type, value, computed_amount, coupon_id = nil)
    { source: source, discount_type: discount_type, value: value, computed_amount: computed_amount, coupon_id: coupon_id }
  end
end
