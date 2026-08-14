class Customer::ShopController < Customer::BaseController
  def index
    @booking = Booking.new
    @booking.booking_items.build

    # Cache categories — they rarely change
    @categories = Rails.cache.fetch('shop:categories', expires_in: 10.minutes) do
      Category.where(status: true).order(:display_order, :name).to_a
    end

    if params[:search].blank? && params[:category_id].blank?
      # Cache the full unfiltered product list (stock refreshes every 3 min via stock_data AJAX)
      @products = Rails.cache.fetch('shop:products:all', expires_in: 3.minutes) do
        build_shop_product_scope.to_a
      end
    else
      @products = build_shop_product_scope(
        search: params[:search],
        category_id: params[:category_id]
      ).to_a
    end

    @customer_addresses = current_customer&.customer_addresses || []
  end

  def category
    @category = Category.find(params[:id])
    @products = @category.products.where(status: 'active')

    # Apply same filtering logic as index
    if params[:search].present?
      @search_query = params[:search]
      @products = @products.where("name ILIKE ? OR description ILIKE ?",
                                  "%#{params[:search]}%", "%#{params[:search]}%")
    end

    # Price range filter
    if params[:min_price].present?
      @products = @products.where("price >= ?", params[:min_price].to_f)
    end

    if params[:max_price].present?
      @products = @products.where("price <= ?", params[:max_price].to_f)
    end

    # Sorting
    case params[:sort]
    when 'price_low'
      @products = @products.order(:price)
    when 'price_high'
      @products = @products.order(price: :desc)
    when 'name'
      @products = @products.order(:name)
    when 'newest'
      @products = @products.order(created_at: :desc)
    else
      @products = @products.by_stock_availability
    end

    @products = @products.page(params[:page]).per(12)
  end

  def product
    # :approved_reviews preloaded so total_reviews (used in the view) hits
    # the model's "loaded?" fast path instead of a fresh COUNT query.
    @product = Product.includes(:category, :approved_reviews, image_attachment: :blob).find(params[:id])
    @available_stock = @product.total_batch_stock
    @related_products = Product.where(category_id: @product.category_id)
                               .where.not(id: @product.id)
                               .where(status: 'active')
                               .includes(:category, image_attachment: :blob)
                               .limit(4)
  end

  def success
    @booking = current_customer&.bookings&.includes(booking_items: { product: :category })&.find_by(booking_number: params[:booking_id])

    unless @booking
      flash[:error] = 'Order not found.'
      redirect_to customer_shop_path and return
    end
  end

  def stock_data
    stock_sq = StockBatch.where(status: 'active')
                         .select("product_id, SUM(quantity_remaining) AS total_stock")
                         .group(:product_id)

    products = Product.active
                      .select("products.id, products.has_multiple_quantities, COALESCE(sq.total_stock, 0) AS cached_stock")
                      .joins("LEFT JOIN (#{stock_sq.to_sql}) sq ON sq.product_id = products.id")
                      .includes(:product_variants)

    data = products.map do |p|
      stock = p.cached_stock.to_f
      {
        id: p.id,
        stock: stock,
        in_stock: stock > 0,
        variants: p.product_variants.map { |v| { id: v.id, stock: v.available_stock.to_f } }
      }
    end
    render json: { success: true, products: data }
  end

  def check_delivery_pincode
    pincode = params[:pincode].to_s.strip
    if pincode.blank? || !pincode.match?(/\A\d{6}\z/)
      return render json: { success: false, message: 'Please enter a valid 6-digit pincode' }
    end

    charge_record = DeliveryCharge.for_pincode(pincode)
    if charge_record
      render json: {
        success: true,
        deliverable: true,
        delivery_charge: charge_record.charge_amount.to_f,
        area: charge_record.area,
        free_delivery_allowed: charge_record.free_delivery_allowed?,
        min_order_for_free_delivery: charge_record.min_order_for_free_delivery.to_f,
        message: charge_record.charge_amount.to_f > 0 ?
          "Delivery charge: ₹#{charge_record.charge_amount}" :
          'Free delivery available'
      }
    else
      render json: {
        success: true,
        deliverable: false,
        delivery_charge: 0,
        free_delivery_allowed: false,
        min_order_for_free_delivery: 0,
        message: 'Delivery not available to this pincode'
      }
    end
  end

  def cart_order
    # Create order from cart data
    cart_data = params[:cart_items] || []

    if cart_data.empty?
      render json: { error: 'Cart is empty' }, status: :unprocessable_entity
      return
    end

    begin
      ActiveRecord::Base.transaction do
        # Initialize booking with minimal attributes to avoid callbacks
        @booking = Booking.new
        @booking.customer = current_customer
        @booking.booking_date = Time.current
        @booking.customer_name = current_customer&.display_name
        @booking.customer_email = current_customer&.email
        @booking.customer_phone = current_customer&.mobile
        @booking.payment_method = params[:payment_method] || 'cod'

        # Create booking items from cart
        total_amount = 0
        cart_data.each do |item_data|
          product = Product.find(item_data[:product_id])
          quantity = item_data[:quantity].to_f
          price = item_data[:price].to_f

          # Validate stock
          if !product.can_fulfill_order?(quantity)
            render json: {
              error: "Insufficient stock for #{product.name}. Only #{product.available_quantity} available."
            }, status: :unprocessable_entity
            return
          end

          # Create booking item
          booking_item = @booking.booking_items.build(
            product: product,
            quantity: quantity,
            price: price
          )

          total_amount += (price * quantity)
        end

        # Set totals
        @booking.subtotal = total_amount
        @booking.total_amount = total_amount

        # Set status after all other attributes
        @booking.status = 'confirmed'
        @booking.payment_status = 'unpaid'

        @booking.save!

        render json: {
          success: true,
          booking_number: @booking.booking_number,
          redirect_url: customer_shop_success_path(booking_id: @booking.booking_number)
        }
      end

    rescue => e
      render json: { error: "Failed to create order: #{e.message}" }, status: :internal_server_error
    end
  end

  def create_booking
    # Initialize booking with customer information
    @booking = Booking.new(booking_params)
    @booking.customer = current_customer
    @booking.booking_date = Date.current

    # Handle customer information from form
    @booking.customer_name = params.dig(:booking, :customer_name) || current_customer&.display_name
    @booking.customer_email = params.dig(:booking, :customer_email) || current_customer&.email
    @booking.customer_phone = params.dig(:booking, :customer_phone) || current_customer&.mobile

    # Set initial status and payment status
    @booking.status = 'confirmed'
    @booking.payment_status = 'unpaid' # Default to unpaid, can be updated based on payment method

    begin
      if params[:booking_items].present?
        # Collect valid items first
        valid_items = params[:booking_items].values.select { |i| i[:quantity].to_f > 0 }

        if valid_items.any?
          # Pre-load ALL products in ONE query (was N separate Product.find calls)
          product_ids = valid_items.map { |i| i[:product_id].to_i }.uniq
          products_by_id = Product.where(id: product_ids).index_by(&:id)

          # Pre-load ALL stock in ONE query (was N separate stock_batches queries)
          stock_by_product = StockBatch.where(status: 'active', product_id: product_ids)
                                       .group(:product_id)
                                       .sum(:quantity_remaining)

          ActiveRecord::Base.transaction do
            valid_items.each do |item_data|
              quantity = item_data[:quantity].to_f
              product  = products_by_id[item_data[:product_id].to_i]

              unless product
                flash[:error] = "Product not found."
                redirect_to customer_shop_path and return
              end

              available_stock = stock_by_product[product.id] || 0
              if quantity > available_stock
                flash[:error] = "Insufficient stock for #{product.name}. Only #{available_stock.to_i} available."
                redirect_to customer_shop_path and return
              end

              # Pass product object (not product_id) so calculate_totals has association in memory
              @booking.booking_items.build(product: product, quantity: quantity, price: item_data[:price].to_f)
            end

            # Single save — before_validation :calculate_totals runs automatically
            @booking.save!

            redirect_to customer_shop_success_path(booking_id: @booking.booking_number)
          end
        else
          flash[:error] = 'Please add items to your cart before placing the order.'
          redirect_to customer_shop_path
        end
      else
        flash[:error] = 'No items found in your cart. Please add items before placing an order.'
        redirect_to customer_shop_path
      end

    rescue ActiveRecord::RecordInvalid => e
      flash[:error] = "Order could not be placed: #{e.record.errors.full_messages.join(', ')}"
      redirect_to customer_shop_path

    rescue StandardError => e
      Rails.logger.error "Checkout Error: #{e.message}\n#{e.backtrace.join("\n")}"
      flash[:error] = 'An error occurred while processing your order. Please try again.'
      redirect_to customer_shop_path
    end
  end

  private

  def build_shop_product_scope(search: nil, category_id: nil)
    stock_sq = StockBatch.where(status: 'active')
                         .select("product_id, SUM(quantity_remaining) AS total_stock")
                         .group(:product_id)

    scope = Product.active
                   .select("products.*, COALESCE(sq.total_stock, 0) AS cached_stock")
                   .joins("LEFT JOIN (#{stock_sq.to_sql}) sq ON sq.product_id = products.id")
                   .includes(:category, :product_variants, image_attachment: :blob)
                   .order(Arel.sql(
                     "CASE WHEN COALESCE(sq.total_stock, 0) > 0 THEN 0 ELSE 1 END ASC," \
                     " products.display_order ASC NULLS LAST, products.name ASC"
                   ))

    if search.present?
      term = "%#{search}%"
      scope = scope.joins(:category)
                   .where("products.name ILIKE ? OR products.sku ILIKE ? OR categories.name ILIKE ?",
                          term, term, term)
    end

    scope = scope.where(category_id: category_id) if category_id.present? && category_id != ''
    scope
  end

  def booking_params
    params.require(:booking).permit(
      :customer_name, :customer_email, :customer_phone,
      :delivery_address, :notes, :payment_method,
      :booking_date, :discount_amount
    )
  end
end