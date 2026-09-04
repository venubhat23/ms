class Customer::CheckoutController < Customer::BaseController
  before_action :initialize_cart
  before_action :check_cart_not_empty, except: [:confirmation, :cart_order]

  def show
    @cart_items = @cart[:items] || []
    @cart_total = calculate_cart_total
    @addresses = current_customer.customer_addresses || []
  end

  def address
    @addresses = current_customer.customer_addresses || []
    @new_address = CustomerAddress.new
  end

  def create_address
    @new_address = current_customer.customer_addresses.build(address_params)

    if @new_address.save
      redirect_to customer_checkout_payment_path, notice: 'Address added successfully!'
    else
      @addresses = current_customer.customer_addresses
      render :address
    end
  end

  def payment
    @cart_items = @cart[:items] || []
    @cart_total = calculate_cart_total
    @selected_address = find_selected_address

    if @selected_address.nil?
      redirect_to customer_checkout_address_path, alert: 'Please select a delivery address.'
      return
    end

    # Load collect from store settings and available stores
    @collect_from_store_enabled = SystemSetting.collect_from_store_enabled?
    @available_stores = Store.available_for_collection if @collect_from_store_enabled
    @selected_store = find_selected_store if @collect_from_store_enabled
  end

  def create
    Rails.logger.info "=== CHECKOUT CREATE ACTION CALLED ==="
    Rails.logger.info "Params: #{params.inspect}"
    Rails.logger.info "Session cart: #{session[:cart].inspect}"

    @selected_address = find_selected_address

    if @selected_address.nil?
      Rails.logger.error "No selected address found"
      redirect_to customer_checkout_address_path, alert: 'Please select a delivery address.'
      return
    end

    Rails.logger.info "Selected address: #{@selected_address.inspect}"

    # Check store selection if collect from store is enabled
    @collect_from_store_enabled = SystemSetting.collect_from_store_enabled?
    @selected_store = find_selected_store if @collect_from_store_enabled

    # Check delivery store if delivery only at shop is enabled
    if SystemSetting.delivery_only_at_shop_enabled?
      delivery_store = params[:delivery_store] || session[:delivery_store]
      if delivery_store.blank?
        redirect_to customer_checkout_path, alert: 'Please select a pickup location.'
        return
      end
      session[:delivery_store] = delivery_store
    end

    # Create booking/order
    begin
      ActiveRecord::Base.transaction do
        @booking = create_booking

        if @booking && @booking.persisted?
          # Clear cart
          session[:cart] = { items: [] }
          redirect_to customer_checkout_confirmation_path(booking_id: @booking.id)
        else
          error_message = @booking ? "Booking creation failed: #{@booking.errors.full_messages.join(', ')}" : "Booking creation failed: Invalid cart or product data"
          Rails.logger.error error_message
          raise ActiveRecord::Rollback
        end
      end
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error "Booking validation error: #{e.message}"
      @cart_items = @cart[:items] || []
      @cart_total = calculate_cart_total
      @available_stores = Store.available_for_collection if @collect_from_store_enabled
      flash.now[:alert] = "Failed to process order: #{e.message}"
      render :payment
    rescue ActiveRecord::Rollback
      @cart_items = @cart[:items] || []
      @cart_total = calculate_cart_total
      @available_stores = Store.available_for_collection if @collect_from_store_enabled
      flash.now[:alert] = 'Failed to process order. Please try again.'
      render :payment
    rescue => e
      Rails.logger.error "Unexpected error in checkout: #{e.message}\n#{e.backtrace.join('\n')}"
      @cart_items = @cart[:items] || []
      @cart_total = calculate_cart_total
      @available_stores = Store.available_for_collection if @collect_from_store_enabled
      flash.now[:alert] = 'An unexpected error occurred. Please try again.'
      render :payment
    end
  end

  def confirmation
    @booking = current_customer.bookings.includes(booking_items: :product).find(params[:booking_id])
    @booking_items = @booking.booking_items
  rescue ActiveRecord::RecordNotFound
    redirect_to customer_orders_path, alert: 'Order not found.'
  end

  def cart_order
    Rails.logger.info "=== CART ORDER API CALLED ==="
    Rails.logger.info "Params: #{params.inspect}"

    begin
      # Extract cart data from params (already parsed by Rails)
      cart_items = params[:cart_data]
      Rails.logger.info "Cart items: #{cart_items.inspect}"

      # Validate required fields
      if cart_items.blank?
        render json: { success: false, error: 'Cart is empty' }, status: 400
        return
      end

      # Capture rollback reason — ActiveRecord::Rollback is swallowed inside
      # the transaction block and never reaches the outer rescue, so we track
      # the error in a local variable and render after the transaction.
      booking_error = nil

      # Create booking from frontend cart data
      ActiveRecord::Base.transaction do
        # Create booking attributes (similar to admin bookings controller)
        booking_attributes = {
          customer: current_customer,
          booking_number: generate_booking_number,
          booking_date: Time.current,
          status: 'confirmed',
          payment_method: params[:payment_method] || 'cod',
          customer_name: params[:customer_name] || current_customer.display_name,
          customer_email: params[:customer_email] || current_customer.email,
          customer_phone: params[:customer_phone] || current_customer.mobile,
          delivery_address: params[:delivery_address],
          booked_by: 'customer'
        }

        if params[:delivery_store].present?
          booking_attributes[:delivery_store] = params[:delivery_store]
        end
        if params[:selected_shop_address].present?
          booking_attributes[:selected_shop_address] = params[:selected_shop_address]
        end
        if params[:customer_address_id].present?
          addr = current_customer.customer_addresses.find_by(id: params[:customer_address_id])
          if addr
            booking_attributes[:delivery_address] = [addr.address, addr.city, addr.state, addr.pincode].compact.join(', ')
          end
        end

        @booking = Booking.new(booking_attributes)
        @booking.payment_status = :unpaid

        # Set shipping charges before save so before_validation:calculate_totals picks it up
        delivery_charge = params[:delivery_charge].to_f
        @booking.shipping_charges = delivery_charge if delivery_charge > 0

        # For online payments, hold as draft until payment completes
        @booking.status = 'draft' if params[:payment_method] != 'cod'
        # Pre-booking: let the order through even at 0 stock.
        @booking.skip_stock_check = true if SystemSetting.allow_pre_booking_enabled?

        # Pre-load all products in ONE query (was N separate Product.find calls)
        product_ids = cart_items.map { |i| (i[:id] || i['id']).to_i }
        products_by_id = Product.where(id: product_ids).includes(:product_variants).index_by(&:id)

        # Build booking items — pass product object so calculate_totals has associations in memory
        cart_items.each do |item|
          product_id = (item[:id] || item['id']).to_i
          product = products_by_id[product_id]
          unless product
            booking_error = "Product not found: #{product_id}"
            Rails.logger.error booking_error
            raise ActiveRecord::Rollback
          end

          raw_variant = item[:variantId] || item['variantId'] || item[:variant_id] || item['variant_id']
          variant = raw_variant.present? ? product.product_variants.find { |v| v.id == raw_variant.to_i } : nil

          quantity = (item[:quantity] || item['quantity']).to_f
          price    = (item[:price]    || item['price']).to_f
          price    = (variant ? variant.effective_price : product.selling_price).to_f if price <= 0

          @booking.booking_items.build(product: product, product_variant: variant, quantity: quantity, price: price)
          Rails.logger.info "Added booking item: #{product.name}#{" (#{variant.label})" if variant} x #{quantity} @ ₹#{price}"
        end

        # Single save — before_validation :calculate_totals fires automatically
        if @booking.save
          Rails.logger.info "Booking created successfully: #{@booking.booking_number}"
          Rails.logger.info "Total amount: ₹#{@booking.total_amount}"
          Rails.logger.info "Payment method: #{params[:payment_method]}"

          if params[:payment_method] == 'cod'
            # COD — status is already 'confirmed', no extra update needed
            render json: {
              success: true,
              message: 'Order placed successfully! Pay on delivery.',
              booking_number: @booking.booking_number,
              booking_id: @booking.id,
              total_amount: @booking.total_amount,
              payment_method: 'cod',
              redirect_url: customer_orders_path
            }
          else
            # Online Payment — Cashfree
            Rails.logger.info "🚀 Initiating Cashfree payment for booking #{@booking.id}"

            cashfree_order_id = Booking.generate_cashfree_order_id

            # Combine cashfree_order_id + mark_payment_initiated into ONE update
            @booking.update!(
              cashfree_order_id: cashfree_order_id,
              payment_gateway: 'cashfree',
              payment_initiated_at: Time.current,
              payment_status: 'unpaid'
            )

            response = CashfreeService.create_order(@booking)

            if response[:success]
              order_data = response[:data]
              @booking.update!(payment_session_id: order_data['payment_session_id'])

              Rails.logger.info "✅ Cashfree order created: #{order_data['order_id']}"

              render json: {
                success: true,
                message: 'Redirecting to payment gateway...',
                booking_number: @booking.booking_number,
                booking_id: @booking.id,
                total_amount: @booking.total_amount,
                payment_method: 'cashfree',
                payment_session_id: order_data['payment_session_id'],
                cashfree_order_id: cashfree_order_id,
                redirect_to_payment: true
              }
            else
              @booking.mark_payment_failed!(response[:message])
              Rails.logger.error "❌ Cashfree order creation failed: #{response[:message]}"

              render json: {
                success: false,
                error: response[:message] || 'Payment gateway error. Please try again.',
                booking_id: @booking.id
              }, status: 422
            end
          end
        else
          booking_error = @booking.errors.full_messages.join(', ')
          Rails.logger.error "Booking creation failed: #{booking_error}"
          raise ActiveRecord::Rollback
        end
      end

      # Render error if the transaction rolled back without rendering anything
      unless performed?
        render json: { success: false, error: booking_error || 'Failed to create order' }, status: 422
      end

    rescue => e
      Rails.logger.error "Unexpected error in cart_order: #{e.message}\n#{e.backtrace.join('\n')}"
      render json: { success: false, error: 'An unexpected error occurred' }, status: 500
    end
  end

  private

  def initialize_cart
    @cart = session[:cart] ||= { items: [] }
  end

  def check_cart_not_empty
    if @cart[:items].blank?
      redirect_to customer_products_path, alert: 'Your cart is empty.'
    end
  end

  def calculate_cart_total
    @cart[:items].sum { |item| item['price'].to_f * item['quantity'].to_f }
  end

  def find_selected_address
    address_id = params[:selected_address_id] || session[:selected_address_id]
    return nil if address_id.blank?

    current_customer.customer_addresses.find_by(id: address_id)
  end

  def find_selected_store
    store_id = params[:selected_store_id] || session[:selected_store_id]
    return nil if store_id.blank?

    Store.available_for_collection.find_by(id: store_id)
  end

  def create_booking
    # Validate cart items
    if @cart[:items].blank?
      Rails.logger.error "Empty cart items during booking creation"
      return nil
    end

    Rails.logger.info "Creating booking with cart items: #{@cart[:items].inspect}"

    # Normalise payment method from form to valid enum key
    raw_pm = params[:payment_method].to_s.strip
    payment_method_key = %w[card upi bank_transfer online cashfree cloudflare].include?(raw_pm) ? raw_pm : 'cod'

    # Create booking with minimal attributes first (like admin controller)
    booking_attributes = {
      customer: current_customer,
      booking_number: generate_booking_number,
      booking_date: Time.current,
      status: 'confirmed',
      payment_method: payment_method_key,
      customer_name: current_customer.full_name || current_customer.first_name,
      customer_email: current_customer.email,
      customer_phone: current_customer.mobile,
      delivery_address: format_delivery_address
    }

    # Add store selection if collect from store is enabled
    if SystemSetting.collect_from_store_enabled? && @selected_store
      booking_attributes[:store_id] = @selected_store.id
    end

    # Add delivery store if delivery only at shop is enabled
    if SystemSetting.delivery_only_at_shop_enabled?
      delivery_store = params[:delivery_store] || session[:delivery_store]
      if delivery_store.present?
        booking_attributes[:delivery_store] = delivery_store
      end
    end

    booking = Booking.new(booking_attributes)
    booking.payment_status = :unpaid  # set before save so before_validation picks it up
    # Pre-booking: let the order through even at 0 stock.
    booking.skip_stock_check = true if SystemSetting.allow_pre_booking_enabled?

    # Pre-load all cart products in ONE query instead of N separate finds
    product_ids = @cart[:items].map { |i| i['product_id'].to_i }.uniq
    products_by_id = Product.where(id: product_ids).includes(:product_variants).index_by(&:id)

    # Build booking items — pass product object so calculate_totals has associations in memory
    @cart[:items].each do |item|
      product = products_by_id[item['product_id'].to_i]
      unless product
        Rails.logger.error "Product not found: #{item['product_id']}"
        return nil
      end

      variant_id = item['variant_id'].presence&.to_i
      variant = variant_id ? product.product_variants.find { |v| v.id == variant_id } : nil

      quantity = item['quantity'].to_f
      price    = (item['price'].presence || (variant ? variant.effective_price : product.selling_price)).to_f

      booking.booking_items.build(product: product, product_variant: variant, quantity: quantity, price: price)
      Rails.logger.info "Added booking item: #{product.name}#{" (#{variant.label})" if variant} x #{quantity} @ ₹#{price}"
    end

    # Single save — before_validation :calculate_totals fires automatically
    if booking.save!
      # Force payment_method to DB directly — bypasses integer-enum/string-column Rails quirk
      booking.update_column(:payment_method, payment_method_key)

      Rails.logger.info "Booking created successfully: #{booking.booking_number}"
      Rails.logger.info "Booking totals - Subtotal: #{booking.subtotal}, Tax: #{booking.tax_amount}, Total: #{booking.total_amount}"

      booking
    end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Booking creation failed: #{e.message}"
    nil
  end


  def generate_booking_number
    "BK#{Date.current.strftime('%Y%m%d')}#{rand(1000..9999)}"
  end


  def format_delivery_address
    return '' unless @selected_address

    "#{@selected_address.name}\n#{@selected_address.address}\n#{@selected_address.landmark}\n#{@selected_address.city}, #{@selected_address.state} - #{@selected_address.pincode}\nMobile: #{@selected_address.mobile}"
  end

  def address_params
    params.require(:customer_address).permit(
      :name, :mobile, :address_type, :address, :landmark,
      :city, :state, :pincode, :is_default
    )
  end
end