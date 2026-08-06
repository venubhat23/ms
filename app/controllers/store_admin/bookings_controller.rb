class StoreAdmin::BookingsController < StoreAdmin::ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :update_status, :cancel]

  def index
    @bookings = @current_store.bookings.order(created_at: :desc).includes(:customer, booking_items: :product)

    if params[:status].present?
      @bookings = @bookings.where(status: params[:status])
    end

    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @bookings = @bookings.joins(:customer)
                           .where('customers.first_name ILIKE ? OR customers.last_name ILIKE ? OR bookings.booking_number ILIKE ?',
                                  search_term, search_term, search_term)
    end

    if params[:date_from].present? && params[:date_to].present?
      @bookings = @bookings.where(created_at: params[:date_from].to_date..params[:date_to].to_date.end_of_day)
    end

    @bookings = @bookings.page(params[:page]).per(20) if @bookings.respond_to?(:page)
    @summary = calculate_bookings_summary
  end

  def show
    @can_update_status = booking_belongs_to_store?(@booking)
    @available_statuses = available_next_statuses(@booking)
  end

  def new
    @booking = @current_store.bookings.build
    @customers = Customer.order(:first_name) rescue []

    # One query for all store stock (eliminates N+1 from available_stock_for)
    store_stock_map = @current_store.stock_batches
                                    .where(status: 'active')
                                    .where('quantity_remaining > 0')
                                    .group(:product_id)
                                    .sum(:quantity_remaining)

    products = Product.active
                      .where(id: store_stock_map.keys)
                      .select(
                        "id, name, sku, category_id, has_multiple_quantities, " \
                        "r2_image_url, image_url, price, gst_enabled, gst_percentage, " \
                        "stock, display_order"
                      )
                      .includes(:category, :product_variants)
                      .by_stock_availability

    @products_json = products.map do |p|
      store_stock = store_stock_map[p.id].to_f
      sorted_variants = p.has_multiple_quantities ? p.product_variants.sort_by { |v| [v.display_order.to_i, v.weight.to_f] } : []

      if sorted_variants.any?
        default_v     = sorted_variants.first
        display_price = default_v.selling_price.to_f
        gst_rate      = 0
        base_price    = display_price
      else
        display_price = p.price.to_f
        gst_rate      = (p.gst_enabled && p.gst_percentage.to_f > 0) ? p.gst_percentage.to_f : 0
        base_price    = gst_rate > 0 ? (display_price - display_price * gst_rate / 100.0).round(2) : display_price
      end

      {
        id:            p.id,
        name:          p.name,
        sku:           p.sku.to_s,
        category_id:   p.category_id&.to_s || '',
        category_name: p.category&.name || 'No Category',
        stock:         store_stock,
        has_variants:  p.has_multiple_quantities,
        image_url:     p.r2_image_url.presence || p.image_url.presence,
        price:         display_price.round,
        base_price:    base_price.round(2),
        gst_rate:      gst_rate,
        variants:      sorted_variants.map { |v| { id: v.id, label: v.label.to_s, price: v.selling_price.to_f.round, stock: store_stock } }
      }
    end.to_json
  end

  def search_products
    q = params[:q].to_s.strip
    products = Product.active.where('name ILIKE ?', "%#{q}%").limit(15)
    render json: products.map { |p|
      store_stock = @current_store.available_stock_for(p.id)
      {
        id: p.id,
        name: p.name,
        sku: p.sku,
        price: p.price.to_f,
        store_stock: store_stock.to_f,
        unit_type: p.unit_type,
        has_variants: p.has_multiple_quantities?,
        variants: p.has_multiple_quantities? ? p.product_variants.order(:display_order, :weight).map { |v|
          { id: v.id, label: "#{v.weight} #{v.unit}", price: v.selling_price.to_f, stock: v.available_stock.to_f }
        } : []
      }
    }
  end

  def create
    @booking = @current_store.bookings.build(booking_params)
    @booking.user = current_user if @booking.respond_to?(:user=)
    @booking.status = 'completed'

    if @booking.save
      redirect_to store_admin_booking_path(@booking), notice: 'Booking created successfully.'
    else
      @customers = Customer.order(:first_name) rescue []
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @customers = Customer.order(:first_name) rescue []
  end

  def update
    if @booking.update(booking_params)
      redirect_to store_admin_booking_path(@booking), notice: 'Booking updated successfully.'
    else
      @customers = Customer.order(:first_name) rescue []
      render :edit, status: :unprocessable_entity
    end
  end

  def update_status
    new_status = params[:new_status]
    if @booking.update(status: new_status)
      redirect_to store_admin_booking_path(@booking), notice: "Status updated to #{new_status.humanize}."
    else
      redirect_to store_admin_booking_path(@booking), alert: 'Failed to update status.'
    end
  end

  def cancel
    reason = params[:cancellation_reason]
    if @booking.update(status: 'cancelled', cancellation_reason: reason)
      redirect_to store_admin_bookings_path, notice: 'Booking cancelled successfully.'
    else
      redirect_to store_admin_booking_path(@booking), alert: 'Failed to cancel booking.'
    end
  end

  private

  def set_booking
    @booking = @current_store.bookings.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(
      :customer_id, :notes, :payment_method, :payment_status, :discount_amount, :status,
      booking_items_attributes: [:id, :product_id, :product_variant_id, :quantity, :price, :_destroy]
    )
  end

  def booking_belongs_to_store?(booking)
    booking.store_id == @current_store.id
  end

  def available_next_statuses(booking)
    all_statuses = Booking.statuses.keys rescue []
    all_statuses - [booking.status]
  end

  def calculate_bookings_summary
    base = @current_store.bookings
    status_counts = base.group(:status).count

    {
      total_bookings: status_counts.values.sum,
      pending_bookings: status_counts.values_at('draft', 'ordered_and_delivery_pending', 'confirmed').compact.sum,
      processing_bookings: status_counts.values_at('processing', 'packed', 'shipped', 'out_for_delivery').compact.sum,
      completed_bookings: status_counts.values_at('delivered', 'completed').compact.sum,
      cancelled_bookings: status_counts.values_at('cancelled', 'returned').compact.sum,
      today_revenue: base.where(created_at: Date.current.beginning_of_day..Date.current.end_of_day)
                         .where.not(status: ['cancelled', 'returned']).sum(:total_amount),
      month_revenue: base.where(created_at: Date.current.beginning_of_month..Date.current.end_of_day)
                         .where.not(status: ['cancelled', 'returned']).sum(:total_amount)
    }
  end
end
