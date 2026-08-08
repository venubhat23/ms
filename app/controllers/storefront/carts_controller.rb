class Storefront::CartsController < Storefront::BaseController
  before_action :initialize_cart

  def show
    @cart_items = cart_items
    @cart_total = cart_total
  end

  def add_item
    product = Product.active.find(params[:product_id])
    quantity = params[:quantity].to_i
    quantity = 1 if quantity <= 0

    unless product.can_fulfill_order?(quantity)
      return render json: { success: false, error: "Only #{product.available_quantity} units available in stock." }, status: :unprocessable_entity
    end

    existing_item = @cart[:items].find { |item| item['product_id'] == product.id }

    if existing_item
      new_quantity = existing_item['quantity'] + quantity
      unless product.can_fulfill_order?(new_quantity)
        return render json: { success: false, error: "Cannot add more items. Only #{product.available_quantity} units available." }, status: :unprocessable_entity
      end
      existing_item['quantity'] = new_quantity
    else
      @cart[:items] << {
        'product_id' => product.id,
        'product_name' => product.name,
        'price' => product.selling_price,
        'quantity' => quantity,
        'image_url' => product.main_image_url
      }
    end

    save_cart
    render json: { success: true, cart_count: cart_count, cart_total: cart_total }
  rescue ActiveRecord::RecordNotFound
    render json: { success: false, error: 'Product not found.' }, status: :not_found
  end

  def update_item
    product_id = params[:product_id].to_i
    quantity = params[:quantity].to_i
    item = @cart[:items].find { |i| i['product_id'] == product_id }

    if item.nil?
      return render json: { success: false, error: 'Item not found in cart.' }, status: :not_found
    end

    if quantity <= 0
      @cart[:items].reject! { |i| i['product_id'] == product_id }
      save_cart
      return render json: { success: true, cart_count: cart_count, cart_total: cart_total }
    end

    product = Product.find(product_id)
    unless product.can_fulfill_order?(quantity)
      return render json: { success: false, error: "Only #{product.available_quantity} units available." }, status: :unprocessable_entity
    end

    item['quantity'] = quantity
    save_cart
    render json: { success: true, cart_count: cart_count, cart_total: cart_total }
  end

  def remove_item
    product_id = params[:product_id].to_i
    @cart[:items].reject! { |item| item['product_id'] == product_id }
    save_cart
    render json: { success: true, cart_count: cart_count, cart_total: cart_total }
  end

  def clear
    @cart[:items] = []
    save_cart
    render json: { success: true, cart_count: 0, cart_total: 0 }
  end
end
