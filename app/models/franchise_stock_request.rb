class FranchiseStockRequest < ApplicationRecord
  belongs_to :franchise
  belongs_to :booking, optional: true
  belongs_to :reviewed_by, class_name: "User", optional: true

  has_many :items, class_name: "FranchiseStockRequestItem", dependent: :destroy
  accepts_nested_attributes_for :items, allow_destroy: true,
    reject_if: proc { |attrs| attrs["product_id"].blank? || attrs["quantity"].to_f <= 0 }

  enum :status, { pending: "pending", approved: "approved", rejected: "rejected" }

  validate :must_have_at_least_one_item

  scope :recent, -> { order(created_at: :desc) }

  # Per-worker, 20s-stale cache for the pending-count badges shown in the
  # franchise/admin sidebars on every single page load — same rationale as
  # SystemSetting::LOCAL_CACHE (see lib/local_ttl_cache.rb): a Rails.cache
  # "hit" here would still be a full round trip to the remote Postgres cache
  # DB, so this in-process layer turns the badge into a plain hash read on
  # every request except roughly one per worker per 20s.
  LOCAL_CACHE = LocalTtlCache.new
  LOCAL_TTL = 20.seconds

  def self.pending_count_for(franchise_id)
    LOCAL_CACHE.fetch("franchise_stock_requests/pending_count/#{franchise_id}", LOCAL_TTL) do
      where(franchise_id: franchise_id, status: "pending").count
    end
  end

  def self.admin_pending_count
    LOCAL_CACHE.fetch("franchise_stock_requests/admin_pending_count", LOCAL_TTL) do
      where(status: "pending").count
    end
  end

  # Approves the request: builds a wholesale "Franchise Booking" (same shape
  # as the admin/bookings/new "Franchise Booking" toggle — booked_by: admin,
  # franchise_id set, is_b2b) for the requested items, applies the discount
  # the admin entered on the approval screen, confirms it so
  # Booking#credit_wholesale_stock_to_franchise credits the quantities into
  # the franchise's own inventory ledger, and links this request to it.
  def approve!(admin_user, discount_type: nil, discount_value: nil)
    return false unless pending?

    transaction do
      booking = build_wholesale_booking(discount_type, discount_value)
      booking.save!
      booking.update!(status: :confirmed)

      update!(
        status: :approved,
        booking_id: booking.id,
        discount_type: discount_type.presence,
        discount_value: discount_type.present? ? discount_value.to_f : nil,
        discount_amount: booking.franchise_discount_amount,
        reviewed_by: admin_user,
        reviewed_at: Time.current
      )
    end

    LOCAL_CACHE.delete("franchise_stock_requests/pending_count/#{franchise_id}")
    LOCAL_CACHE.delete("franchise_stock_requests/admin_pending_count")
    true
  rescue => e
    Rails.logger.error "FranchiseStockRequest##{id} approve! failed: #{e.message}"
    errors.add(:base, e.message)
    false
  end

  def reject!(admin_user, reason = nil)
    return false unless pending?

    result = update(status: :rejected, reviewed_by: admin_user, reviewed_at: Time.current, rejection_reason: reason)
    if result
      LOCAL_CACHE.delete("franchise_stock_requests/pending_count/#{franchise_id}")
      LOCAL_CACHE.delete("franchise_stock_requests/admin_pending_count")
    end
    result
  end

  def total_quantity
    items.sum(&:quantity)
  end

  # Read-only preview of what approving this request will actually bill the
  # franchise — one row per item, priced the same way build_wholesale_booking
  # prices the real thing (see resolved_unit_price), plus GST and the B2B
  # savings vs. the regular selling price. Shown on the approval screen in
  # place of a manual discount picker: Product#b2b_price is the one place a
  # wholesale discount is set now, so approval has nothing left to fill in.
  def pricing_preview
    items.includes(:product, :product_variant).filter_map do |item|
      product = item.product
      next unless product

      variant = item.product_variant
      quantity = item.quantity.to_f
      regular_price = variant&.effective_price || product.selling_price
      unit_price = resolved_unit_price(item)

      gst_rate = (product.gst_enabled && product.gst_percentage.to_f > 0) ? product.gst_percentage.to_f : 0
      rounded_final = unit_price.round
      rounded_gst = gst_rate > 0 ? (rounded_final * gst_rate / 100.0) : 0
      rounded_base = rounded_final - rounded_gst

      {
        name: variant ? "#{product.name} [#{variant.label}]" : product.name,
        quantity: quantity,
        unit_price: unit_price,
        regular_price: regular_price,
        is_b2b_priced: unit_price < regular_price,
        gst_rate: gst_rate,
        item_gst_amount: (rounded_gst * quantity).round(2),
        item_subtotal: (rounded_base * quantity).round(2),
        item_total: (rounded_final * quantity).round(2),
        regular_total: (regular_price * quantity).round(2),
        save_amount: ((regular_price - unit_price) * quantity).round(2)
      }
    end
  end

  def pricing_totals(preview = pricing_preview)
    {
      subtotal: preview.sum { |i| i[:item_subtotal] }.round(2),
      gst_amount: preview.sum { |i| i[:item_gst_amount] }.round(2),
      total: preview.sum { |i| i[:item_total] }.round(2),
      savings: preview.sum { |i| i[:save_amount] }.round(2)
    }
  end

  private

  def must_have_at_least_one_item
    active_items = items.reject { |i| i.marked_for_destruction? || i.product_id.blank? || i.quantity.to_f <= 0 }
    errors.add(:base, "Add at least one product to request") if active_items.empty?
  end

  # A variant item is charged its own B2B price (ProductVariant#b2b_selling_price,
  # falling back to the variant's selling_price when unset); a plain product item
  # gets Product#b2b_price (falling back to its selling_price when unset).
  def resolved_unit_price(item)
    item.product_variant&.effective_b2b_price || item.product.effective_b2b_price
  end

  def build_wholesale_booking(discount_type, discount_value)
    booking = Booking.new(
      franchise_id: franchise_id,
      booked_by: "admin",
      # Approving a request is an admin action, but unlike admin/bookings/new
      # this one is intentionally allowed to oversell central stock (it can
      # go negative) rather than block the franchise's request.
      skip_stock_check: true,
      is_b2b: true,
      customer_name: franchise.name,
      customer_phone: franchise.mobile,
      customer_email: franchise.email,
      delivery_address: franchise.address,
      booking_date: Time.current,
      payment_status: "unpaid",
      discount_amount: 0,
      notes: "Franchise stock request ##{id}"
    )

    items.includes(:product, :product_variant).each do |item|
      booking.booking_items.build(
        product_id: item.product_id,
        product_variant_id: item.product_variant_id,
        quantity: item.quantity,
        price: resolved_unit_price(item)
      )
    end

    if discount_type.present? && SystemSetting.franchise_commission_enabled?
      subtotal_for_discount = booking.calculated_subtotal.to_f
      franchise_discount = case discount_type
                            when "percentage"
                              subtotal_for_discount * discount_value.to_f / 100.0
                            when "fixed"
                              discount_value.to_f
                            else
                              0
                            end
      franchise_discount = [[franchise_discount, 0].max, subtotal_for_discount].min.round(2)
      booking.franchise_discount_type = discount_type
      booking.franchise_discount_value = discount_value.to_f
      booking.franchise_discount_amount = franchise_discount
      booking.discount_amount = franchise_discount
    end

    booking
  end
end
