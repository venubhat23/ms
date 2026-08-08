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
