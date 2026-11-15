class Api::V1::Admin::BookingsController < Api::V1::Admin::BaseController
  # Everything booking_response(detailed: true) reads, loaded up front.
  DETAIL_INCLUDES = [
    :customer, :delivery_person, :delivery_franchise, :store, :franchise, :user,
    :wallet_transaction, :booking_discounts, :booking_invoices,
    { booking_items: [:product_variant, { product: :category }] }
  ].freeze

  # GET /api/v1/admin/bookings
  def index
    bookings = Booking.includes(:customer, :booking_invoices)
    bookings = bookings.where(status: params[:status]) if params[:status].present?
    bookings = bookings.where(payment_status: params[:payment_status]) if params[:payment_status].present?
    bookings = bookings.where(store_id: params[:store_id]) if params[:store_id].present?
    bookings = bookings.where(customer_id: params[:customer_id]) if params[:customer_id].present?
    bookings = bookings.where('bookings.created_at >= ?', param_date(:from_date).beginning_of_day) if param_date(:from_date)
    bookings = bookings.where('bookings.created_at <= ?', param_date(:to_date).end_of_day) if param_date(:to_date)
    if params[:search].present?
      # Same matching as the web bookings page: number, customer, phone, product name
      term = "%#{ActiveRecord::Base.sanitize_sql_like(params[:search].strip)}%"
      bookings = bookings.where(
        "bookings.booking_number ILIKE :t OR bookings.customer_name ILIKE :t OR bookings.customer_email ILIKE :t " \
        "OR bookings.customer_phone ILIKE :t " \
        "OR bookings.customer_id IN (SELECT id FROM customers WHERE CONCAT_WS(' ', first_name, last_name) ILIKE :t OR mobile ILIKE :t) " \
        "OR bookings.id IN (SELECT bi.booking_id FROM booking_items bi JOIN products p ON p.id = bi.product_id WHERE p.name ILIKE :t)",
        t: term
      )
    end
    bookings = bookings.order(created_at: :desc)

    page = params[:page] || 1
    per_page = params[:per_page] || 20
    bookings = bookings.page(page).per(per_page)
    # The WhatsApp thank-you text quotes the invoice number of paid bookings;
    # look those up in one query instead of one LIKE query per booking.
    Booking.preload_associated_invoices(bookings.select(&:payment_status_paid?))

    render_success(
      bookings: bookings.map { |b| booking_response(b) },
      pagination: {
        current_page: bookings.current_page,
        total_pages: bookings.total_pages,
        total_count: bookings.total_count,
        per_page: bookings.limit_value
      }
    )
  end

  # GET /api/v1/admin/bookings/:id
  def show
    booking = Booking.includes(*DETAIL_INCLUDES).find(params[:id])
    render_success(booking_response(booking, detailed: true))
  rescue ActiveRecord::RecordNotFound
    render_error('Booking not found', nil, :not_found)
  end

  # POST /api/v1/admin/bookings
  # Minimal "quick booking" creation for admin use (customer + product line items).
  def create
    booking = Booking.new(booking_params)
    booking.user = @current_user
    booking.status ||= 'ordered_and_delivery_pending'
    booking.booking_date ||= Time.current
    fill_missing_item_prices(booking)

    if booking.save
      render_success(booking_response(booking, detailed: true), 'Booking created successfully', :created)
    else
      render_validation_errors(booking)
    end
  end

  # GET /api/v1/admin/bookings/:id/stage_options
  # Everything the app's "Manage Stage" screen needs: the stages the booking
  # can move to (same list as the web page), the fields each stage takes,
  # and the delivery people / franchises to pick for out_for_delivery.
  def stage_options
    booking = Booking.includes(:delivery_person, :delivery_franchise).find(params[:id])
    franchise_enabled = BookingStageUpdateService.franchise_delivery_enabled?
    already_assigned = booking.delivery_franchise_id.present? || booking.delivery_person_id.present?

    stages = BookingStageUpdateService.stages_for(booking).map do |stage|
      approve = stage == 'confirmed' && booking.pending_pre_booking_approval?
      {
        value: stage,
        label: approve ? 'Approve Pre-Booking (Admin Confirmed)' : stage.humanize,
        description: approve ? 'Confirms the order and notifies the customer' : ApplicationController.helpers.stage_description_full(stage),
        fields: STAGE_FIELDS.fetch(stage, []),
        disabled: stage == 'out_for_delivery' && already_assigned
      }
    end

    render_success(
      booking_id: booking.id,
      booking_number: booking.booking_number,
      current_status: booking.status,
      current_status_label: booking.status.humanize,
      is_pre_booking: booking.is_pre_booking,
      payment_status: booking.payment_status,
      already_assigned_for_delivery: already_assigned,
      assigned_delivery_person: booking.delivery_person && { id: booking.delivery_person_id, name: booking.delivery_person.display_name },
      assigned_franchise: booking.delivery_franchise && { id: booking.delivery_franchise_id, name: booking.delivery_franchise.name },
      stages: stages,
      franchise_delivery_enabled: franchise_enabled,
      delivery_people: DeliveryPerson.active.order(:first_name, :last_name).map { |dp|
        { id: dp.id, name: dp.display_name, mobile: dp.mobile }
      },
      franchises: franchise_enabled ? Franchise.active.order(:name).map { |f| { id: f.id, name: f.name } } : []
    )
  rescue ActiveRecord::RecordNotFound
    render_error('Booking not found', nil, :not_found)
  end

  # PATCH /api/v1/admin/bookings/:id/update_stage
  # Same behaviour as the web admin Manage Stage page (see BookingStageUpdateService).
  # Body: { target_stage: "shipped", courier_service: "...", tracking_number: "...", transition_notes: "..." }
  def update_stage
    booking = Booking.find(params[:id])
    result = BookingStageUpdateService.new(
      booking: booking, target_stage: params[:target_stage].presence || params[:status],
      actor: @current_user, params: params
    ).call

    return render_error(result.message, nil, :unprocessable_entity) unless result.success?

    booking = Booking.includes(*DETAIL_INCLUDES).find(booking.id)
    render_success(booking_response(booking, detailed: true), result.message)
  rescue ActiveRecord::RecordNotFound
    render_error('Booking not found', nil, :not_found)
  end

  # PATCH/PUT /api/v1/admin/bookings/:id
  # The admin app may change only two things here: the stage and paid/unpaid.
  # Body: { booking: { status: "shipped", payment_status: "paid",
  #                    courier_service: "...", transition_notes: "..." } }
  # (keys may also be sent top-level). Both are optional but at least one is
  # required; any other field is rejected with 422. The stage change runs
  # through BookingStageUpdateService, same as the web Manage Stage page.
  def update
    booking = Booking.find(params[:id])
    input = params[:booking].is_a?(ActionController::Parameters) ? params[:booking] : params
    status = input[:status].presence
    payment_status = input[:payment_status].presence

    extra = (params[:booking].is_a?(ActionController::Parameters) ? params[:booking].keys : []) -
            EDITABLE_BOOKING_KEYS - STAGE_FIELDS.values.flatten
    if extra.any?
      return render_error("Only status and payment_status can be updated. Not allowed: #{extra.join(', ')}",
                          { not_allowed: extra }, :unprocessable_entity)
    end
    if status.nil? && payment_status.nil?
      return render_error('Send status and/or payment_status', nil, :unprocessable_entity)
    end
    if payment_status && !%w[paid unpaid].include?(payment_status)
      return render_error("payment_status must be 'paid' or 'unpaid'", nil, :unprocessable_entity)
    end
    status = nil if status == booking.status
    if status && !BookingStageUpdateService.stages_for(booking).include?(status)
      return render_error("Cannot move booking from #{booking.status.humanize} to #{status.humanize}.",
                          { allowed_statuses: BookingStageUpdateService.stages_for(booking) }, :unprocessable_entity)
    end

    messages = []
    if status
      result = BookingStageUpdateService.new(booking: booking, target_stage: status, actor: @current_user, params: input).call
      return render_error(result.message, nil, :unprocessable_entity) unless result.success?
      messages << result.message
      booking.reload
    end
    if payment_status && booking.payment_status != payment_status
      booking.update!(payment_status: payment_status)
      messages << "Payment marked #{payment_status}."
    end

    booking = Booking.includes(*DETAIL_INCLUDES).find(booking.id)
    render_success(booking_response(booking, detailed: true), messages.presence&.join(' ') || 'No changes')
  rescue ActiveRecord::RecordNotFound
    render_error('Booking not found', nil, :not_found)
  rescue ActiveRecord::RecordInvalid => e
    render_error("Failed to update booking: #{e.record.errors.full_messages.join(', ')}", nil, :unprocessable_entity)
  end

  # PATCH /api/v1/admin/bookings/:id/update_status
  # Mirrors Admin::BookingsController#update_status (web) — only allows moves
  # Booking#next_possible_statuses permits, routed through the matching
  # mark_as_*! method so the same side effects (timestamps, notes, auto
  # transitions) happen regardless of which surface made the change.
  def update_status
    booking = Booking.find(params[:id])
    new_status = params[:status]

    unless booking.next_possible_statuses.include?(new_status)
      return render_error('Invalid status transition', nil, :unprocessable_entity)
    end

    case new_status
    when 'ordered_and_delivery_pending' then booking.update!(status: :ordered_and_delivery_pending)
    when 'confirmed' then booking.mark_as_confirmed!
    when 'processing' then booking.mark_as_processing!
    when 'packed' then booking.mark_as_packed!
    when 'shipped' then booking.mark_as_shipped!(params[:tracking_number])
    when 'out_for_delivery' then booking.mark_as_out_for_delivery!
    when 'delivered' then booking.mark_as_delivered!
    when 'cancelled' then booking.cancel_order!(params[:reason])
    when 'returned' then booking.return_order!(params[:reason])
    else booking.update!(status: new_status)
    end

    render_success(booking_response(booking, detailed: true), "Booking status updated to #{new_status.humanize}")
  rescue ActiveRecord::RecordNotFound
    render_error('Booking not found', nil, :not_found)
  end

  # PATCH /api/v1/admin/bookings/:id/cancel
  def cancel
    booking = Booking.find(params[:id])

    unless booking.next_possible_statuses.include?('cancelled')
      return render_error('Booking cannot be cancelled in its current status', nil, :unprocessable_entity)
    end

    booking.cancel_order!(params[:reason])
    render_success(booking_response(booking, detailed: true), 'Booking cancelled successfully')
  rescue ActiveRecord::RecordNotFound
    render_error('Booking not found', nil, :not_found)
  end

  # PATCH /api/v1/admin/bookings/:id/mark_delivered
  def mark_delivered
    booking = Booking.find(params[:id])

    unless booking.out_for_delivery?
      return render_error('Booking must be out for delivery before it can be marked delivered', nil, :unprocessable_entity)
    end

    booking.mark_as_delivered!
    render_success(booking_response(booking, detailed: true), 'Booking marked as delivered')
  rescue ActiveRecord::RecordNotFound
    render_error('Booking not found', nil, :not_found)
  end

  # POST /api/v1/admin/bookings/:id/generate_invoice
  def generate_invoice
    booking = Booking.find(params[:id])

    if booking.has_invoice?
      return render_error('Invoice already generated for this booking', nil, :unprocessable_entity)
    end

    invoice = booking.generate_quick_invoice!
    if invoice
      render_success({ invoice_id: invoice.id, invoice_number: invoice.invoice_number }, 'Invoice generated successfully', :created)
    else
      render_error('Failed to generate invoice. Please check the booking has items and try again.', nil, :unprocessable_entity)
    end
  rescue ActiveRecord::RecordNotFound
    render_error('Booking not found', nil, :not_found)
  end

  # POST /api/v1/admin/bookings/bulk_mark_paid
  # Mirrors Admin::BookingsController#bulk_mark_paid (web). Already paid/refunded
  # or unknown ids are reported in skipped_ids, not treated as errors.
  def bulk_mark_paid
    ids = Array(params[:booking_ids]).map { |id| id.to_s.to_i }.select(&:positive?).uniq
    return render_error('Select at least one booking', nil, :unprocessable_entity) if ids.empty?

    bookings = Booking.includes(:customer, :booking_invoices).where(id: ids)
                      .where("bookings.payment_status IS NULL OR bookings.payment_status NOT IN ('paid', 'refunded')")

    updated = []
    failed = []
    bookings.find_each do |booking|
      booking.mark_as_fully_paid!
      updated << booking
    rescue => e
      failed << { id: booking.id, booking_number: booking.booking_number, error: e.message }
    end

    if updated.empty? && failed.empty?
      return render_error('No unpaid bookings were selected.', nil, :unprocessable_entity)
    end

    result = {
      updated_count: updated.size,
      failed_count: failed.size,
      skipped_ids: ids - updated.map(&:id) - failed.pluck(:id),
      bookings: updated.map { |b| booking_response(b) },
      failed: failed
    }
    return render_error('No bookings could be marked as paid', result, :unprocessable_entity) if updated.empty?

    message = "Marked #{updated.size} booking(s) as paid."
    message += " #{failed.size} failed." if failed.any?
    render_success(result, message)
  end

  private

  # Extra inputs each stage accepts on update_stage (all optional, same as web).
  STAGE_FIELDS = {
    'shipped' => %w[courier_service tracking_number shipping_charges expected_delivery_date],
    'out_for_delivery' => %w[delivery_mode delivery_person_id delivery_franchise_id delivery_person delivery_contact],
    'delivered' => %w[delivery_person delivery_time customer_satisfaction],
    'cancelled' => %w[cancellation_reason refund_amount],
    'returned' => %w[return_reason refund_amount]
  }.transform_values { |v| v + %w[transition_notes] }.freeze

  # Keys PATCH bookings/:id accepts inside booking{} (stage fields from STAGE_FIELDS are allowed too).
  EDITABLE_BOOKING_KEYS = %w[status payment_status].freeze

  def booking_params
    params.require(:booking).permit(
      :customer_id, :customer_name, :customer_email, :customer_phone,
      :delivery_address, :payment_method, :notes,
      booking_items_attributes: [:product_id, :quantity, :price]
    )
  end

  def fill_missing_item_prices(booking)
    booking.booking_items.each do |item|
      item.price = item.product&.selling_price if item.price.blank? && item.product_id.present?
    end
  end

  def item_image_url(item)
    item.product&.main_image_url
  rescue StandardError
    nil
  end

  def booking_response(booking, detailed: false)
    data = {
      id: booking.id,
      booking_number: booking.booking_number,
      status: booking.status,
      payment_status: booking.payment_status,
      payment_method: booking.payment_method,
      total_amount: booking.total_amount.to_f,
      customer_name: booking.customer_name.presence || booking.customer&.display_name,
      customer_phone: booking.customer_phone,
      delivery_address: booking.delivery_address,
      items_count: booking.booking_items_count.to_i,
      is_pre_booking: booking.is_pre_booking,
      created_at: booking.created_at,
      whatsapp_thanks_url: ApplicationController.helpers.booking_payment_thanks_whatsapp_url(booking)
    }

    if detailed
      wholesale = booking.franchise_wholesale_pricing?
      data[:items] = booking.booking_items.map do |item|
        {
          id: item.id,
          product_id: item.product_id,
          product_name: item.product&.name,
          variant_id: item.product_variant_id,
          variant_label: item.product_variant&.label,
          sku: item.product_variant&.try(:sku).presence || item.product&.sku,
          category_name: item.product&.category&.name,
          image_url: item_image_url(item),
          quantity: item.quantity,
          price: item.price.to_f,
          # Regular (non-wholesale) unit price; only differs on franchise B2B bookings.
          regular_price: wholesale ? Booking.regular_unit_price_for_item(item).to_f : item.price.to_f,
          total: (item.total || item.price.to_f * item.quantity.to_f).to_f
        }
      end
      gst = ApplicationController.helpers.gst_booking_summary(booking.booking_items)
      data[:gst_summary] = {
        taxable_amount: gst[:base], tax_amount: gst[:tax],
        cgst: gst[:cgst], sgst: gst[:sgst], igst: gst[:igst], avg_tax_rate: gst[:avg_tax_rate]
      }
      data[:discounts] = booking.booking_discounts.map do |d|
        { source: d.source, discount_type: d.discount_type, value: d.value.to_f, amount: d.computed_amount.to_f }
      end
      data[:invoices] = booking.booking_invoices.map do |inv|
        { id: inv.id, invoice_number: inv.invoice_number, invoice_date: inv.invoice_date,
          total_amount: inv.total_amount.to_f, payment_status: inv.payment_status, status: inv.status }
      end
      data[:subtotal] = booking.subtotal.to_f
      data[:tax_amount] = booking.tax_amount.to_f
      data[:discount_amount] = booking.discount_amount&.to_f || 0
      data[:shipping_charges] = booking.shipping_charges.to_f
      data[:coupon_code] = booking.coupon_code
      data[:coupon_discount_amount] = booking.coupon_discount_amount.to_f
      data[:wallet_amount_used] = booking.wallet_amount_used.to_f
      data[:cash_received] = booking.cash_received&.to_f
      data[:payment_completed_at] = booking.payment_completed_at
      data[:customer_id] = booking.customer_id
      data[:customer_email] = booking.customer_email
      data[:store] = booking.store && { id: booking.store_id, name: booking.store.display_name }
      data[:franchise] = booking.franchise && { id: booking.franchise_id, name: booking.franchise.try(:name) }
      data[:delivery_person] = booking.delivery_person && {
        id: booking.delivery_person_id,
        name: booking.delivery_person.display_name,
        mobile: booking.delivery_person.mobile
      }
      data[:delivery_mode] = booking.delivery_mode
      data[:delivered_at] = booking.try(:delivered_at)
      data[:courier_service] = booking.courier_service
      data[:tracking_number] = booking.tracking_number
      data[:invoice_number] = booking.invoice_number
      data[:cancellation_reason] = booking.cancellation_reason
      data[:stage_history] = begin
        booking.stage_history.present? ? JSON.parse(booking.stage_history) : []
      rescue JSON::ParserError
        []
      end
      data[:stage_updated_at] = booking.stage_updated_at
      data[:transition_notes] = booking.transition_notes
      data[:expected_delivery_date] = booking.expected_delivery_date
      data[:delivery_contact] = booking.delivery_contact
      data[:delivery_franchise] = booking.delivery_franchise && { id: booking.delivery_franchise_id, name: booking.delivery_franchise.name }
      data[:franchise_discount_amount] = booking.franchise_discount_amount.to_f
      data[:payment_status_label] = booking.payment_status_display
      data[:payment_method_label] = booking.payment_method_display
      data[:booking_date] = booking.booking_date
      data[:is_b2b] = booking.is_b2b
      data[:next_stages] = BookingStageUpdateService.stages_for(booking)
      data[:notes] = booking.notes
      data[:updated_at] = booking.updated_at
      data[:booked_by] = booking.booked_by
      data[:created_by] = booking.user && { id: booking.user_id, name: booking.user.try(:full_name).presence || booking.user.email }
      # Customer-app orders: the pickup store text, or nil for home delivery.
      data[:delivery_store] = booking.delivery_store
      data[:change_amount] = booking.change_amount&.to_f
      data[:wallet_transaction_ref] = booking.wallet_transaction&.reference_number
      data[:customer] = booking.customer && {
        id: booking.customer_id, name: booking.customer.display_name,
        mobile: booking.customer.mobile, email: booking.customer.email
      }
      data[:franchise_discount_type] = booking.franchise_discount_type
      data[:franchise_discount_value] = booking.franchise_discount_value&.to_f
      data[:franchise_wholesale_pricing] = wholesale
      data[:franchise_regular_total] = wholesale ? booking.franchise_regular_total.to_f : nil
      data[:franchise_commission_amount] = booking.franchise_commission_amount.to_f
      data[:franchise_commission_credited_at] = booking.franchise_commission_credited_at
      data[:invoice_generated] = booking.invoice_generated?
      data[:can_cancel] = booking.can_cancel?
    end

    data
  end
end
