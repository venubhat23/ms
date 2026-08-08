class Api::V1::Admin::BookingsController < Api::V1::Admin::BaseController
  # GET /api/v1/admin/bookings
  def index
    bookings = Booking.includes(:customer)
    bookings = bookings.where(status: params[:status]) if params[:status].present?
    bookings = bookings.order(created_at: :desc)

    page = params[:page] || 1
    per_page = params[:per_page] || 20
    bookings = bookings.page(page).per(per_page)

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
    booking = Booking.includes(:customer, booking_items: :product).find(params[:id])
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

  private

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
      created_at: booking.created_at
    }

    if detailed
      data[:items] = booking.booking_items.map do |item|
        {
          id: item.id,
          product_id: item.product_id,
          product_name: item.product&.name,
          quantity: item.quantity,
          price: item.price.to_f
        }
      end
      data[:subtotal] = booking.subtotal.to_f
      data[:tax_amount] = booking.tax_amount.to_f
      data[:discount_amount] = booking.discount_amount&.to_f || 0
      data[:notes] = booking.notes
    end

    data
  end
end
