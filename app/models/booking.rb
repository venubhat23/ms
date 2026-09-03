class Booking < ApplicationRecord
  # Non-admin booking channels (franchise self-service, mobile app, affiliate)
  # set this before save so BookingItem lets the booking through even when
  # requested quantity exceeds available stock, pushing product stock
  # negative instead of blocking with "out of stock". Admin bookings
  # (Admin::BookingsController) never set it, so they keep blocking.
  attr_accessor :skip_stock_check

  belongs_to :customer, optional: true
  belongs_to :user, optional: true # Admin who created the booking
  belongs_to :booking_schedule, optional: true # For subscription bookings
  belongs_to :store, optional: true
  belongs_to :delivery_person, optional: true
  belongs_to :franchise, optional: true
  belongs_to :delivery_franchise, class_name: 'Franchise', optional: true
  belongs_to :affiliate, optional: true
  belongs_to :wallet_transaction, optional: true
  belongs_to :coupon, optional: true
  has_many :booking_items, dependent: :destroy
  # has_one :order, dependent: :nullify  # Temporarily disabled until booking_id column is added to orders table
  has_many :booking_invoices, dependent: :destroy
  has_many :sale_items, dependent: :destroy
  has_many :booking_discounts, dependent: :destroy

  accepts_nested_attributes_for :booking_items, allow_destroy: true


  # Enums - Comprehensive status for complete workflow
  enum :status, {
    draft: 'draft',                                 # Initial booking creation
    ordered_and_delivery_pending: 'ordered_and_delivery_pending', # Order placed, waiting for processing
    confirmed: 'confirmed',                         # Booking confirmed, payment received
    processing: 'processing',                       # Order being prepared
    packed: 'packed',                               # Items packed and ready
    shipped: 'shipped',                             # Shipped out
    out_for_delivery: 'out_for_delivery',          # Out for delivery
    delivered: 'delivered',                         # Successfully delivered
    completed: 'completed',                         # Transaction completed
    cancelled: 'cancelled',                         # Cancelled
    returned: 'returned'                           # Returned
  }

  enum :payment_status, {
    unpaid: 'unpaid',
    paid: 'paid',
    partially_paid: 'partially_paid',
    refunded: 'refunded'
  }, prefix: true

  enum :payment_method, {
    cash: 0,
    card: 1,
    upi: 2,
    bank_transfer: 3,
    online: 4,
    cod: 5,
    cashfree: 6,
    cloudflare: 7,
    wallet: 8
  }, prefix: true

  enum :payment_gateway, {
    cash: 'cash',
    cashfree: 'cashfree',
    cloudflare: 'cloudflare',
    upi_direct: 'upi_direct'
  }, prefix: true

  # Validations
  validates :booking_number, presence: true
  # Uniqueness only re-checked when the field actually changes — every
  # stage-transition bang method (mark_as_X!, cancel_order!, ...) calls
  # update!, and without this guard each of those round-trips to the DB
  # re-validates uniqueness for a value that was never touched.
  validates :booking_number, uniqueness: true, if: :will_save_change_to_booking_number?
  validates :total_amount, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :wallet_amount_used, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  # Set by controllers (e.g. Franchise::BookingsController) whose form marks
  # delivery address as required client-side — enforces it server-side too,
  # without forcing it on other booking flows (admin/store pickup, etc.).
  attr_accessor :require_delivery_address
  validates :delivery_address, presence: true, if: :require_delivery_address

  before_validation :generate_booking_number, on: :create
  before_validation :calculate_totals
  before_validation :calculate_final_amount_after_discount
  after_validation :ensure_total_amount_present
  before_create :attribute_to_referring_affiliate
  # Covers bookings saved directly into a stock-consuming status at creation
  # (e.g. a franchise/admin walk-in sale whose form defaults status to
  # "completed", never passing through an update where status changes) —
  # without this, allocate_inventory only ever fired on the confirmed
  # transition, so those bookings never deducted stock at all.
  after_create :allocate_inventory
  after_update :allocate_inventory, if: :saved_change_to_status?
  after_update :sync_invoice_payment_status, if: :saved_change_to_payment_status?
  after_update :credit_affiliate_commission, if: :saved_change_to_status?
  # Same class of bug allocate_inventory/allocate_franchise_inventory above
  # were already fixed for: admin/bookings/new's status select defaults to
  # "completed", so a Franchise Booking is normally created directly into a
  # stock-consuming status rather than reaching it via a later update — an
  # after_update-only callback never sees that as a "confirmed" transition
  # and silently never credits the franchise's inventory ledger.
  after_create :credit_wholesale_stock_to_franchise
  after_update :credit_wholesale_stock_to_franchise, if: :saved_change_to_status?
  after_update :credit_franchise_commission, if: :saved_change_to_status?
  after_commit :bust_mobile_customer_cache
  # Admin::BookingsController#index caches its paginated listing and status
  # counts (the DB is remote — a cache hit skips a ~200-400ms round trip).
  # Nothing expired those on write, so an admin returning to /admin/bookings
  # right after creating a booking or assigning it to a franchise saw a
  # stale list (old status, missing "Assigned Franchise" badge) for up to a
  # minute. Bust both here so the change shows immediately.
  after_commit :bust_admin_bookings_cache, on: [:create, :update, :destroy]

  # Covers every booking-creation path (customer checkout, admin, franchise,
  # mobile API, affiliate, subscriptions, ...) in one place instead of each
  # controller remembering to call generate_quick_invoice! itself — several
  # of them didn't, which is why bookings created outside the admin panel
  # kept landing on their detail page still showing "Generate Invoice".
  # after_create_commit (not after_create) so booking_items built via
  # accepts_nested_attributes_for are guaranteed to be persisted first.
  # generate_quick_invoice! already no-ops safely for empty-item bookings
  # and rescues its own errors, so this can't fail the booking itself.
  after_create_commit :generate_quick_invoice!

  # Covers every booking-creation path (customer checkout, admin, franchise,
  # affiliate portal, mobile API, ...) from one place instead of needing each
  # controller to remember to set affiliate_id when the customer was referred.
  def attribute_to_referring_affiliate
    self.affiliate_id ||= customer&.referred_by_affiliate_id
  end

  # Pays the referring affiliate their cut once the sale is final. Guarded by
  # affiliate_commission_credited_at so this can never double-credit even if
  # the status-change callback somehow fires more than once for the same
  # completed booking.
  def credit_affiliate_commission
    return unless completed? && affiliate_id.present? && affiliate_commission_credited_at.nil?

    commission_amount = (total_amount.to_f * affiliate.commission_percentage.to_f / 100.0).round(2)
    return unless commission_amount.positive?

    transaction do
      update_column(:affiliate_commission_credited_at, Time.current)
      affiliate.affiliate_wallet.add_money(
        commission_amount,
        "Commission for Booking ##{booking_number}",
        "COMM-BK-#{id}",
        booking_id: id
      )
    end
  end

  # Wholesale "Franchise Booking" from admin/bookings/new: once the sale
  # first reaches a stock-consuming status (stock already deducted from
  # central inventory by allocate_inventory above), the same quantities are
  # credited into the buying franchise's own inventory ledger. Checked
  # against the same STOCK_CONSUMING_STATUSES set as allocate_franchise_
  # inventory below (not a strict "confirmed" transition) since the booking
  # is normally created directly into "completed", never passing through an
  # update where status changes — wholesale_stock_credited_at makes this
  # safe to check broadly, since it guarantees the credit still only ever
  # happens once no matter how many stock-consuming statuses are crossed.
  def credit_wholesale_stock_to_franchise
    return unless STOCK_CONSUMING_STATUSES.include?(status) && !STOCK_CONSUMING_STATUSES.include?(status_previously_was)
    return unless booked_by == 'admin' && franchise_id.present? && wholesale_stock_credited_at.nil?
    return unless SystemSetting.franchise_commission_enabled?

    transaction do
      update_column(:wholesale_stock_credited_at, Time.current)
      booking_items.each do |item|
        next unless item.product_id.present? && item.quantity.to_f.positive?

        FranchiseInventory.add_stock!(
          franchise, item.product,
          item.quantity,
          reference_type: 'wholesale_booking',
          reference_id: id,
          notes: "Wholesale Booking ##{booking_number}"
        )
      end
    end
  end

  # Commission for whichever franchise delivered the booking (assigned via
  # manage_stage "Franchise Delivery"), regardless of who booked/owns it.
  def credit_franchise_commission
    return unless (status == 'delivered' || status == 'completed') && delivery_franchise_id.present?
    return unless franchise_commission_credited_at.nil?
    return unless SystemSetting.franchise_commission_enabled?

    commission_amount = (total_amount.to_f * delivery_franchise.commission_percentage.to_f / 100.0).round(2)
    return unless commission_amount.positive?

    transaction do
      update_columns(franchise_commission_amount: commission_amount, franchise_commission_credited_at: Time.current)
      wallet = delivery_franchise.franchise_wallet || delivery_franchise.create_franchise_wallet!(balance: 0)
      wallet.add_money(
        commission_amount,
        "Delivery commission for Booking ##{booking_number}",
        "FCOMM-BK-#{id}",
        booking_id: id
      )
    end
  end

  # Keeps the already-generated Invoice's payment_status in step with the booking's,
  # so a booking marked paid after invoice creation doesn't leave a stale "unpaid" invoice.
  # Some bookings (e.g. created unpaid via the mobile UI) never got an invoice generated
  # at creation time — if one of those is later marked paid, generate the invoice now
  # instead of silently no-op'ing.
  def sync_invoice_payment_status
    invoice = invoice_number.present? ? Invoice.find_by(invoice_number: invoice_number) : nil

    unless invoice
      generate_quick_invoice! if payment_status_paid?
      return
    end

    case payment_status
    when 'paid'
      return if invoice.payment_status == 'fully_paid'
      invoice.update(payment_status: :fully_paid, paid_at: invoice.paid_at || Time.current, paid_amount: invoice.total_amount)
    when 'partially_paid'
      return if invoice.payment_status == 'partially_paid'
      invoice.update(payment_status: :partially_paid)
    else
      return if invoice.payment_status == 'unpaid'
      invoice.update(payment_status: :unpaid, paid_at: nil, paid_amount: 0)
    end
  end

  def bust_mobile_customer_cache
    cid = customer_id || customer&.id
    MobileApiCache.bust_booking!(cid)
  end

  # Admin::BookingsController#index folds this generation token into its
  # listing/status-count cache keys, so bumping it here makes every cached
  # variation (per filter/page/franchise) unreachable at once. Done this way
  # rather than Rails.cache.delete_matched because :solid_cache_store (used
  # in production) raises NotImplementedError for delete_matched. Stale
  # entries just age out on their own short TTL.
  ADMIN_BOOKINGS_CACHE_GENERATION_KEY = 'admin_bookings/cache_generation'

  def self.admin_bookings_cache_generation
    Rails.cache.read(ADMIN_BOOKINGS_CACHE_GENERATION_KEY) || '0'
  end

  def bust_admin_bookings_cache
    Rails.cache.write(ADMIN_BOOKINGS_CACHE_GENERATION_KEY, Time.now.to_f.to_s, expires_in: 1.hour)
  rescue StandardError => e
    Rails.logger.warn "bust_admin_bookings_cache failed: #{e.message}"
  end

  # id: :desc is a tiebreaker so the newest booking is reliably on top even
  # when several share the same created_at second (bulk/pre-booking imports).
  scope :recent, -> { order(created_at: :desc, id: :desc) }
  scope :today, -> { where(created_at: Date.current.all_day) }
  scope :active, -> { where.not(status: [:cancelled, :returned]) }
  scope :completed_orders, -> { where(status: [:delivered, :completed]) }
  scope :pending_orders, -> { where(status: [:draft, :ordered_and_delivery_pending, :confirmed]) }
  scope :in_progress, -> { where(status: [:processing, :packed, :shipped, :out_for_delivery]) }

  def generate_booking_number
    self.booking_number ||= "BK#{Date.current.strftime('%Y%m%d')}#{SecureRandom.hex(3).upcase}"
  end


  def create_booking_invoice_record
    return if booking_invoices.any? # Avoid duplicates

    # Ensure totals are calculated before creating invoice
    calculate_totals

    booking_invoices.create!(
      customer: self.customer,
      invoice_number: self.invoice_number,
      invoice_date: Time.current,
      due_date: 30.days.from_now,
      subtotal: self.subtotal || 0,
      tax_amount: self.tax_amount || 0,
      discount_amount: self.discount_amount || 0,
      total_amount: self.total_amount || 0,
      payment_status: self.payment_status || :unpaid,
      status: :sent,
      notes: "Invoice generated for booking ##{self.booking_number}"
    )
  rescue => e
    Rails.logger.error "Failed to create BookingInvoice for Booking ##{id}: #{e.message}"
    # Don't fail the booking creation if invoice creation fails
  end

  def calculate_totals
    # Calculate totals for items (including unsaved ones) — `booking_items.to_a`
    # keeps any newly-built-but-unsaved items (needed during creation), and
    # looking products up via product_id from one batched query instead of
    # `item.product` avoids a query per item.
    items = booking_items.to_a
    products_by_id = Product.where(id: items.map(&:product_id).compact.uniq).index_by(&:id)

    items_total = 0
    total_gst = 0

    items.each do |item|
      if item.quantity.present? && item.price.present?
        quantity = item.quantity
        price = item.price
        product = products_by_id[item.product_id]

        # Price is GST-inclusive: extract base via per-unit rounding
        if product && product.gst_enabled && product.gst_percentage.to_f > 0
          gst_rate      = product.gst_percentage.to_f
          rounded_final = price.round
          rounded_base  = (rounded_final / (1 + gst_rate / 100.0)).round
          items_total  += rounded_base * quantity
          total_gst    += (rounded_final - rounded_base) * quantity
        else
          items_total += price * quantity
        end
      end
    end

    # Ensure discount doesn't exceed subtotal + tax
    current_discount = discount_amount.to_f
    max_discount = items_total + total_gst
    if current_discount > max_discount
      current_discount = max_discount
      self.discount_amount = current_discount
    end

    self.subtotal = items_total.round(2)
    self.tax_amount = total_gst.round(2)
    self.total_amount = (items_total + total_gst - current_discount + shipping_charges.to_f).round(2)
  end

  def calculate_totals!
    calculate_totals
    save!
  end

  # Dynamic calculation methods for invoice display
  def calculated_subtotal
    return subtotal if subtotal.present?

    total = booking_items.sum { |item| (item.quantity || 0) * (item.price || 0) }
    total.round(2)
  end

  def calculated_tax_amount
    return tax_amount if tax_amount.present?

    # Calculate GST based on individual products — batched product lookup,
    # same rationale as calculate_totals above.
    items = booking_items.to_a
    products_by_id = Product.where(id: items.map(&:product_id).compact.uniq).index_by(&:id)

    total_gst = 0
    items.each do |item|
      product = products_by_id[item.product_id]
      if product && product.gst_enabled && product.gst_percentage.to_f > 0
        gst_rate = product.gst_percentage.to_f
        item_base = (item.price || 0) * (item.quantity || 0)
        item_gst = (item_base * gst_rate / 100).round(2)
        total_gst += item_gst
      end
    end
    total_gst.round(2)
  end

  def calculated_gst_percentage
    return 0 if calculated_subtotal == 0
    ((calculated_tax_amount / calculated_subtotal) * 100).round(2)
  end

  def calculated_total_amount
    return total_amount if total_amount.present?

    (calculated_subtotal + calculated_tax_amount - (discount_amount || 0) + shipping_charges.to_f).round(2)
  end

  def amount_in_words
    amount = calculated_total_amount.to_i
    convert_to_words(amount) + " Rupees Only"
  end

  # True for a wholesale sale entered through the admin "New Booking" form
  # with its Franchise Booking toggle on (which requires picking a franchise
  # as the buyer) — as opposed to a franchise's own self-service booking
  # (booked_by == 'franchise'), which is a different flow entirely.
  def franchise_wholesale_pricing?
    booked_by == 'admin' && franchise_id.present?
  end

  # Best-effort "what this would have cost at regular price" total for a
  # Franchise Booking, for the strikethrough shown next to the actual total
  # in the admin UI. The wholesale saving is baked straight into each
  # booking_item's price at creation time and never stored separately
  # anywhere, so this is recomputed from each item's *current* product price
  # (same GST-inclusive convention as the Franchise Booking toggle uses) —
  # it will drift from the true figure if a product's price has changed
  # since, and must never be used for actual charge/refund math.
  def franchise_regular_total
    return nil unless franchise_wholesale_pricing?

    self.class.franchise_regular_total_for_items(booking_items.includes(:product))
  end

  # Batched version of the above for a list of already-loaded booking_items
  # (each with .product preloaded) spanning one or many bookings — lets the
  # bookings index compute this for a whole page in one query instead of
  # firing franchise_regular_total per row.
  def self.franchise_regular_total_for_items(items)
    items.sum { |item| regular_unit_price_for_item(item) * item.quantity.to_f }.round(2)
  end

  # A single item's current regular (non-B2B) unit price — the per-line-item
  # building block behind franchise_regular_total(_for_items), also used
  # directly to show a Selling/B2B price breakdown per row on the booking
  # detail page.
  def self.regular_unit_price_for_item(item)
    product = item.product
    return item.price.to_f unless product

    # Multi-quantity/variant products don't have a distinct B2B price (see
    # Product#effective_b2b_price) — they were charged their regular price
    # even under Franchise Booking, so there's no saving to show.
    return item.price.to_f if product.has_multiple_quantities?

    selling_price = if product.discount_price.present? && product.discount_price != product.price
      product.discount_price
    else
      product.price
    end

    selling_price.to_f.round
  end

  # Status management methods
  def can_cancel?
    %w[draft ordered_and_delivery_pending confirmed processing].include?(status)
  end

  # Pre-booking (out-of-stock order placed while SystemSetting.allow_pre_booking_enabled?
  # is on) sits at "ordered_and_delivery_pending" until an admin explicitly
  # approves or rejects it — see Admin::BookingsController#approve_pre_booking /
  # #reject_pre_booking, which drive this through the existing
  # mark_as_confirmed! / cancel_order! transitions.
  def pending_pre_booking_approval?
    is_pre_booking? && ordered_and_delivery_pending?
  end

  # Admin approves a pending pre-booking: moves it to "confirmed" (same as
  # any other order reaching that stage) and sends the usual confirmation
  # email via mark_as_confirmed!.
  def approve_pre_booking!
    mark_as_confirmed! if pending_pre_booking_approval?
  end

  # Admin rejects a pending pre-booking: cancels it, same as cancel_order!
  # for any other cancellable booking, with a pre-booking-specific default
  # reason when none is given.
  def reject_pre_booking!(reason = nil)
    cancel_order!(reason.presence || 'Pre-booking rejected by admin') if pending_pre_booking_approval?
  end

  # Pre-booking tracker steps shown to the customer on /track-order and
  # referenced on the admin manage_stage page, so both stay in sync.
  PRE_BOOKING_TRACKING_STEPS = [
    { key: 'ordered_and_delivery_pending', label: 'Order Placed',     icon: '🧾' },
    { key: 'confirmed',                    label: 'Admin Confirmed',  icon: '✅' },
    { key: 'paid',                         label: 'Paid',             icon: '💳' },
    { key: 'processing',                   label: 'Processing',       icon: '⚙️' },
    { key: 'packed',                       label: 'Packed',           icon: '📦' },
    { key: 'shipped',                      label: 'Shipped',          icon: '🚚' },
    { key: 'out_for_delivery',             label: 'Out for Delivery', icon: '🛵' },
    { key: 'delivered',                    label: 'Delivered',        icon: '🏠' }
  ].freeze

  # Index into PRE_BOOKING_TRACKING_STEPS reflecting how far a pre-booking
  # has progressed. Unlike a normal order (a plain status lookup), "Paid"
  # tracks payment_status independently of "Admin Confirmed" — see
  # mark_payment_completed!, which can complete payment before admin
  # approval — so this returns the longest *contiguous* prefix of steps
  # that are actually satisfied, rather than jumping ahead on an
  # out-of-order payment and falsely marking "Admin Confirmed" as done.
  def pre_booking_tracking_step_index
    post_confirm_ranks = %w[processing packed shipped out_for_delivery delivered completed]
    status_rank = post_confirm_ranks.index(status)

    conditions = [
      true,
      !pending_pre_booking_approval? && !%w[draft cancelled].include?(status),
      payment_status_paid?,
      !status_rank.nil? && status_rank >= 0,
      !status_rank.nil? && status_rank >= 1,
      !status_rank.nil? && status_rank >= 2,
      !status_rank.nil? && status_rank >= 3,
      !status_rank.nil? && status_rank >= 4
    ]

    index = 0
    conditions.each_with_index do |ok, i|
      break unless ok

      index = i
    end
    index
  end

  def can_return?
    %w[delivered completed].include?(status)
  end

  def mark_as_confirmed!
    if draft? || ordered_and_delivery_pending?
      update!(status: :confirmed)
      # Send booking confirmation email when order is confirmed
      send_booking_confirmation_email
    end
  end

  def mark_as_processing!
    update!(status: :processing) if confirmed?
  end

  def mark_as_packed!
    update!(status: :packed) if processing?
  end

  def mark_as_shipped!(tracking_number = nil)
    if packed?
      updates = { status: :shipped }
      updates[:notes] = "#{notes}\nTracking: #{tracking_number}" if tracking_number.present?
      update!(updates)
    end
  end

  def mark_as_out_for_delivery!
    update!(status: :out_for_delivery) if shipped?
  end

  def mark_as_delivered!
    if out_for_delivery?
      update!(
        status: :delivered,
        notes: "#{notes}\nDelivered at: #{Time.current.strftime('%d/%m/%Y %I:%M %p')}"
      )
      # Auto-transition to completed when delivered (as per user requirement)
      mark_as_completed!
    end
  end

  def mark_as_completed!
    if delivered?
      update!(status: :completed)
      # Generate and send invoice when booking is completed
      generate_and_send_completion_notification
    end
  end

  # Manual admin action for cash/offline payments collected outside the
  # gateway flow (see mark_payment_completed! for the Cashfree equivalent).
  # The existing after_update :sync_invoice_payment_status callback handles
  # keeping the linked Invoice in sync — no extra work needed here.
  def mark_as_fully_paid!
    update!(payment_status: :paid)
  end

  def cancel_order!(reason = nil)
    if can_cancel?
      cancel_notes = reason.present? ? "Cancelled: #{reason}" : "Cancelled"
      update!(
        status: :cancelled,
        notes: "#{notes}\n#{cancel_notes} at #{Time.current.strftime('%d/%m/%Y %I:%M %p')}"
      )
    end
  end

  def return_order!(reason = nil)
    if can_return?
      return_notes = reason.present? ? "Returned: #{reason}" : "Returned"
      update!(
        status: :returned,
        notes: "#{notes}\n#{return_notes} at #{Time.current.strftime('%d/%m/%Y %I:%M %p')}"
      )
    end
  end

  # Display helpers
  def status_color
    case status
    when 'draft', 'ordered_and_delivery_pending' then 'secondary'
    when 'confirmed' then 'info'
    when 'processing', 'packed' then 'warning'
    when 'shipped', 'out_for_delivery' then 'primary'
    when 'delivered', 'completed' then 'success'
    when 'cancelled', 'returned' then 'danger'
    else 'secondary'
    end
  end

  def status_icon
    case status
    when 'draft' then 'bi-pencil'
    when 'ordered_and_delivery_pending' then 'bi-clock'
    when 'confirmed' then 'bi-check-circle'
    when 'processing' then 'bi-gear'
    when 'packed' then 'bi-box'
    when 'shipped' then 'bi-truck'
    when 'out_for_delivery' then 'bi-geo-alt'
    when 'delivered' then 'bi-house-check'
    when 'completed' then 'bi-check-all'
    when 'cancelled' then 'bi-x-circle'
    when 'returned' then 'bi-arrow-return-left'
    else 'bi-question-circle'
    end
  end

  def next_possible_statuses
    case status
    when 'draft' then ['ordered_and_delivery_pending', 'confirmed', 'cancelled']
    when 'ordered_and_delivery_pending' then ['confirmed', 'cancelled']
    when 'confirmed' then ['processing', 'cancelled']
    when 'processing' then ['packed', 'cancelled']
    when 'packed' then ['shipped']
    when 'shipped' then ['out_for_delivery']
    when 'out_for_delivery' then ['delivered']
    when 'delivered' then ['returned']  # Auto-transitions to completed, so only return is possible
    else []
    end
  end

  def payment_method_display
    raw_value = read_attribute(:payment_method)
    return 'Cash on Delivery' if raw_value.blank?

    case raw_value.to_s
    when 'cash', '0'          then 'Cash'
    when 'card', '1'          then 'Card'
    when 'upi', '2'           then 'UPI'
    when 'bank_transfer', '3' then 'Bank Transfer'
    when 'online', '4'        then 'Online'
    when 'cod', '5'           then 'Cash on Delivery'
    when 'cashfree', '6'      then 'Online Payment'
    when 'cloudflare', '7'    then 'Online Payment'
    when 'wallet', '8'        then 'Wallet'
    else 'Cash on Delivery'
    end
  end

  def payment_method_label
    raw_value = read_attribute(:payment_method).to_s
    return 'Wallet' if %w[wallet 8].include?(raw_value)
    %w[card 1 upi 2 bank_transfer 3 online 4 cashfree 6 cloudflare 7].include?(raw_value) ? 'Online Payment' : 'Cash on Delivery'
  end

  def wallet_used?
    wallet_amount_used.to_f > 0
  end

  def payment_status_display
    raw_value = read_attribute(:payment_status)
    return 'Unpaid' if raw_value.blank?

    case raw_value.to_s
    when 'unpaid', '0' then 'Unpaid'
    when 'paid', '1' then 'Paid'
    when 'partially_paid', '2' then 'Partially Paid'
    when 'refunded', '3' then 'Refunded'
    else 'Unpaid'
    end
  end

  # Method to provide booking_items_count functionality
  def booking_items_count
    booking_items.size
  end

  # Temporary method to handle missing booking_id column in orders table
  def order
    # TODO: Remove this method once booking_id column is added to orders table
    # Return nil for now to avoid association errors
    return nil
  end

  # Also define as a method to prevent Rails from trying to load association
  def order=(value)
    # Do nothing for now
  end

  # Find the associated invoice created by the consolidated invoice generation system
  def associated_invoice
    return @associated_invoice if defined?(@associated_invoice)

    # Look for invoice items that reference this booking by booking number in the description
    invoice_item = InvoiceItem.joins(:invoice)
                             .where('description LIKE ?', "%#{booking_number}%")
                             .first

    @associated_invoice = invoice_item&.invoice
  end

  # Check if this booking has an associated invoice (either BookingInvoice or regular Invoice)
  def has_invoice?
    booking_invoices.any? || associated_invoice.present?
  end

  # Get the invoice link for this booking (prioritize regular Invoice over BookingInvoice)
  def invoice_link_path
    if associated_invoice
      "/admin/invoices/#{associated_invoice.id}"
    elsif booking_invoices.any?
      "/admin/booking_invoices/#{booking_invoices.first.id}"
    else
      nil
    end
  end

  # Get the invoice number for display (prioritize regular Invoice over BookingInvoice)
  def display_invoice_number
    if associated_invoice
      associated_invoice.invoice_number
    elsif booking_invoices.any?
      booking_invoices.first.invoice_number
    else
      invoice_number # fallback to booking's own invoice_number field
    end
  end

  # Calculate final amount after discount
  def calculate_final_amount_after_discount
    # Calculate from subtotal + tax - discount (not from total_amount which may already include discount)
    base_amount = (subtotal || calculated_subtotal).to_f + (tax_amount || calculated_tax_amount).to_f
    discount_amt = discount_amount.to_f

    if discount_amt > 0
      self.final_amount_after_discount = base_amount - discount_amt
    else
      self.final_amount_after_discount = base_amount
    end
  end

  # Email notification methods
  def send_booking_confirmation_email
    return unless customer&.email.present?

    begin
      CustomerMailer.booking_confirmation(self).deliver_now
      Rails.logger.info "Booking confirmation email sent for booking ##{booking_number} to #{customer.email}"
    rescue => e
      Rails.logger.error "Failed to send booking confirmation email for booking ##{booking_number}: #{e.message}"
      # Don't fail the booking process if email fails
    end
  end

  def send_booking_confirmation_email_async
    return unless customer&.email.present?

    begin
      CustomerMailer.booking_confirmation(self).deliver_later
      Rails.logger.info "Booking confirmation email queued for booking ##{booking_number} to #{customer.email}"
    rescue => e
      Rails.logger.error "Failed to queue booking confirmation email for booking ##{booking_number}: #{e.message}"
    end
  end

  def generate_and_send_completion_notification
    return unless customer&.email.present?

    begin
      # Generate invoice if not already generated
      generate_quick_invoice! unless invoice_number.present? && Invoice.exists?(invoice_number: invoice_number)

      # Ensure any associated invoice has a share token for public access
      if associated_invoice && !associated_invoice.share_token.present?
        associated_invoice.generate_share_token!
      end

      # Send completion email with invoice
      send_booking_confirmation_email
      Rails.logger.info "Booking completion notification sent for booking ##{booking_number} to #{customer.email}"
    rescue => e
      Rails.logger.error "Failed to send booking completion notification for booking ##{booking_number}: #{e.message}"
    end
  end


  private

  def ensure_total_amount_present
    if total_amount.blank? || total_amount <= 0
      errors.add(:base, "Please add at least one item to the booking")
    end
  end

  def convert_to_words(number)
    return "Zero" if number == 0

    ones = %w[Zero One Two Three Four Five Six Seven Eight Nine Ten Eleven Twelve Thirteen Fourteen Fifteen Sixteen Seventeen Eighteen Nineteen]
    tens = %w[Zero Ten Twenty Thirty Forty Fifty Sixty Seventy Eighty Ninety]

    result = []

    # Handle thousands
    if number >= 1000
      thousands = number / 1000
      if thousands >= 100
        result << ones[thousands / 100]
        result << "Hundred"
        thousands %= 100
      end

      if thousands >= 20
        result << tens[thousands / 10]
        thousands %= 10
      end

      if thousands > 0
        result << ones[thousands]
      end

      result << "Thousand"
      number %= 1000
    end

    # Handle hundreds
    if number >= 100
      result << ones[number / 100]
      result << "Hundred"
      number %= 100
    end

    # Handle tens and ones
    if number >= 20
      result << tens[number / 10]
      number %= 10
    end

    if number > 0
      result << ones[number]
    end

    result.join(" ")
  end

  def allocate_franchise_inventory
    insufficient_items = []

    booking_items.each do |item|
      next unless item.product_id.present? && item.quantity.to_f.positive?

      available = FranchiseInventory.balance_for(franchise, item.product)
      if available < item.quantity
        insufficient_items << { product: item.product.name, available: available, requested: item.quantity }
      end
    end

    if insufficient_items.any?
      # status_previously_was is nil when this runs from after_create (the
      # booking was created directly in a stock-consuming status, with no
      # prior status to revert to) — fall back to 'draft' instead of writing
      # a NULL status column.
      update_column(:status, status_previously_was || 'draft')
      errors.add(:status, "Insufficient franchise inventory: #{insufficient_items.map { |i|
        "#{i[:product]} (need #{i[:requested]}, have #{i[:available]})"
      }.join(', ')}")
      return false
    end

    booking_items.each do |item|
      next unless item.product_id.present? && item.quantity.to_f.positive?

      FranchiseInventory.consume_stock!(
        franchise, item.product,
        item.quantity,
        reference_type: 'franchise_booking',
        reference_id: id,
        notes: "Franchise Booking ##{booking_number}"
      )
    end

    Rails.logger.info "Franchise inventory allocated successfully for booking ##{booking_number}"
  rescue => e
    Rails.logger.error "Error allocating franchise inventory for booking ##{booking_number}: #{e.message}"
  end

  # Statuses from "confirmed" onward in the booking lifecycle (see
  # next_possible_statuses) — reaching any of these for the first time is
  # what should trigger franchise-ledger inventory allocation, whether that
  # happens via a status-changing update or by being created directly in
  # that status (e.g. a franchise walk-in sale whose form defaults status to
  # "completed" on create, so it never passes through an update where status
  # changes — allocate_franchise_inventory used to never run for these).
  STOCK_CONSUMING_STATUSES = %w[confirmed processing packed shipped out_for_delivery delivered completed].freeze

  def allocate_inventory
    if SystemSetting.stock_allocation_at_delivery_enabled?
      allocate_inventory_at_delivery
    else
      allocate_inventory_immediately
    end
  end

  def allocate_inventory_immediately
    # Franchise self-service bookings sell from the franchise's own
    # inventory ledger (credited via wholesale bookings), not central stock.
    if booked_by == 'franchise' && franchise_id.present? && SystemSetting.franchise_commission_enabled? &&
       STOCK_CONSUMING_STATUSES.include?(status) && !STOCK_CONSUMING_STATUSES.include?(status_previously_was)
      allocate_franchise_inventory
      return
    end

    # Only allocate central inventory when order is confirmed. This stays a
    # strict "confirmed" transition (not the broader STOCK_CONSUMING_STATUSES
    # check above) — non-franchise bookings created directly in a later
    # status (e.g. "completed") already had their stock reduced by
    # BookingItem#reduce_product_stock at creation, so running this on create
    # too would double-deduct the same stock_batches rows.
    if status == 'confirmed' && status_previously_was != 'confirmed'
      # skip_stock_check bookings (franchise/mobile/affiliate, and admin
      # approving a franchise stock request) already had their stock reduced
      # — possibly negative — by BookingItem#reduce_product_stock at
      # creation. Running InventoryService's own availability check here
      # would either double-deduct the same stock_batches rows on top of
      # that, or block/revert the status this booking is being confirmed
      # into, so skip it entirely for these bookings (no SaleItem records
      # either, same as the franchise-ledger path above).
      perform_central_stock_allocation! unless skip_stock_check
    end

    # Free up inventory when order is cancelled or returned
    if %w[cancelled returned].include?(status) && !%w[cancelled returned].include?(status_previously_was)
      begin
        release_allocated_inventory
      rescue => e
        Rails.logger.error "Error releasing inventory for booking ##{booking_number}: #{e.message}"
      end
    end
  end

  # "Stock Allocation at Delivery" mode (SystemSetting.stock_allocation_at_delivery_enabled?):
  # BookingItem no longer touches stock at all (see BookingItem#reduce_product_stock),
  # so nothing is deducted until the booking is actually fulfilled:
  #   - handed to a franchise for delivery: consume_franchise_stock! deducts
  #     from that franchise's ledger at assignment time (see Admin::BookingsController#update_stage) —
  #     this method just has to stay out of its way (delivery_franchise_id present).
  #   - a franchise's own walk-in/self-service sale (booked_by == 'franchise'):
  #     the "delivery" and the sale are the same moment, so it deducts from
  #     their own FranchiseInventory the first time the booking reaches
  #     delivered/completed (often immediately on create, for a walk-in).
  #   - everything else (admin/customer/mobile/affiliate bookings not handed
  #     to a franchise): deducted from central inventory the first time the
  #     booking reaches delivered/completed — normally via the "Deliver from
  #     Admin" button on manage_stage, but any path that sets that status works.
  # stock_allocated_at makes each of these a one-time event per booking.
  def allocate_inventory_at_delivery
    if %w[cancelled returned].include?(status) && !%w[cancelled returned].include?(status_previously_was)
      begin
        release_allocated_inventory
      rescue => e
        Rails.logger.error "Error releasing inventory for booking ##{booking_number}: #{e.message}"
      end
      return
    end

    return if stock_allocated_at.present?
    return unless %w[delivered completed].include?(status) && !%w[delivered completed].include?(status_previously_was)
    return if delivery_franchise_id.present?

    if booked_by == 'franchise' && franchise_id.present?
      result = allocate_franchise_inventory
      update_column(:stock_allocated_at, Time.current) unless result == false
    else
      update_column(:stock_allocated_at, Time.current) if perform_central_stock_allocation!
    end
  end

  # Central inventory: FIFO-allocates each booking_item and mirrors the
  # deduction into a SaleItem (profit tracking, and what release_allocated_inventory
  # restores from on cancel/return). Reverts the status change and adds a
  # validation error if any item can't be fully covered. Shared by the
  # immediate ("confirmed") and deferred ("delivered"/"completed") allocation
  # paths above — same mechanics, just triggered at a different status.
  def perform_central_stock_allocation!
    inventory_service = InventoryService.new

    items = booking_items.map { |item| { product_id: item.product_id, quantity: item.quantity } }

    insufficient_items = []
    allocation_data = []

    items.each do |item|
      availability = inventory_service.check_availability(item[:product_id], item[:quantity])
      if availability[:available]
        allocation_data << inventory_service.allocate_stock(item[:product_id], item[:quantity])
      else
        insufficient_items << {
          product: Product.find(item[:product_id]).name,
          available: availability[:available_stock],
          requested: item[:quantity],
          shortage: availability[:shortage]
        }
      end
    end

    if insufficient_items.any?
      update_column(:status, status_previously_was) if status_previously_was.present?
      errors.add(:status, "Insufficient inventory: #{insufficient_items.map { |item|
        "#{item[:product]} (need #{item[:requested]}, have #{item[:available]})"
      }.join(', ')}")
      return false
    end

    allocation_data.flatten.each do |allocation|
      inventory_service.reduce_stock([allocation])

      SaleItem.create!(
        booking: self,
        product: allocation[:batch].product,
        stock_batch: allocation[:batch],
        quantity: allocation[:quantity],
        selling_price: allocation[:selling_price],
        purchase_price: allocation[:purchase_price]
      )
    end

    Rails.logger.info "Inventory allocated successfully for booking ##{booking_number}"
    true
  rescue InventoryService::InsufficientStockError => e
    update_column(:status, status_previously_was) if status_previously_was.present?
    errors.add(:status, "Inventory allocation failed: #{e.message}")
    false
  rescue => e
    Rails.logger.error "Error allocating inventory for booking ##{booking_number}: #{e.message}"
    false
  end

  def release_allocated_inventory
    # Find all sale items for this booking and restore the stock
    SaleItem.where(booking: self).find_each do |sale_item|
      stock_batch = sale_item.stock_batch
      product = sale_item.product

      if stock_batch
        # Restore the quantity to the batch
        stock_batch.quantity_remaining += sale_item.quantity
        stock_batch.status = 'active' if stock_batch.exhausted? && stock_batch.quantity_remaining > 0
        stock_batch.save!

        Rails.logger.info "Restored #{sale_item.quantity} units to batch #{stock_batch.batch_number}"

        # Update product stock for backward compatibility
        if product
          product.update_column(:stock, product.total_batch_stock)
        end
      end

      # Mark the sale item as refunded/returned
      sale_item.destroy
    end
  end

  public

  # Cashfree Payment Methods
  def self.generate_cashfree_order_id
    "MKS_#{Time.current.strftime('%Y%m%d%H%M%S')}_#{SecureRandom.hex(4).upcase}"
  end

  def mark_payment_initiated!(gateway = 'cashfree')
    update!(
      payment_gateway: gateway,
      payment_initiated_at: Time.current,
      payment_status: 'unpaid'
    )
  end

  def mark_payment_completed!(payment_details = {})
    # A pre-booking still needs admin approval even once payment clears —
    # see pending_pre_booking_approval? — so it stays at
    # ordered_and_delivery_pending instead of jumping straight to confirmed.
    post_payment_status = is_pre_booking? ? 'ordered_and_delivery_pending' : 'confirmed'

    update!(
      payment_status: 'paid',
      payment_completed_at: Time.current,
      cashfree_payment_id: payment_details[:cf_payment_id],
      payment_method: payment_details[:payment_method] || 'cashfree',
      gateway_response: payment_details.to_json,
      status: post_payment_status
    )

    # A still-pending pre-booking isn't confirmed yet — mark_as_confirmed!
    # sends the confirmation email and generate_invoice_after_payment isn't
    # meaningful until the admin approves it, so skip both here and let
    # the approval step (Admin::BookingsController#approve_pre_booking) do it.
    return if pending_pre_booking_approval?

    # Send booking confirmation email when payment is completed
    send_booking_confirmation_email

    # Generate invoice automatically after payment completion
    generate_invoice_after_payment
  end

  def mark_payment_failed!(failure_reason = nil)
    response_data = { failure_reason: failure_reason, failed_at: Time.current }
    update!(
      payment_status: 'unpaid',
      gateway_response: response_data.to_json
    )
  end

  def can_initiate_payment?
    draft? && total_amount.present? && total_amount > 0 && customer.present?
  end

  def payment_pending?
    payment_initiated_at.present? && payment_completed_at.blank? && payment_status_unpaid?
  end

  def payment_successful?
    payment_status_paid? && cashfree_payment_id.present?
  end

  def gateway_response_hash
    return {} if gateway_response.blank?
    JSON.parse(gateway_response)
  rescue JSON::ParserError
    {}
  end

  def generate_invoice_after_payment
    # Check if invoice already exists
    return if booking_invoices.exists?

    begin
      # Create invoice for the booking using existing method
      create_booking_invoice_record

      Rails.logger.info "📄 Auto-generated invoice for booking ##{booking_number}"

      booking_invoices.first
    rescue => e
      Rails.logger.error "❌ Failed to auto-generate invoice for booking ##{booking_number}: #{e.message}"
      nil
    end
  end

  # Generate a proper Invoice record (with InvoiceItems) for this booking.
  # The invoice's payment_status mirrors the booking's payment_status (paid -> fully_paid,
  # otherwise unpaid). Sets invoice_generated=true and invoice_number on the booking so
  # the admin UI recognises the booking as invoiced. Returns the Invoice on success, nil on failure.
  def generate_quick_invoice!
    return nil if invoice_number.present? && Invoice.exists?(invoice_number: invoice_number)
    return nil if booking_items.empty?

    invoice = Invoice.new(
      customer: customer,
      invoice_date: Date.current,
      due_date: Date.current + 30.days,
      status: :sent,
      payment_status: payment_status_paid? ? :fully_paid : :unpaid,
      paid_at: payment_status_paid? ? Time.current : nil,
      quick_invoice: true,
      delivery_charge: shipping_charges.to_f
    )

    invoice_total = 0

    booking_items.includes(:product).each do |item|
      product = item.product
      next unless product

      unit_price = if product.gst_enabled? && product.gst_percentage.present?
        product.calculate_base_price || item.price
      else
        item.price || product.selling_price
      end

      if discount_amount.to_f > 0 && total_amount.to_f > 0
        unit_price = unit_price * (1 - discount_amount.to_f / total_amount.to_f)
      end

      item_total = item.quantity * unit_price
      invoice_total += item_total

      invoice.invoice_items.build(
        description: "#{product.name} - Booking ##{booking_number} (#{booking_date.strftime('%d %b %Y')})",
        quantity: item.quantity,
        unit_price: unit_price,
        total_amount: item_total,
        product: product
      )
    end

    invoice.total_amount = invoice_total

    if invoice.save
      # total_amount may be recalculated by Invoice's own before_validation
      # callbacks, so paid_amount must be set from the final persisted total,
      # not the pre-save estimate above.
      invoice.update_column(:paid_amount, invoice.total_amount) if payment_status_paid?

      update_columns(
        invoice_generated: true,
        invoice_number: invoice.invoice_number,
        quick_invoice: true
      )
      Rails.logger.info "Invoice ##{invoice.invoice_number} generated for booking ##{booking_number}"
      invoice
    else
      Rails.logger.error "Failed to generate invoice for booking ##{booking_number}: #{invoice.errors.full_messages.join(', ')}"
      nil
    end
  rescue => e
    Rails.logger.error "Error generating invoice for booking ##{booking_number}: #{e.message}"
    nil
  end

  private

end
