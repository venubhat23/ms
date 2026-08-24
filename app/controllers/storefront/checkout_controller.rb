class Storefront::CheckoutController < Storefront::BaseController
  before_action :initialize_cart

  def show
    @cart_items = cart_items
    @cart_total = cart_total
    @collect_from_store_enabled = SystemSetting.collect_from_store_enabled?
    @available_stores = Store.available_for_collection if @collect_from_store_enabled

    redirect_to storefront_cart_path, alert: 'Your cart is empty.' if @cart_items.blank?
  end

  # JSON endpoint the checkout page's pincode "Check" button hits to look up
  # delivery availability/charge. Mirrors Customer::ShopController#check_delivery_pincode
  # (which requires customer login) but is reachable by guests.
  def check_pincode
    pincode = params[:pincode].to_s.strip
    if pincode.blank? || !pincode.match?(/\A\d{6}\z/)
      return render json: { success: false, message: 'Please enter a valid 6-digit pincode' }
    end

    charge_record = DeliveryCharge.for_pincode(pincode)
    if charge_record
      order_amount = cart_total
      min_for_free = charge_record.min_order_for_free_delivery.to_f
      effective_charge = charge_record.effective_charge_for(order_amount)
      amount_left_for_free_delivery = charge_record.free_delivery_allowed? && effective_charge > 0 ?
        (min_for_free - order_amount).round(2) : 0

      render json: {
        success: true,
        deliverable: true,
        delivery_charge: effective_charge,
        area: charge_record.area,
        free_delivery_allowed: charge_record.free_delivery_allowed?,
        min_order_for_free_delivery: min_for_free,
        amount_left_for_free_delivery: amount_left_for_free_delivery,
        order_amount: order_amount.round(2),
        message: effective_charge > 0 ?
          "Delivery charge: ₹#{effective_charge}" :
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

  # JSON endpoint the checkout page's "Place Order" button posts to. Mirrors
  # Customer::CheckoutController#cart_order's shape (redirect_url for COD,
  # payment_session_id for online) so the same Cashfree JS SDK flow used on
  # the customer checkout modal works here unchanged.
  def create
    if cart_items.blank?
      return render json: { success: false, error: 'Your cart is empty.' }, status: :unprocessable_entity
    end

    errors = guest_details_errors
    if errors.any?
      return render json: { success: false, error: errors.join(', ') }, status: :unprocessable_entity
    end

    booking_error = nil

    ActiveRecord::Base.transaction do
      @booking = Booking.new(
        customer: nil,
        booking_number: generate_booking_number,
        booking_date: Time.current,
        status: 'confirmed',
        payment_method: payment_method_key,
        customer_name: params[:guest_name].to_s.strip,
        customer_email: params[:guest_email].to_s.strip,
        customer_phone: params[:guest_phone].to_s.strip,
        delivery_address: delivery_address_text,
        booked_by: 'public',
        affiliate_id: referring_affiliate&.id
      )
      @booking.payment_status = :unpaid
      @booking.status = 'draft' if payment_method_key != 'cod'

      if params[:delivery_store_id].present?
        @booking.delivery_store = params[:delivery_store_id]
      elsif params[:pincode].present?
        charge_record = DeliveryCharge.for_pincode(params[:pincode].to_s.strip)
        unless charge_record
          booking_error = 'Delivery is not available for this pincode.'
          raise ActiveRecord::Rollback
        end
        @booking.shipping_charges = charge_record.effective_charge_for(cart_total)
      end

      product_ids = cart_items.map { |i| i['product_id'].to_i }.uniq
      products_by_id = Product.where(id: product_ids).index_by(&:id)

      cart_items.each do |item|
        product = products_by_id[item['product_id'].to_i]
        unless product
          booking_error = "Product no longer available: #{item['product_name']}"
          raise ActiveRecord::Rollback
        end

        quantity = item['quantity'].to_f
        unless product.can_fulfill_order?(quantity)
          booking_error = "Only #{product.available_quantity} units of #{product.name} available."
          raise ActiveRecord::Rollback
        end

        @booking.booking_items.build(product: product, quantity: quantity, price: product.selling_price)
      end

      unless @booking.save
        booking_error = @booking.errors.full_messages.join(', ')
        raise ActiveRecord::Rollback
      end
    end

    return render json: { success: false, error: booking_error || 'Failed to place order.' }, status: :unprocessable_entity if booking_error

    session[:cart] = { items: [] }
    session.delete(:referral_affiliate_code)

    if payment_method_key == 'cod'
      render json: {
        success: true,
        booking_number: @booking.booking_number,
        booking_id: @booking.id,
        redirect_url: confirmation_storefront_checkout_path(booking_id: @booking.id)
      }
    else
      cashfree_order_id = Booking.generate_cashfree_order_id
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

        render json: {
          success: true,
          booking_number: @booking.booking_number,
          booking_id: @booking.id,
          payment_session_id: order_data['payment_session_id'],
          redirect_to_payment: true
        }
      else
        @booking.mark_payment_failed!(response[:message])
        render json: { success: false, error: response[:message] || 'Payment gateway error. Please try again.' }, status: :unprocessable_entity
      end
    end
  rescue => e
    Rails.logger.error "Storefront checkout error: #{e.message}\n#{e.backtrace.join("\n")}"
    render json: { success: false, error: 'An unexpected error occurred. Please try again.' }, status: :internal_server_error
  end

  def confirmation
    @booking = Booking.includes(booking_items: :product).where(booked_by: 'public').find(params[:booking_id])
    @booking_items = @booking.booking_items
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Order not found.'
  end

  private

  def guest_details_errors
    errors = []
    errors << 'Name is required' if params[:guest_name].blank?
    errors << 'Email is required' if params[:guest_email].blank?
    errors << 'Enter a valid email address' if params[:guest_email].present? && !params[:guest_email].match?(URI::MailTo::EMAIL_REGEXP)
    errors << 'Phone number is required' if params[:guest_phone].blank?
    errors << 'Enter a valid 10-digit phone number' if params[:guest_phone].present? && !params[:guest_phone].to_s.gsub(/\D/, '').match?(/\A\d{10}\z/)

    if params[:delivery_option] != 'store_pickup'
      errors << 'Delivery address is required' if params[:address].blank?
      errors << 'City is required' if params[:city].blank?
      errors << 'Pincode is required' if params[:pincode].blank?
    end

    errors
  end

  def payment_method_key
    params[:payment_method] == 'online' ? 'cashfree' : 'cod'
  end

  def delivery_address_text
    return "Store Pickup#{": #{Store.find_by(id: params[:delivery_store_id])&.name}" if params[:delivery_store_id].present?}" if params[:delivery_option] == 'store_pickup'

    [
      params[:address],
      params[:landmark],
      [params[:city], params[:state], params[:pincode]].compact_blank.join(', ')
    ].compact_blank.join("\n")
  end

  def generate_booking_number
    "BK#{Date.current.strftime('%Y%m%d')}#{SecureRandom.hex(3).upcase}"
  end

  # Guest checkout has no Customer record to carry referred_by_affiliate_id,
  # so the affiliate captured by ApplicationController#capture_referral_code
  # is read directly from session here instead.
  def referring_affiliate
    code = session[:referral_affiliate_code]
    return nil if code.blank?

    Affiliate.active.find_by(affiliate_code: code)
  end
end
