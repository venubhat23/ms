class Franchise::BookingsController < Franchise::BaseController
  before_action :set_booking, only: [:edit, :update, :destroy, :generate_invoice, :invoice, :convert_to_order, :update_status, :cancel_order]
  # Admin can hand a booking to this franchise purely for delivery
  # (delivery_franchise_id, see FranchiseDeliveryAssignmentService) without
  # it ever being one of the franchise's own bookings (franchise_id). Those
  # deliveries still need to show up here and be movable through the stage
  # workflow — but NOT through the ownership actions above (edit/destroy/
  # cancel/etc.), which stay restricted to bookings this franchise actually
  # placed.
  before_action :set_deliverable_booking, only: [:show, :manage_stage, :update_stage, :mark_delivered, :mark_completed]

  def index
    # All bookings belonging to this franchise, plus any booking admin
    # handed to this franchise purely for delivery (delivery_franchise_id,
    # see FranchiseDeliveryAssignmentService) even though it's someone
    # else's booking — those need to show up here too so the franchise can
    # see and progress them, not just in the separate /franchise/deliveries
    # page.
    #
    # Excluded: the wholesale "Franchise Booking" that FranchiseStockRequest#approve!
    # builds to move HQ stock into this franchise's inventory ledger (e.g. the
    # auto-generated restock FranchiseStockAutoReplenishJob creates when an
    # admin-assigned delivery finds a stock shortfall). That's a stock
    # transfer, not an order to fulfil — it belongs under Stock Requests, and
    # showing it here just looked like a duplicate of the order being assigned.
    restock_booking_ids = FranchiseStockRequest.where(franchise_id: current_franchise.id)
                                               .where.not(booking_id: nil)
                                               .pluck(:booking_id)

    scope = Booking.where(franchise_id: current_franchise.id)
                   .or(Booking.where(delivery_franchise_id: current_franchise.id))
    scope = scope.where.not(id: restock_booking_ids) if restock_booking_ids.any?
    @all_bookings = scope.includes(:customer, :user, :booking_items, :store, :booking_invoices)

    # Franchise-created bookings
    franchise_bookings = @all_bookings.where(booked_by: 'franchise')
    # Online orders placed by customers and assigned to this franchise
    online_orders = @all_bookings.where(booked_by: 'customer')
    # Someone else's booking, handed to this franchise only for delivery
    admin_assigned_deliveries = @all_bookings.where(delivery_franchise_id: current_franchise.id)
                                              .where.not(franchise_id: current_franchise.id)

    # Source filter: 'franchise' = only franchise-created, 'online' = only customer orders,
    # 'admin_assigned' = admin-assigned deliveries, default = all
    @source_filter = params[:source].presence || 'all'
    base_scope = case @source_filter
                 when 'franchise'
                   franchise_bookings
                 when 'online'
                   online_orders
                 when 'admin_assigned'
                   admin_assigned_deliveries
                 else
                   @all_bookings
                 end

    @bookings = base_scope.recent

    if params[:search].present?
      @bookings = @bookings.where(
        "booking_number LIKE ? OR customer_name LIKE ? OR customer_email LIKE ? OR customer_phone LIKE ?",
        "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%"
      )
    end

    if params[:status].present? && params[:status].strip != ''
      @bookings = @bookings.where(status: params[:status])
    end

    if params[:date_from].present? && params[:date_to].present?
      @bookings = @bookings.where(created_at: params[:date_from]..params[:date_to])
    end

    if params[:customer_id].present? && params[:customer_id].strip != ''
      @bookings = @bookings.where(customer_id: params[:customer_id])
    end

    @per_page = SystemSetting.default_pagination_per_page
    @bookings = @bookings.page(params[:page]).per(@per_page)

    # booking_invoices is eager-loaded above; memoize @associated_invoice to nil so
    # has_invoice?/invoice_link_path/display_invoice_number never fire a per-row
    # unindexed LIKE query against invoice_items (mirrors Admin::BookingsController#index).
    @bookings.each { |b| b.instance_variable_set(:@associated_invoice, nil) }

    # Source-tab counts and status-tab counts (2 + 6 separate COUNT(*) round
    # trips, the latter issued from the view via @bookings_for_stats.where(...))
    # collapsed into 2 grouped queries.
    booked_by_counts = @all_bookings.group(:booked_by).count
    @franchise_bookings_count = booked_by_counts['franchise'] || 0
    @online_orders_count = booked_by_counts['customer'] || 0
    @admin_assigned_count = admin_assigned_deliveries.count

    status_counts = @all_bookings.group(:status).count
    @stats_draft_count = status_counts['draft'] || 0
    @stats_pending_count = status_counts['pending'] || 0
    @stats_active_count = (status_counts['confirmed'] || 0) + (status_counts['processing'] || 0) + (status_counts['packed'] || 0)
    @stats_shipping_count = (status_counts['shipped'] || 0) + (status_counts['out_for_delivery'] || 0)
    @stats_completed_count = status_counts['completed'] || 0
    @stats_cancelled_count = (status_counts['cancelled'] || 0) + (status_counts['returned'] || 0)

    @customers = cached_customers_picker
  end

  def new
    @booking = Booking.new
    @booking.booking_items.build

    # Eager load all necessary associations and precompute stock data
    @products = sellable_products_scope

    @customers = cached_customers_picker
    @categories = Category.where(status: true).order(:name).to_a
    @stores = Store.active.order(:name).to_a
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.franchise_id = current_franchise.id
    @booking.booked_by = 'franchise'
    @booking.skip_stock_check = true

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

    # Store payment status value for after save (to avoid enum conflicts during validation)
    @payment_status_from_form = params[:booking][:payment_status]
    Rails.logger.info "Payment status from form: #{@payment_status_from_form}"

    # Validate stock availability before saving
    unless validate_stock_availability(@booking)
      @products = sellable_products_scope
      @customers = cached_customers_picker
      @categories = Category.where(status: true).order(:name).to_a
      @stores = Store.active.order(:name).to_a
      render :new, status: :unprocessable_entity
      return
    end

    # Set payment_status before save so before_validation picks it up — single save
    @booking.payment_status = @payment_status_from_form == 'paid' ? :paid : :unpaid

    if @booking.save
      Rails.logger.info "Booking totals - Subtotal: #{@booking.subtotal}, Tax: #{@booking.tax_amount}, Discount: #{@booking.discount_amount}, Total: #{@booking.total_amount}"
      Rails.logger.info "Final payment status after save: #{@booking.payment_status}"

      # Generate invoice immediately if payment is received
      invoice_notice = ""
      if @booking.payment_status_paid?
        begin
          invoice = generate_immediate_invoice_for_booking(@booking)
          if invoice
            invoice_notice = " Invoice ##{invoice.invoice_number} generated with paid status."
          end
        rescue => e
          Rails.logger.error "Failed to generate immediate invoice for booking ##{@booking.id}: #{e.message}"
          invoice_notice = " Note: Invoice generation failed, will be handled via consolidated system."
        end
      else
        Rails.logger.info "Booking ##{@booking.id} created successfully. Invoice will be generated via consolidated system when payment is received."
      end

      # Convert to order if payment is received
      if @booking.payment_status_paid? && params[:create_order] == '1'
        @booking.convert_to_order!
      end

      redirect_to franchise_booking_path(@booking), notice: "Booking created successfully!#{invoice_notice}"
    else
      Rails.logger.error "Booking creation failed: #{@booking.errors.full_messages.join(', ')}"
      Rails.logger.error "Booking items errors: #{@booking.booking_items.map(&:errors).map(&:full_messages).flatten.join(', ')}"

      @products = sellable_products_scope
      @customers = cached_customers_picker
      @categories = Category.where(status: true).order(:name).to_a
      @stores = Store.active.order(:name).to_a
      flash.now[:alert] = @booking.errors.full_messages.join(', ')
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @booking_items = @booking.booking_items.includes(product: [:category, image_attachment: :blob, additional_images_attachments: :blob])
  end

  def edit
    @products = sellable_products_scope
  end

  def update
    # Validate stock availability for updates
    unless validate_stock_availability(@booking, is_update: true)
      @products = sellable_products_scope
      render :edit, status: :unprocessable_entity
      return
    end

    @booking.skip_stock_check = true

    if @booking.update(booking_params)
      redirect_to franchise_booking_path(@booking), notice: 'Booking updated successfully!'
    else
      @products = sellable_products_scope
      render :edit
    end
  end

  def destroy
    begin
      # Check for associated orders (if enabled)
      if @booking.respond_to?(:order) && @booking.order.present?
        redirect_to franchise_bookings_path, alert: 'Cannot delete booking with associated order.'
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

      redirect_to franchise_bookings_path, notice: "Booking #{booking_number} for #{customer_name} has been permanently deleted along with all associated records."
    rescue => e
      # Log the error
      Rails.logger.error "Failed to delete booking #{@booking.booking_number} (ID: #{@booking.id}): #{e.message}"
      Rails.logger.error e.backtrace.join("\n")

      # Provide user-friendly error message
      redirect_to franchise_bookings_path, alert: "Failed to delete booking: #{e.message}. Please try again or contact support if the issue persists."
    end
  end

  def generate_invoice
    @booking.generate_quick_invoice! unless @booking.invoice_number.present? && Invoice.exists?(invoice_number: @booking.invoice_number)
    redirect_to invoice_franchise_booking_path(@booking)
  end

  def invoice
    respond_to do |format|
      format.html { render template: 'franchise/bookings/invoice', layout: 'invoice' }
      format.pdf do
        pdf = WickedPdf.new.pdf_from_string(
          render_to_string('franchise/bookings/invoice', formats: [:html], layout: 'invoice_pdf'),
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
      redirect_to franchise_order_path(@booking.order), notice: 'Order already exists for this booking.'
    elsif (order = @booking.convert_to_order!)
      redirect_to franchise_order_path(order), notice: 'Order created successfully!'
    else
      redirect_to franchise_booking_path(@booking), alert: 'Converting a booking into an order is currently unavailable.'
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
        format.html { redirect_to franchise_booking_path(@booking), notice: message }
        format.json { render json: { success: true, message: message, new_status: @booking.status } }
      end
    else
      respond_to do |format|
        format.html { redirect_to franchise_booking_path(@booking), alert: 'Invalid status transition.' }
        format.json { render json: { success: false, message: 'Invalid status transition.' } }
      end
    end
  end

  private

  # Once the Franchise Commission feature is on, a franchise only sells what's
  # actually in their own credited inventory (see FranchiseInventory —
  # populated by admin/franchise-approved wholesale bookings), not the shared
  # central warehouse stock. `cached_stock` is aliased the same way in both
  # branches so Product#cached_total_batch_stock (and therefore out_of_stock?/
  # low_stock? used by the product cards) works unchanged either way.
  def sellable_products_scope
    if SystemSetting.franchise_commission_enabled?
      Product.active
             .includes(:category, image_attachment: :blob, additional_images_attachments: :blob)
             .joins("INNER JOIN franchise_inventories fi ON fi.product_id = products.id AND fi.franchise_id = #{current_franchise.id.to_i} AND fi.quantity > 0")
             .select("products.*, fi.quantity AS cached_stock")
             .order(:name)
    else
      Product.active
             .includes(:category, :stock_batches, image_attachment: :blob, additional_images_attachments: :blob)
             .joins("LEFT JOIN stock_batches ON stock_batches.product_id = products.id AND stock_batches.status = 'active' AND stock_batches.quantity_remaining > 0")
             .select(
               "products.*,
                COALESCE(SUM(stock_batches.quantity_remaining), 0) as cached_stock,
                MIN(stock_batches.batch_date) as first_batch_date,
                (SELECT quantity_purchased FROM stock_batches sb2 WHERE sb2.product_id = products.id ORDER BY sb2.batch_date ASC, sb2.created_at ASC LIMIT 1) as initial_stock_value"
             )
             .group("products.id")
             .order(Arel.sql("CASE WHEN COALESCE(SUM(stock_batches.quantity_remaining), 0) > 0 THEN 0 ELSE 1 END ASC, products.name ASC"))
    end
  end

  # The customer picker (booking form JS search + index filter dropdown) needs
  # every customer client-side, so it can't be paginated/limited — cache the
  # list instead to avoid re-querying/sorting the full table on every load.
  def cached_customers_picker
    Rails.cache.fetch('franchise_bookings/customers_picker', expires_in: 5.minutes) do
      Customer.select(:id, :first_name, :middle_name, :last_name, :email, :mobile)
              .order(:first_name, :last_name).to_a
    end
  end

  def set_booking
    # Preloading booking_items: :product here (not just in #show) also fixes
    # the N+1 in the #invoice view, which walks @booking.booking_items/item.product directly.
    @booking = Booking.where(franchise_id: current_franchise.id).includes(booking_items: :product).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to franchise_bookings_path, alert: 'Booking not found'
  end

  # Same as set_booking, but also allows a booking this franchise doesn't
  # own — just delivers, via delivery_franchise_id — so #show/#manage_stage/
  # #update_stage/#mark_delivered/#mark_completed work for admin-assigned
  # deliveries too.
  def set_deliverable_booking
    @booking = Booking.where(franchise_id: current_franchise.id)
                       .or(Booking.where(delivery_franchise_id: current_franchise.id))
                       .includes(booking_items: :product)
                       .find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to franchise_bookings_path, alert: 'Booking not found'
  end

  def booking_params
    params.require(:booking).permit(
      :customer_id, :booking_date, :status, :notes, :customer_name, :customer_email,
      :customer_phone, :customer_address, :delivery_address, :delivery_date, :delivery_time,
      :payment_method, :payment_status, :cash_received, :change_amount, :discount_amount, :store_id, :booked_by,
      booking_items_attributes: [
        :id, :product_id, :quantity, :price, :unit_price, :subtotal, :_destroy
      ]
    )
  end

  def validate_stock_availability(booking, is_update: false)
    items = booking.booking_items.reject(&:marked_for_destruction?)
    return true if items.empty?

    # Once the franchise commission feature is on, a franchise sells from its
    # own credited inventory ledger, not the shared central pool.
    return validate_franchise_stock_availability(booking, items, is_update: is_update) if SystemSetting.franchise_commission_enabled?

    # Franchise self-service bookings no longer block on central stock —
    # only the admin panel (Admin::BookingsController) still shows "out of
    # stock" and refuses to save. BookingItem#reduce_product_stock is allowed
    # to push product stock negative instead (see Booking#skip_stock_check).
    true
  end

  def validate_franchise_stock_availability(booking, items, is_update: false)
    product_ids = items.map(&:product_id).compact.uniq
    products_by_id = Product.where(id: product_ids).index_by(&:id)

    items.each do |item|
      product = products_by_id[item.product_id]
      next unless product

      available_stock = FranchiseInventory.balance_for(current_franchise, product).to_f
      available_stock += item.quantity_was.to_f if is_update && item.persisted?

      if item.quantity > available_stock
        @booking.errors.add(:base, "Insufficient franchise inventory for #{product.name}. Available: #{available_stock}, Requested: #{item.quantity}")
        return false
      end
    end
    true
  end

  def generate_immediate_invoice_for_booking(booking)
    # Add invoice generation logic here if needed
    # This would be similar to admin functionality
    nil
  end

  # Routed endpoints below (AJAX pickers + delivery-stage management). These
  # must stay public — a private method isn't dispatchable as a controller
  # action (Rails raises AbstractController::ActionNotFound), which is exactly
  # what broke PATCH /franchise/bookings/:id/update_stage.
  public

  # AJAX endpoints
  def search_products
    @products = Product.active
                       .where("name ILIKE ? OR sku ILIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
                       .limit(10)

    render json: @products.map { |p|
      {
        id: p.id,
        text: "#{p.name} - #{p.formatted_selling_price}",
        name: p.name,
        price: p.selling_price,
        stock: p.total_batch_stock,
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

  def manage_stage
    @available_statuses = Booking.statuses.keys.map { |status| [status.humanize, status] }
    @next_stages = @booking.next_possible_statuses
  end

  def update_stage
    @target_stage = params[:target_stage] || params[:booking][:status]

    unless @target_stage.present?
      redirect_to manage_stage_franchise_booking_path(@booking), alert: "Please select a target stage."
      return
    end

    begin
      # Build transition data
      transition_data = build_stage_transition_data

      # Update booking with new status and transition data
      if update_booking_with_stage_transition(transition_data)
        redirect_to franchise_bookings_path, notice: "Booking stage updated to #{@target_stage.humanize} successfully."
      else
        redirect_to manage_stage_franchise_booking_path(@booking), alert: "Failed to update stage: #{@booking.errors.full_messages.join(', ')}"
      end
    rescue => e
      Rails.logger.error "Error in update_stage: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      redirect_to manage_stage_franchise_booking_path(@booking), alert: "Failed to update stage: #{e.message}"
    end
  end

  def realtime_data
    # This action is routed separately from #index (which is the only place
    # @all_bookings gets set), so it was raising NoMethodError on nil here —
    # silently swallowed by the rescue below. Rebuild the same scope #index
    # uses instead of relying on that instance variable.
    all_bookings = Booking.where(franchise_id: current_franchise.id)

    # One grouped count instead of 4 separate COUNT(*) round trips
    status_counts = all_bookings.group(:status).count

    stats = {
      total: status_counts.values.sum,
      pending: status_counts['pending'] || 0,
      processing: status_counts['processing'] || 0,
      delivered: status_counts['delivered'] || 0
    }

    # Get recent bookings
    recent_bookings = all_bookings.recent.includes(:customer).limit(5).map do |booking|
      {
        id: booking.id,
        booking_number: booking.booking_number,
        customer_name: booking.customer&.display_name,
        status: booking.status,
        total_amount: booking.total_amount,
        created_at: booking.created_at.strftime('%b %d, %Y')
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

  private

  def build_stage_transition_data
    {
      from_stage: @booking.status,
      to_stage: @target_stage,
      timestamp: Time.current,
      user_id: current_user&.id,
      user_name: current_user&.email,
      notes: params[:transition_notes]
    }
  end

  def update_booking_with_stage_transition(transition_data)
    @booking.status = @target_stage
    @booking.stage_updated_at = transition_data[:timestamp]
    # stage_updated_by is an integer (user id) column — matches
    # Admin::BookingsController and FranchiseDeliveryAssignmentService.
    @booking.stage_updated_by = transition_data[:user_id]
    @booking.transition_notes = transition_data[:notes] if transition_data[:notes].present?
    @booking.save
  end
end