class Affiliate::BookingsController < Affiliate::ApplicationController
  before_action :set_booking, only: [:show]

  def index
    @bookings = Booking.where(affiliate_id: current_affiliate.id)
                       .includes(:customer, booking_items: :product)
                       .order(created_at: :desc)

    if params[:status].present?
      @bookings = @bookings.where(status: params[:status])
    end

    if params[:search].present?
      q = "%#{params[:search]}%"
      @bookings = @bookings.joins(:customer).where(
        'booking_number ILIKE ? OR customers.first_name ILIKE ? OR customers.last_name ILIKE ? OR customers.mobile ILIKE ?',
        q, q, q, q
      )
    end

    affiliate_bookings = Booking.where(affiliate_id: current_affiliate.id)
    status_counts      = affiliate_bookings.group(:status).count
    @total_count       = status_counts.values.sum
    @pending_count     = status_counts['pending']   || 0
    @completed_count   = status_counts['completed'] || 0
    @total_value       = affiliate_bookings.sum(:total_amount).to_f

    @bookings = @bookings.page(params[:page]).per(20) if @bookings.respond_to?(:page)
  end

  def show
  end

  def new
    stock_subquery = StockBatch
      .select("product_id, SUM(quantity_remaining) AS total_stock")
      .where(status: 'active').where("quantity_remaining > 0")
      .group(:product_id)
      .to_sql

    products = Product.active
                      .joins("LEFT JOIN (#{stock_subquery}) AS batch_stock ON batch_stock.product_id = products.id")
                      .select(
                        "products.id, products.name, products.sku, products.category_id, " \
                        "products.has_multiple_quantities, products.r2_image_url, products.image_url, " \
                        "products.price, products.stock, products.display_order, " \
                        "COALESCE(batch_stock.total_stock, 0) AS cached_stock"
                      )
                      .includes(:category, :product_variants, image_attachment: :blob)
                      .by_stock_availability

    @products_json = products.map do |p|
      sorted_variants = p.has_multiple_quantities ? p.product_variants.sort_by { |v| [v.display_order.to_i, v.weight.to_f] } : []
      display_price   = sorted_variants.any? ? sorted_variants.first.selling_price.to_f : p.price.to_f
      {
        id:            p.id,
        name:          p.name,
        sku:           p.sku.to_s,
        category_id:   p.category_id&.to_s || '',
        category_name: p.category&.name || 'No Category',
        stock:         p.cached_total_batch_stock,
        has_variants:  p.has_multiple_quantities,
        image_url:     p.main_image_url,
        price:         display_price.round,
        variants:      sorted_variants.map { |v| { id: v.id, label: v.label.to_s, price: v.selling_price.to_f.round, stock: v.available_stock.to_f } }
      }
    end.to_json

    @customers = Rails.cache.fetch('affiliate_bookings/customers_picker', expires_in: 5.minutes) do
      Customer.order(:first_name).select(:id, :first_name, :middle_name, :last_name, :mobile).to_a
    end
  end

  def create
    customer_id = params[:customer_id].presence
    booking_items_data = params[:booking_items_attributes] || {}

    if customer_id.blank?
      flash[:alert] = 'Please select a customer.'
      redirect_to new_affiliate_booking_path and return
    end

    if booking_items_data.blank? || booking_items_data.values.all? { |i| i[:quantity].to_f <= 0 }
      flash[:alert] = 'Please add at least one product.'
      redirect_to new_affiliate_booking_path and return
    end

    customer = Customer.find_by(id: customer_id)
    unless customer
      flash[:alert] = 'Customer not found.'
      redirect_to new_affiliate_booking_path and return
    end

    subtotal = booking_items_data.values.sum { |i| i[:price].to_f * i[:quantity].to_f }
    discount = params[:discount_amount].to_f
    total    = [subtotal - discount, 0].max

    booking = Booking.new(
      customer:        customer,
      customer_name:   customer.full_name,
      customer_phone:  customer.mobile,
      customer_email:  customer.email,
      affiliate_id:    current_affiliate.id,
      booked_by:       'affiliate',
      skip_stock_check: true,
      user_id:         current_user.id,
      status:          'completed',
      payment_method:  params[:payment_method].presence || 'cash',
      payment_status:  params[:payment_status].presence || 'paid',
      subtotal:        subtotal,
      discount_amount: discount,
      total_amount:    total,
      notes:           params[:notes].to_s.strip,
      booking_date:    Time.current
    )

    booking_items_data.each_value do |item|
      qty   = item[:quantity].to_f
      price = item[:price].to_f
      next if qty <= 0 || item[:product_id].blank?

      booking.booking_items.build(
        product_id:          item[:product_id],
        product_variant_id:  item[:product_variant_id].presence,
        quantity:            qty,
        price:               price
      )
    end

    if booking.save
      redirect_to affiliate_booking_path(booking), notice: 'Booking created successfully!'
    else
      flash[:alert] = booking.errors.full_messages.join(', ')
      redirect_to new_affiliate_booking_path
    end
  end

  private

  def set_booking
    @booking = Booking.where(affiliate_id: current_affiliate.id).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to affiliate_bookings_path, alert: 'Booking not found.'
  end
end
