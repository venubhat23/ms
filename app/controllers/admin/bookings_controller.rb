class Admin::BookingsController < Admin::ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :edit, :update, :destroy, :generate_invoice, :invoice, :convert_to_order, :update_status, :cancel_order, :mark_delivered, :mark_completed, :mark_fully_paid, :manage_stage, :update_stage]

  LIST_STATE_PARAMS = %i[page search status date_from date_to customer_id b2b booked_by affiliate_id category_id].freeze

  def index
    # Base scope (no includes — used for lightweight stat counting only)
    base_scope = current_user.franchise? ? Booking.where(user_id: current_user.id) : Booking.all
    franchise_scope_key = current_user.franchise? ? "franchise_#{current_user.id}" : 'all'

    # Status counts only depend on franchise scope, not on the listing filters
    # below, so they're cached separately under a coarser key — a search/date/
    # category filter change shouldn't force a re-count of every status.
    status_counts_cache_key = "admin_bookings/status_counts/#{franchise_scope_key}"
    status_counts_cached = Rails.cache.read(status_counts_cache_key)

    # Single GROUP BY replaces 6 separate COUNT queries fired in the view.
    # Fired async (separate pooled connection) so its round trip overlaps
    # with the paginated listing query below instead of stacking after it —
    # the DB is remote, so every query round trip is ~200-400ms regardless
    # of complexity. Only kicked off on a cache miss.
    status_counts_promise = base_scope.group(:status).async_count unless status_counts_cached

    # Paginated listing with eager-loaded associations
    # user: :franchise avoids N+1 when booking.user.franchise.name is rendered
    # booking_items is intentionally excluded: the view only calls booking.booking_items.size
    # (item count), which reads the booking_items_count counter cache instead of
    # preloading every item row for every booking on the page.
    # delivery_person avoids N+1 when booking.delivery_person.full_name is rendered
    listing_includes = [:customer, { user: :franchise }, :store, :booking_invoices, :delivery_person]
    listing_includes << :franchise unless current_user.franchise?

    @bookings = base_scope.recent.includes(*listing_includes)

    if params[:search].present?
      @bookings = @bookings.where(
        "booking_number LIKE ? OR customer_name LIKE ? OR customer_email LIKE ? OR customer_phone LIKE ?",
        "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%"
      )
    end

    if params[:status].present? && params[:status].strip != ''
      # The "Processing" and "Shipped" stat tiles above roll up multiple
      # statuses into one count (see index.html.erb), so their matching
      # dropdown filters pass a comma-separated list here to keep the
      # filtered result count consistent with the tile it corresponds to.
      @bookings = @bookings.where(status: params[:status].split(','))
    end

    if params[:date_from].present? && params[:date_to].present?
      @bookings = @bookings.where(created_at: params[:date_from]..params[:date_to])
    end

    if params[:customer_id].present? && params[:customer_id].strip != ''
      @bookings = @bookings.where(customer_id: params[:customer_id])
    end

    if params[:b2b].present? && params[:b2b] == '1'
      @bookings = @bookings.where(is_b2b: true)
    end

    if params[:booked_by].present? && params[:booked_by].strip != ''
      @bookings = @bookings.where(booked_by: params[:booked_by])
    end

    if params[:affiliate_id].present? && params[:affiliate_id].strip != ''
      @bookings = @bookings.where(affiliate_id: params[:affiliate_id])
    end

    if params[:category_id].present? && params[:category_id].strip != ''
      @bookings = @bookings.joins(booking_items: :product).where(products: { category_id: params[:category_id] }).distinct
    end

    @categories = Rails.cache.fetch('admin_bookings/filter_categories', expires_in: 5.minutes) do
      Category.where(status: true).order(:display_order, :name).to_a
    end
    @affiliates = Rails.cache.fetch('admin_bookings/filter_affiliates', expires_in: 5.minutes) do
      Affiliate.where(status: true).order(:first_name, :last_name).to_a
    end

    @per_page = Rails.cache.fetch('system_setting/default_pagination_per_page', expires_in: 5.minutes) do
      SystemSetting.default_pagination_per_page
    end

    # Full listing result (records + total_count) cached per exact filter/page/
    # franchise combination — the DB round trip is the expensive part here, not
    # the query itself, so a cached hit skips the connection entirely. Kept
    # short (1 min) since bookings are actively created/updated by staff.
    filters_key = LIST_STATE_PARAMS.map { |p| "#{p}=#{params[p]}" }.join('&')
    listing_cache_key = "admin_bookings/index_listing/#{franchise_scope_key}/#{filters_key}/per=#{@per_page}"
    cached_listing = Rails.cache.read(listing_cache_key)

    @bookings = @bookings.page(params[:page]).per(@per_page)
    # Kick off the listing query on its own pooled connection now, before we
    # block on the status_counts promise below, so both round trips overlap.
    @bookings.load_async unless cached_listing

    @status_counts = status_counts_cached || begin
      value = status_counts_promise.value
      Rails.cache.write(status_counts_cache_key, value, expires_in: 3.minutes)
      value
    end

    if cached_listing
      # .page(params[:page]), not .page(1): the cached array is already just this
      # page's slice, but Kaminari still needs the real page number to compute
      # the correct offset_value/current_page for the "Showing X-Y of Z" display
      # and pagination widget. PaginatableArray only re-slices when total_count
      # <= array.length, so passing the true page here does NOT re-slice away
      # our already-correct cached records — it just fixes the metadata.
      @bookings = Kaminari.paginate_array(cached_listing[:records], total_count: cached_listing[:total_count])
                           .page(params[:page]).per(@per_page)
    else
      # Reuse the status_counts GROUP BY (already fetched above) instead of firing a
      # second COUNT(*) round trip when no filter narrows the result set. Kaminari
      # memoizes total_count in this ivar on first access, so pre-seeding it here
      # short-circuits every later .total_count call (result count, pagination widget).
      @bookings.instance_variable_set(:@total_count, @status_counts.values.sum) unless filters_applied?

      records = @bookings.to_a
      total_count = @bookings.total_count
      Rails.cache.write(listing_cache_key, { records: records, total_count: total_count }, expires_in: 1.minute)
      @bookings = Kaminari.paginate_array(records, total_count: total_count).page(params[:page]).per(@per_page)
    end

    # Pre-populate memoized @associated_invoice on each loaded booking to nil so
    # has_invoice? / invoice_link_path / display_invoice_number never fire a
    # per-booking LIKE query; the index only needs booking_invoices (eager-loaded above).
    @bookings.each { |b| b.instance_variable_set(:@associated_invoice, nil) }

    @customers = Rails.cache.fetch('admin_bookings/filter_customers', expires_in: 2.minutes) do
      Customer.select(:id, :first_name, :middle_name, :last_name, :email, :mobile)
              .order(:first_name, :last_name).to_a
    end
  end

  def new
    @booking = Booking.new
    @booking.booking_items.build

    @products = Product.active
                       .includes(:category, :product_variants, image_attachment: :blob)
                       .joins("LEFT JOIN stock_batches ON stock_batches.product_id = products.id AND stock_batches.status = 'active' AND stock_batches.quantity_remaining > 0 AND stock_batches.store_id IS NULL")
                       .select(
                         "products.*,
                          COALESCE(SUM(stock_batches.quantity_remaining), 0) as cached_stock"
                       )
                       .group("products.id")
                       .order(Arel.sql("CASE WHEN COALESCE(SUM(stock_batches.quantity_remaining), 0) > 0 THEN 0 ELSE 1 END ASC, products.name ASC"))

    @customers = Customer.select(:id, :first_name, :middle_name, :last_name, :email, :mobile)
                        .order(:first_name, :last_name)
    @categories = Category.where(status: true).order(:display_order, :name)
    @stores = Store.active.order(:name)

    @franchise_commission_enabled = SystemSetting.franchise_commission_enabled?
    # status and commission_percentage are included even though the view doesn't need them:
    # Franchise#set_defaults (after_initialize) reads both on every instantiation, and a
    # narrower select raises ActiveModel::MissingAttributeError.
    @franchises = @franchise_commission_enabled ? Franchise.active.select(:id, :name, :mobile, :email, :address, :status, :commission_percentage) : Franchise.none
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user

    # Auto-set franchise_id for franchise users
    if current_user.franchise?
      @booking.franchise_id = current_user.franchise&.id
      @booking.booked_by = 'franchise'
    else
      @booking.booked_by = 'admin'
    end

    # Only set booking_date to current time if not provided in params
    @booking.booking_date = @booking.booking_date.present? ? @booking.booking_date : Time.current

    # Clean and validate discount amount
    discount_value = params[:booking][:discount_amount] if params[:booking]
    Rails.logger.info "Processing discount value: #{discount_value.inspect}"

    if discount_value.present?
      # Clean the discount value - remove all whitespace, newlines, etc.
      cleaned_discount = discount_value.to_s.gsub(/\s+/, '').strip
      discount_amount = cleaned_discount.to_f
      @booking.discount_amount = discount_amount > 0 ? discount_amount : 0
      Rails.logger.info "Applied discount: #{@booking.discount_amount}"
    else
      @booking.discount_amount = 0
    end

    # Wholesale "Franchise Booking" discount — recomputed server-side (not
    # trusted from the client) and folded into discount_amount so the
    # standard total calculation picks it up.
    if @booking.franchise_id.present? && SystemSetting.franchise_commission_enabled?
      # Run the real totals calculation now (it also runs again automatically
      # before save) so subtotal/tax_amount reflect the actual GST-exclusive
      # split from booking_items, instead of the GST-inclusive fallback that
      # calculated_subtotal uses for a still-unsaved booking.
      @booking.calculate_totals
      bill_total = (@booking.subtotal.to_f + @booking.tax_amount.to_f).round(2)
      franchise_discount_value = @booking.franchise_discount_value.to_f

      franchise_discount = case @booking.franchise_discount_type
                            when 'percentage'
                              if franchise_discount_value > 100
                                @booking.errors.add(:franchise_discount_value, "cannot exceed 100% for a percentage discount")
                              end
                              (bill_total * franchise_discount_value / 100.0).round(2)
                            when 'fixed'
                              franchise_discount_value.round(2)
                            else
                              0
                            end

      if franchise_discount > bill_total
        @booking.errors.add(:franchise_discount_value, "cannot exceed the bill total (₹#{'%.2f' % bill_total})")
      end

      if @booking.errors.any?
        @products = Product.active.includes(:category, :product_variants, image_attachment: :blob)
        @customers = Customer.select(:id, :first_name, :middle_name, :last_name, :email, :mobile).order(:first_name, :last_name)
        @categories = Category.where(status: true).order(:display_order, :name)
        @stores = Store.active.order(:name)
        @franchise_commission_enabled = SystemSetting.franchise_commission_enabled?
        @franchises = @franchise_commission_enabled ? Franchise.active.select(:id, :name, :mobile, :email, :address) : Franchise.none
        flash.now[:alert] = @booking.errors.full_messages.join(', ')
        render :new, status: :unprocessable_entity
        return
      end

      @booking.franchise_discount_amount = franchise_discount
      @booking.discount_amount = @booking.discount_amount.to_f + franchise_discount
    else
      @booking.franchise_id = nil
    end

    # Store payment status value for after save (to avoid enum conflicts during validation)
    @payment_status_from_form = params[:booking][:payment_status]
    Rails.logger.info "Payment status from form: #{@payment_status_from_form}"

    # Validate stock availability before saving
    unless validate_stock_availability(@booking)
      @products = Product.active.includes(:category, :product_variants, image_attachment: :blob)
      @customers = Customer.select(:id, :first_name, :middle_name, :last_name, :email, :mobile).order(:first_name, :last_name)
      @categories = Category.where(status: true).order(:display_order, :name)
      @stores = Store.active.order(:name)
      @franchise_commission_enabled = SystemSetting.franchise_commission_enabled?
      @franchises = @franchise_commission_enabled ? Franchise.active.select(:id, :name, :mobile, :email, :address) : Franchise.none
      render :new, status: :unprocessable_entity
      return
    end

    if @booking.save
      # Calculate totals after saving
      @booking.calculate_totals

      # Set payment status after initial save (to avoid enum conflicts)
      if @payment_status_from_form == 'paid'
        @booking.payment_status = :paid
      elsif @payment_status_from_form == 'partially_paid'
        @booking.payment_status = :partially_paid
      else
        @booking.payment_status = :unpaid
      end

      # Save again to persist the calculated totals and payment status
      @booking.save!

      # Log the calculated totals for debugging
      Rails.logger.info "Booking totals - Subtotal: #{@booking.subtotal}, Tax: #{@booking.tax_amount}, Discount: #{@booking.discount_amount}, Total: #{@booking.total_amount}"
      Rails.logger.info "Final payment status after save: #{@booking.payment_status}"

      # Generate the invoice immediately, regardless of payment status —
      # the invoice's own payment_status mirrors the booking's (paid vs unpaid).
      invoice_notice = ""
      begin
        invoice = generate_immediate_invoice_for_booking(@booking)
        if invoice
          invoice_notice = " Invoice ##{invoice.invoice_number} generated (#{@booking.payment_status_paid? ? 'paid' : 'unpaid'})."
        end
      rescue => e
        Rails.logger.error "Failed to generate immediate invoice for booking ##{@booking.id}: #{e.message}"
        invoice_notice = " Note: Invoice generation failed."
      end

      # Convert to order if payment is received
      if @booking.payment_status_paid? && params[:create_order] == '1'
        @booking.convert_to_order!
      end

      redirect_to admin_booking_path(@booking), notice: "Booking created successfully!#{invoice_notice}"
    else
      Rails.logger.error "Booking creation failed: #{@booking.errors.full_messages.join(', ')}"
      Rails.logger.error "Booking items errors: #{@booking.booking_items.map(&:errors).map(&:full_messages).flatten.join(', ')}"

      @products = Product.active.includes(:category, :product_variants, image_attachment: :blob)
      @customers = Customer.select(:id, :first_name, :middle_name, :last_name, :email, :mobile).order(:first_name, :last_name)
      @categories = Category.where(status: true).order(:display_order, :name)
      @stores = Store.active.order(:name)
      @franchise_commission_enabled = SystemSetting.franchise_commission_enabled?
      @franchises = @franchise_commission_enabled ? Franchise.active.select(:id, :name, :mobile, :email, :address) : Franchise.none
      flash.now[:alert] = @booking.errors.full_messages.join(', ')
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @list_state = list_state_params
    @booking_items = @booking.booking_items.includes(product: [:category, image_attachment: :blob, additional_images_attachments: :blob])
  end

  def edit
    @list_state = list_state_params
    @products = Product.active
                       .select(:id, :name, :price, :gst_enabled, :gst_percentage,
                               :cgst_percentage, :sgst_percentage, :igst_percentage,
                               :unit_type, :hsn_code)
                       .includes(:product_variants)
                       .order(:name)
  end

  def update
    @list_state = list_state_params

    unless validate_stock_availability(@booking, is_update: true)
      @products = Product.active
                         .select(:id, :name, :price, :gst_enabled, :gst_percentage,
                                 :cgst_percentage, :sgst_percentage, :igst_percentage,
                                 :unit_type, :hsn_code)
                         .includes(:product_variants)
                         .order(:name)
      render :edit, status: :unprocessable_entity
      return
    end

    if @booking.update(booking_params)
      redirect_to admin_bookings_path(@list_state), notice: 'Booking updated successfully!'
    else
      @products = Product.active
                         .select(:id, :name, :price, :gst_enabled, :gst_percentage,
                                 :cgst_percentage, :sgst_percentage, :igst_percentage,
                                 :unit_type, :hsn_code)
                         .includes(:product_variants)
                         .order(:name)
      render :edit
    end
  end

  def destroy
    begin
      # Check for associated orders (if enabled)
      if @booking.respond_to?(:order) && @booking.order.present?
        redirect_to admin_bookings_path(list_state_params), alert: 'Cannot delete booking with associated order.'
        return
      end

      # Store booking info for confirmation message
      booking_number = @booking.booking_number
      customer_name = @booking.customer&.display_name || 'Unknown'

      # Log the deletion for audit purposes
      Rails.logger.info "Deleting booking #{booking_number} (ID: #{@booking.id}) for customer #{customer_name} by user #{current_user&.email || 'Unknown'}"

      # Also clean up any regular Invoice records that might reference this booking
      if defined?(Invoice)
        related_invoices = Invoice.where("invoice_items.description LIKE ?", "%#{booking_number}%")
                                  .joins(:invoice_items)
        if related_invoices.any?
          Rails.logger.info "Found #{related_invoices.count} invoice(s) with items referencing booking #{booking_number}"
          related_invoices.each do |invoice|
            # Only delete invoice items that reference this booking
            invoice.invoice_items.where("description LIKE ?", "%#{booking_number}%").destroy_all
            # Delete the entire invoice if it has no items left
            if invoice.invoice_items.count == 0
              Rails.logger.info "Deleting empty invoice #{invoice.invoice_number} after removing booking items"
              invoice.destroy
            end
          end
        end
      end

      # Delete the booking (will cascade delete all associated records due to dependent: :destroy)
      @booking.destroy!

      # Log successful deletion
      Rails.logger.info "Successfully deleted booking #{booking_number} and all associated records"

      redirect_to admin_bookings_path(list_state_params), notice: "Booking #{booking_number} for #{customer_name} has been permanently deleted along with all associated records."
    rescue => e
      # Log the error
      Rails.logger.error "Failed to delete booking #{@booking.booking_number} (ID: #{@booking.id}): #{e.message}"
      Rails.logger.error e.backtrace.join("\n")

      # Provide user-friendly error message
      redirect_to admin_bookings_path(list_state_params), alert: "Failed to delete booking: #{e.message}. Please try again or contact support if the issue persists."
    end
  end

  def generate_invoice
    if @booking.has_invoice?
      redirect_to admin_booking_path(@booking, list_state_params), notice: 'Invoice already generated.'
      return
    end

    invoice = generate_immediate_invoice_for_booking(@booking)
    if invoice
      redirect_to admin_booking_path(@booking, list_state_params), notice: "Invoice ##{invoice.invoice_number} generated successfully."
    else
      redirect_to admin_booking_path(@booking, list_state_params), alert: 'Failed to generate invoice. Please check the booking has items and try again.'
    end
  end

  def invoice
    @booking_items = @booking.booking_items.includes(:product)
    respond_to do |format|
      format.html { render template: 'admin/bookings/invoice', layout: 'invoice' }
      format.pdf do
        pdf = WickedPdf.new.pdf_from_string(
          render_to_string('admin/bookings/invoice', formats: [:html], layout: 'invoice_pdf'),
          page_size: 'A4',
          margin: {
            top: '0.75in',
            bottom: '0.75in',
            left: '0.75in',
            right: '0.75in'
          },
          dpi: 300,
          encoding: 'UTF-8',
          disable_smart_shrinking: true,
          print_media_type: true,
          orientation: 'Portrait',
          header: {
            html: {
              content: render_to_string(partial: 'shared/pdf_header', formats: [:html])
            }
          },
          footer: {
            html: {
              content: render_to_string(partial: 'shared/pdf_footer', formats: [:html])
            }
          }
        )

        invoice_filename = "invoice-#{@booking.invoice_number || @booking.booking_number}-#{Date.current.strftime('%Y%m%d')}.pdf"

        send_data pdf,
                  filename: invoice_filename,
                  type: 'application/pdf',
                  disposition: 'attachment'
      end
    end
  end

  def convert_to_order
    if @booking.order.present?
      redirect_to admin_order_path(@booking.order), notice: 'Order already exists for this booking.'
    else
      order = @booking.convert_to_order!
      redirect_to admin_order_path(order), notice: 'Order created successfully!'
    end
  end

  # Status management actions
  def update_status
    new_status = params[:status]

    if @booking.next_possible_statuses.include?(new_status)
      case new_status
      when 'ordered_and_delivery_pending'
        @booking.update!(status: :ordered_and_delivery_pending)
        message = 'Booking moved to Ordered & Delivery Pending!'
      when 'confirmed'
        @booking.mark_as_confirmed!
        message = 'Booking confirmed successfully!'
      when 'processing'
        @booking.mark_as_processing!
        message = 'Order marked as processing!'
      when 'packed'
        @booking.mark_as_packed!
        message = 'Order packed successfully!'
      when 'shipped'
        @booking.mark_as_shipped!(params[:tracking_number])
        message = 'Order shipped successfully!'
      when 'out_for_delivery'
        @booking.mark_as_out_for_delivery!
        message = 'Order is out for delivery!'
      when 'delivered'
        @booking.mark_as_delivered!
        message = 'Order delivered and completed successfully!'
      when 'completed'
        @booking.mark_as_completed!
        message = 'Order completed!'
      else
        @booking.update!(status: new_status)
        message = "Status updated to #{new_status.humanize}!"
      end

      respond_to do |format|
        format.html {
          if params[:return_to] == 'index'
            redirect_to admin_bookings_path(list_state_params), notice: message
          else
            redirect_to admin_booking_path(@booking, list_state_params), notice: message
          end
        }
        format.json { render json: { success: true, message: message, new_status: @booking.status } }
      end
    else
      respond_to do |format|
        format.html { redirect_to admin_booking_path(@booking), alert: 'Invalid status transition!' }
        format.json { render json: { success: false, error: 'Invalid status transition!' } }
      end
    end
  end

  def cancel_order
    reason = params[:reason]
    @booking.cancel_order!(reason)
    redirect_to admin_booking_path(@booking, list_state_params), notice: 'Booking cancelled successfully!'
  end

  def mark_delivered
    @booking.mark_as_delivered!
    redirect_to admin_booking_path(@booking, list_state_params), notice: 'Order marked as delivered!'
  end

  def mark_completed
    @booking.mark_as_completed!
    redirect_to admin_booking_path(@booking, list_state_params), notice: 'Order marked as completed!'
  end

  def mark_fully_paid
    @booking.mark_as_fully_paid!
    redirect_to admin_booking_path(@booking, list_state_params), notice: 'Booking marked as fully paid!'
  end

  def stage_transition
    @target_stage = params[:target_stage]

    unless @target_stage.present?
      redirect_to admin_booking_path(@booking), alert: 'Target stage not specified'
      return
    end

    unless @booking.next_possible_statuses.include?(@target_stage) ||
           (@booking.can_return? && @target_stage == 'returned')
      redirect_to admin_booking_path(@booking), alert: 'Invalid stage transition'
      return
    end

    # Load delivery people for shipped stage
    @delivery_people = DeliveryPerson.where(status: true).order(:first_name, :last_name) if @target_stage == 'shipped'
  end

  def process_stage_transition
    @target_stage = params[:target_stage]

    unless @target_stage.present?
      redirect_to admin_booking_path(@booking), alert: 'Target stage not specified'
      return
    end

    # Build stage transition data
    transition_data = build_transition_data

    # Update booking with stage-specific fields and transition history
    update_booking_with_transition(transition_data)

    case @target_stage
    when 'confirmed'
      process_confirmed_transition
    when 'processing'
      process_processing_transition
    when 'packed'
      process_packed_transition
    when 'shipped'
      process_shipped_transition
    when 'out_for_delivery'
      process_out_for_delivery_transition
    when 'delivered'
      process_delivered_transition
    when 'cancelled'
      process_cancelled_transition
    when 'returned'
      process_returned_transition
    else
      process_general_transition
    end
  end

  # Real-time data endpoint
  def realtime_data
    # Single GROUP BY replaces 9 separate COUNT queries
    counts = Booking.group(:status).count

    stats = {
      draft: counts['draft'] || 0,
      pending: counts['ordered_and_delivery_pending'] || 0,
      processing: (counts['confirmed'] || 0) + (counts['processing'] || 0) + (counts['packed'] || 0),
      shipped: (counts['shipped'] || 0) + (counts['out_for_delivery'] || 0),
      delivered: (counts['delivered'] || 0) + (counts['completed'] || 0),
      issues: (counts['cancelled'] || 0) + (counts['returned'] || 0),
      total: counts.values.sum,
      today_bookings: Booking.where(created_at: Date.current.all_day).count,
      total_revenue: Booking.where(status: %w[completed delivered]).sum(:total_amount),
      last_updated: Time.current.strftime('%I:%M:%S %p')
    }

    # Get recent bookings (last 5) — booking_items_count counter cache avoids
    # preloading every item row (or a per-row COUNT) just to display a number
    recent_bookings = Booking.recent.limit(5).includes(:customer).map do |booking|
      {
        id: booking.id,
        booking_number: booking.booking_number,
        customer_name: booking.customer&.display_name || booking.customer_name,
        status: booking.status,
        status_color: booking.status_color,
        status_icon: booking.status_icon,
        total_amount: booking.total_amount,
        created_at: booking.created_at.strftime('%d %b %Y %I:%M %p'),
        items_count: booking.booking_items_count
      }
    end

    render json: {
      success: true,
      stats: stats,
      recent_bookings: recent_bookings
    }
  rescue => e
    render json: {
      success: false,
      error: e.message
    }
  end

  # AJAX endpoints
  def search_products
    stock_sq = StockBatch.where(status: 'active')
                         .select("product_id, SUM(quantity_remaining) AS total_stock")
                         .group(:product_id)

    @products = Product.active
                       .select("products.*, COALESCE(sq.total_stock, 0) AS cached_stock")
                       .joins("LEFT JOIN (#{stock_sq.to_sql}) sq ON sq.product_id = products.id")
                       .includes(image_attachment: :blob)
                       .where("products.name ILIKE ? OR products.sku ILIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
                       .limit(10)

    render json: @products.map { |p|
      {
        id: p.id,
        text: "#{p.name} - #{p.formatted_selling_price}",
        name: p.name,
        price: p.selling_price,
        stock: p.total_batch_stock, # Use batch stock for accuracy
        stock_status: p.stock_status_enhanced,
        stock_status_text: p.stock_status_text_enhanced,
        out_of_stock: p.out_of_stock?,
        low_stock: p.low_stock?,
        minimum_threshold: p.minimum_stock_threshold,
        image_url: p.main_image ? url_for(p.main_image) : nil
      }
    }
  end

  def search_customers
    @customers = Customer.where(
      "first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ? OR mobile ILIKE ?",
      "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%"
    ).limit(10)

    render json: @customers.map { |c|
      {
        id: c.id,
        text: "#{c.display_name} - #{c.mobile}",
        name: c.display_name,
        email: c.email,
        phone: c.mobile,
        address: c.address
      }
    }
  end

  # POST /admin/bookings/quick_create_customer
  #
  # Lets the booking form create a customer inline when a search turns up no
  # match, without leaving the booking in progress. Deliberately lighter than
  # Admin::CustomersController#create: no User login account, no password —
  # this just needs a bookable Customer record.
  def quick_create_customer
    customer = Customer.new(quick_customer_params)

    if customer.save
      render json: {
        success: true,
        customer: {
          id: customer.id,
          name: customer.display_name,
          mobile: customer.mobile,
          email: customer.email,
          address: customer.respond_to?(:address) ? customer.address : ''
        }
      }
    else
      render json: { success: false, errors: customer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def manage_stage
    # This will render the manage_stage.html.erb view
    @list_state = list_state_params
    @available_statuses = Booking.statuses.keys.map { |status| [status.humanize, status] }
    @next_stages = @booking.next_possible_statuses
  end

  def update_stage
    @list_state = list_state_params
    @target_stage = params[:target_stage] || params[:booking][:status]

    unless @target_stage.present?
      redirect_to manage_stage_admin_booking_path(@booking, list_state: @list_state), alert: "Please select a target stage."
      return
    end

    begin
      # Build transition data
      transition_data = build_stage_transition_data

      # Update booking with new status and transition data
      if update_booking_with_stage_transition(transition_data)
        success_notice = "Booking stage updated to #{@target_stage.humanize} successfully."
        if @target_stage == 'out_for_delivery' && transition_data[:delivery_mode] == 'franchise' && @booking.delivery_franchise.present?
          success_notice = "Franchise #{@booking.delivery_franchise.name} assigned and booking updated successfully."
        end
        redirect_to admin_bookings_path(@list_state), notice: success_notice
      else
        redirect_to manage_stage_admin_booking_path(@booking, list_state: @list_state), alert: "Failed to update stage: #{@booking.errors.full_messages.join(', ')}"
      end
    rescue => e
      Rails.logger.error "Error in update_stage: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      redirect_to manage_stage_admin_booking_path(@booking, list_state: @list_state), alert: "Failed to update stage: #{e.message}"
    end
  end

  private

  def filters_applied?
    %i[search status date_from date_to customer_id b2b booked_by affiliate_id category_id].any? do |key|
      params[key].present? && params[key].to_s.strip != ''
    end
  end

  # Read forward-carried list page/filter state from the nested `list_state`
  # param, never the top-level params (some actions, e.g. update_status,
  # use a top-level `status` param for their own purpose which would
  # otherwise collide with the list's `status` filter).
  def list_state_params
    params[:list_state]&.permit(*LIST_STATE_PARAMS)&.to_h || {}
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  # Build transition data from form parameters
  def build_transition_data
    transition_data = {
      from_stage: @booking.status,
      to_stage: @target_stage,
      timestamp: Time.current,
      user_id: current_user.id,
      user_name: current_user.full_name || current_user.email
    }

    # Add stage-specific data based on target stage
    case @target_stage
    when 'shipped'
      transition_data[:courier_service] = params[:courier_service]
      transition_data[:tracking_number] = params[:tracking_number]
      transition_data[:shipping_charges] = params[:shipping_charges]
      transition_data[:expected_delivery_date] = params[:expected_delivery_date]
    when 'processing'
      transition_data[:processing_team] = params[:processing_team]
      transition_data[:expected_completion_time] = params[:expected_completion_time]
      transition_data[:estimated_processing_time] = params[:estimated_processing_time]
    when 'packed'
      transition_data[:package_weight] = params[:package_weight]
      transition_data[:package_dimensions] = params[:package_dimensions]
      transition_data[:quality_status] = params[:quality_status]
    when 'delivered'
      transition_data[:delivery_person] = params[:delivery_person]
      transition_data[:delivery_contact] = params[:delivery_contact]
      transition_data[:delivered_to] = params[:delivered_to]
      transition_data[:delivery_time] = params[:delivery_time]
      transition_data[:customer_satisfaction] = params[:customer_satisfaction]
    when 'cancelled'
      transition_data[:cancellation_reason] = params[:cancellation_reason]
    when 'returned'
      transition_data[:return_reason] = params[:return_reason]
      transition_data[:return_condition] = params[:return_condition]
      transition_data[:refund_amount] = params[:refund_amount]
      transition_data[:refund_method] = params[:refund_method]
    end

    # Add transition notes
    transition_data[:transition_notes] = params[:transition_notes] if params[:transition_notes].present?

    transition_data
  end

  # Update booking with stage transition data
  def update_booking_with_transition(transition_data)
    # Get current stage history or initialize empty array
    current_history = @booking.stage_history.present? ? JSON.parse(@booking.stage_history) : []

    # Add new transition to history
    current_history << transition_data

    # Prepare update attributes
    update_attrs = {
      status: @target_stage,
      stage_history: current_history.to_json,
      stage_updated_at: Time.current,
      stage_updated_by: current_user.id,
      transition_notes: transition_data[:transition_notes]
    }

    # Add stage-specific fields to booking
    case @target_stage
    when 'shipped'
      update_attrs[:courier_service] = params[:courier_service] if params[:courier_service].present?
      update_attrs[:tracking_number] = params[:tracking_number] if params[:tracking_number].present?
      update_attrs[:shipping_charges] = params[:shipping_charges] if params[:shipping_charges].present?
      update_attrs[:expected_delivery_date] = params[:expected_delivery_date] if params[:expected_delivery_date].present?
    when 'processing'
      update_attrs[:processing_team] = params[:processing_team] if params[:processing_team].present?
      update_attrs[:expected_completion_time] = params[:expected_completion_time] if params[:expected_completion_time].present?
      update_attrs[:estimated_processing_time] = params[:estimated_processing_time] if params[:estimated_processing_time].present?
    when 'packed'
      update_attrs[:package_weight] = params[:package_weight] if params[:package_weight].present?
      update_attrs[:package_dimensions] = params[:package_dimensions] if params[:package_dimensions].present?
      update_attrs[:quality_status] = params[:quality_status] if params[:quality_status].present?
    when 'delivered'
      update_attrs[:delivery_person] = params[:delivery_person] if params[:delivery_person].present?
      update_attrs[:delivery_contact] = params[:delivery_contact] if params[:delivery_contact].present?
      update_attrs[:delivered_to] = params[:delivered_to] if params[:delivered_to].present?
      update_attrs[:delivery_time] = params[:delivery_time] if params[:delivery_time].present?
      update_attrs[:customer_satisfaction] = params[:customer_satisfaction] if params[:customer_satisfaction].present?
    when 'cancelled'
      update_attrs[:cancellation_reason] = params[:cancellation_reason] if params[:cancellation_reason].present?
    when 'returned'
      update_attrs[:return_reason] = params[:return_reason] if params[:return_reason].present?
      update_attrs[:return_condition] = params[:return_condition] if params[:return_condition].present?
      update_attrs[:refund_amount] = params[:refund_amount] if params[:refund_amount].present?
      update_attrs[:refund_method] = params[:refund_method] if params[:refund_method].present?
    end

    @booking.update!(update_attrs)
  rescue => e
    Rails.logger.error "Error updating booking with transition data: #{e.message}"
    raise e
  end

  def build_stage_transition_data
    transition_data = {
      from_stage: @booking.status,
      to_stage: @target_stage,
      timestamp: Time.current,
      user_id: current_user.id,
      user_name: current_user.try(:full_name) || current_user.email
    }

    # Add stage-specific data
    case @target_stage
    when 'shipped'
      transition_data[:courier_service] = params[:courier_service]
      transition_data[:tracking_number] = params[:tracking_number]
      transition_data[:shipping_charges] = params[:shipping_charges]
      transition_data[:expected_delivery_date] = params[:expected_delivery_date]
    when 'out_for_delivery'
      transition_data[:delivery_mode] = franchise_delivery_mode_requested? ? 'franchise' : 'delivery_person'
      if transition_data[:delivery_mode] == 'franchise'
        transition_data[:delivery_franchise_id] = params[:delivery_franchise_id]
      else
        transition_data[:delivery_person_id] = params[:delivery_person_id]
        transition_data[:delivery_person] = params[:delivery_person]
        transition_data[:delivery_contact] = params[:delivery_contact]
      end
    when 'delivered'
      transition_data[:delivery_person] = params[:delivery_person]
      transition_data[:delivery_time] = params[:delivery_time]
      transition_data[:customer_satisfaction] = params[:customer_satisfaction]
    when 'cancelled'
      transition_data[:cancellation_reason] = params[:cancellation_reason]
      transition_data[:refund_amount] = params[:refund_amount]
    when 'returned'
      transition_data[:return_reason] = params[:return_reason]
      transition_data[:refund_amount] = params[:refund_amount]
    end

    transition_data[:notes] = params[:transition_notes] if params[:transition_notes].present?
    transition_data
  end

  def update_booking_with_stage_transition(transition_data)
    @booking.status = @target_stage

    # Store transition-specific fields
    case @target_stage
    when 'shipped'
      @booking.tracking_number = transition_data[:tracking_number] if transition_data[:tracking_number].present?
      @booking.shipping_charges = transition_data[:shipping_charges] if transition_data[:shipping_charges].present?
      @booking.expected_delivery_date = transition_data[:expected_delivery_date] if transition_data[:expected_delivery_date].present?
      @booking.courier_service = transition_data[:courier_service] if transition_data[:courier_service].present?
    when 'delivered'
      @booking.delivery_time = transition_data[:delivery_time] if transition_data[:delivery_time].present?
      @booking.customer_satisfaction = transition_data[:customer_satisfaction] if transition_data[:customer_satisfaction].present?
      @booking.delivery_person = transition_data[:delivery_person] if transition_data[:delivery_person].present?
      @booking.delivered_to = transition_data[:delivered_to] if transition_data[:delivered_to].present?
    when 'cancelled'
      @booking.cancellation_reason = transition_data[:cancellation_reason] if transition_data[:cancellation_reason].present?
      @booking.refund_amount = transition_data[:refund_amount] if transition_data[:refund_amount].present?
    when 'returned'
      @booking.return_reason = transition_data[:return_reason] if transition_data[:return_reason].present?
      @booking.refund_amount = transition_data[:refund_amount] if transition_data[:refund_amount].present?
      @booking.return_condition = transition_data[:return_condition] if transition_data[:return_condition].present?
    when 'processing'
      @booking.processing_team = transition_data[:processing_team] if transition_data[:processing_team].present?
      @booking.estimated_processing_time = transition_data[:estimated_processing_time] if transition_data[:estimated_processing_time].present?
    when 'packed'
      @booking.package_weight = transition_data[:package_weight] if transition_data[:package_weight].present?
      @booking.package_dimensions = transition_data[:package_dimensions] if transition_data[:package_dimensions].present?
      @booking.quality_status = transition_data[:quality_status] if transition_data[:quality_status].present?
    when 'out_for_delivery'
      @booking.delivery_mode = transition_data[:delivery_mode] if transition_data[:delivery_mode].present?
      if transition_data[:delivery_mode] == 'franchise'
        @booking.delivery_franchise_id = transition_data[:delivery_franchise_id] if transition_data[:delivery_franchise_id].present?
      else
        @booking.delivery_person = transition_data[:delivery_person] if transition_data[:delivery_person].present?
        @booking.delivery_contact = transition_data[:delivery_contact] if transition_data[:delivery_contact].present?
        @booking.delivery_person_id = transition_data[:delivery_person_id] if transition_data[:delivery_person_id].present?
      end
    end

    # Update stage history - parse existing JSON and add new entry
    begin
      history = @booking.stage_history.present? ? JSON.parse(@booking.stage_history) : []
    rescue JSON::ParserError
      history = []
    end

    history << transition_data.stringify_keys
    @booking.stage_history = history.to_json
    @booking.stage_updated_at = Time.current
    @booking.stage_updated_by = current_user.id

    # Add notes if provided
    if transition_data[:notes].present?
      @booking.transition_notes = [@booking.transition_notes, transition_data[:notes]].compact.join("\n---\n")
    end

    @booking.save!
  rescue => e
    Rails.logger.error "Failed to update booking stage: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    raise e
  end

  def booking_params
    params.require(:booking).permit(
      :customer_id, :customer_name, :customer_email, :customer_phone,
      :payment_method, :payment_status, :discount_amount, :notes,
      :delivery_address, :cash_received, :change_amount, :status, :store_id,
      :booking_date, :is_b2b, :franchise_id, :franchise_discount_type, :franchise_discount_value,
      booking_items_attributes: [:id, :product_id, :product_variant_id, :quantity, :price, :_destroy]
    )
  end

  def quick_customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :mobile)
  end

  def validate_stock_availability(booking, is_update: false)
    stock_errors = []

    active_items = booking.booking_items.reject(&:marked_for_destruction?)
                          .select { |i| i.product_id.present? && i.quantity.present? && i.quantity > 0 }

    product_ids  = active_items.map(&:product_id).uniq
    variant_ids  = active_items.map(&:product_variant_id).compact.uniq

    products_by_id = Product.where(id: product_ids).index_by(&:id)
    variants_by_id = variant_ids.any? ? ProductVariant.where(id: variant_ids).index_by(&:id) : {}

    active_items.each do |item|
      product = products_by_id[item.product_id]
      next unless product

      # Admin bookings sell from central inventory only (store_id IS NULL)
      if product.has_multiple_quantities? && item.product_variant_id.present?
        variant = variants_by_id[item.product_variant_id]
        available_stock = variant ? variant.available_stock.to_f : 0.0
      else
        available_stock = StockBatch.available_for_product(product.id, store_id: nil).sum(:quantity_remaining).to_f
      end

      # For updates, add back the current item's quantity if it exists
      if is_update && item.persisted? && item.quantity_changed?
        available_stock += (item.quantity_was || 0)
      end

      if item.quantity > available_stock
        stock_errors << {
          product: product,
          requested: item.quantity,
          available: available_stock,
          item: item
        }
      end
    end

    if stock_errors.any?
      stock_errors.each do |error|
        booking.errors.add(:base,
          "#{error[:product].name}: Only #{error[:available]} units available, but #{error[:requested]} requested")

        # Also add error to the specific booking item
        error[:item].errors.add(:quantity,
          "only #{error[:available]} units available")
      end

      flash.now[:alert] = "Stock validation failed: #{stock_errors.map { |e|
        "#{e[:product].name} (Available: #{e[:available]}, Requested: #{e[:requested]})"
      }.join(', ')}"

      return false
    end

    true
  end

  # Stage transition processing methods
  def process_confirmed_transition
    # The booking status and data have already been updated in update_booking_with_transition
    # Just need to provide the redirect response

    respond_to do |format|
      format.html { redirect_to admin_bookings_path, notice: 'Booking confirmed successfully!' }
      format.json { render json: { success: true, message: 'Booking confirmed successfully!', status: @booking.status } }
    end
  rescue => e
    respond_to do |format|
      format.html { redirect_to admin_bookings_path, alert: "Error confirming booking: #{e.message}" }
      format.json { render json: { success: false, error: e.message } }
    end
  end

  def process_processing_transition
    respond_to do |format|
      format.html { redirect_to admin_bookings_path, notice: 'Booking moved to processing!' }
      format.json { render json: { success: true, message: 'Booking moved to processing!', status: @booking.status } }
    end
  rescue => e
    respond_to do |format|
      format.html { redirect_to admin_bookings_path, alert: "Error processing booking: #{e.message}" }
      format.json { render json: { success: false, error: e.message } }
    end
  end

  def process_packed_transition
    respond_to do |format|
      format.html { redirect_to admin_bookings_path, notice: 'Booking marked as packed!' }
      format.json { render json: { success: true, message: 'Booking marked as packed!', status: @booking.status } }
    end
  rescue => e
    respond_to do |format|
      format.html { redirect_to admin_bookings_path, alert: "Error packing booking: #{e.message}" }
      format.json { render json: { success: false, error: e.message } }
    end
  end

  def process_shipped_transition
    # Validation for required fields
    unless params[:courier_service].present? && params[:tracking_number].present?
      respond_to do |format|
        format.html { redirect_to admin_bookings_path, alert: 'Courier service and tracking number are required for shipping' }
        format.json { render json: { success: false, error: 'Courier service and tracking number are required for shipping' } }
      end
      return
    end

    respond_to do |format|
      format.html { redirect_to admin_bookings_path, notice: 'Booking marked as shipped with tracking details!' }
      format.json { render json: { success: true, message: 'Booking marked as shipped with tracking details!', status: @booking.status } }
    end
  rescue => e
    respond_to do |format|
      format.html { redirect_to admin_bookings_path, alert: "Error shipping booking: #{e.message}" }
      format.json { render json: { success: false, error: e.message } }
    end
  end

  # Single source of truth for whether this request is asking for the
  # franchise-delivery path — always re-checks the feature flag so a crafted
  # request can't set delivery_franchise_id while the feature is disabled.
  def franchise_delivery_mode_requested?
    params[:delivery_mode] == 'franchise' && SystemSetting.franchise_commission_enabled?
  end

  def process_out_for_delivery_transition
    if franchise_delivery_mode_requested?
      unless params[:delivery_franchise_id].present?
        respond_to do |format|
          format.html { redirect_to manage_stage_admin_booking_path(@booking), alert: 'Please select a franchise for out for delivery' }
          format.json { render json: { success: false, error: 'Please select a franchise for out for delivery' } }
        end
        return
      end
    else
      # Validation for required fields
      unless params[:delivery_person_id].present?
        respond_to do |format|
          format.html { redirect_to manage_stage_admin_booking_path(@booking), alert: 'Please select a delivery person for out for delivery' }
          format.json { render json: { success: false, error: 'Please select a delivery person for out for delivery' } }
        end
        return
      end
    end

    respond_to do |format|
      format.html { redirect_to admin_bookings_path, notice: 'Booking marked as out for delivery with delivery person assigned!' }
      format.json { render json: { success: true, message: 'Booking marked as out for delivery with delivery person assigned!', status: @booking.status } }
    end
  rescue => e
    respond_to do |format|
      format.html { redirect_to admin_bookings_path, alert: "Error updating delivery status: #{e.message}" }
      format.json { render json: { success: false, error: e.message } }
    end
  end

  def process_delivered_transition
    # Auto-transition to completed as per original logic
    @booking.update!(status: :completed)

    respond_to do |format|
      format.html { redirect_to admin_bookings_path, notice: 'Booking marked as delivered and completed!' }
      format.json { render json: { success: true, message: 'Booking marked as delivered and completed!', status: @booking.status } }
    end
  rescue => e
    respond_to do |format|
      format.html { redirect_to admin_bookings_path, alert: "Error marking as delivered: #{e.message}" }
      format.json { render json: { success: false, error: e.message } }
    end
  end

  def process_cancelled_transition
    unless params[:cancellation_reason].present?
      respond_to do |format|
        format.html { redirect_to admin_bookings_path, alert: 'Cancellation reason is required' }
        format.json { render json: { success: false, error: 'Cancellation reason is required' } }
      end
      return
    end

    respond_to do |format|
      format.html { redirect_to admin_bookings_path, notice: 'Booking cancelled successfully!' }
      format.json { render json: { success: true, message: 'Booking cancelled successfully!', status: @booking.status } }
    end
  rescue => e
    respond_to do |format|
      format.html { redirect_to admin_bookings_path, alert: "Error cancelling booking: #{e.message}" }
      format.json { render json: { success: false, error: e.message } }
    end
  end

  def process_returned_transition
    unless params[:return_reason].present?
      respond_to do |format|
        format.html { redirect_to admin_bookings_path, alert: 'Return reason is required' }
        format.json { render json: { success: false, error: 'Return reason is required' } }
      end
      return
    end

    respond_to do |format|
      format.html { redirect_to admin_bookings_path, notice: 'Return processed successfully!' }
      format.json { render json: { success: true, message: 'Return processed successfully!', status: @booking.status } }
    end
  rescue => e
    respond_to do |format|
      format.html { redirect_to admin_bookings_path, alert: "Error processing return: #{e.message}" }
      format.json { render json: { success: false, error: e.message } }
    end
  end

  def process_general_transition
    respond_to do |format|
      format.html { redirect_to admin_bookings_path, notice: "Booking updated to #{@target_stage.humanize}!" }
      format.json { render json: { success: true, message: "Booking updated to #{@target_stage.humanize}!", status: @booking.status } }
    end
  rescue => e
    respond_to do |format|
      format.html { redirect_to admin_bookings_path, alert: "Error updating booking: #{e.message}" }
      format.json { render json: { success: false, error: e.message } }
    end
  end

  def generate_immediate_invoice_for_booking(booking)
    booking.generate_quick_invoice!
  end
end