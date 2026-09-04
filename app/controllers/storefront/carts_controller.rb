class Storefront::CartsController < Storefront::BaseController
  before_action :initialize_cart

  def show
    @cart_items = cart_items
    @cart_total = cart_total
  end

  def add_item
    product = Product.active.find(params[:product_id])
    variant = resolve_variant(product, params[:variant_id])
    quantity = params[:quantity].to_i
    quantity = 1 if quantity <= 0

    if product.has_multiple_quantities? && variant.nil?
      return render json: { success: false, error: 'Please choose an option before adding to cart.' }, status: :unprocessable_entity
    end

    unless product.can_fulfill_order?(quantity, variant_id: variant&.id)
      return render json: { success: false, error: "Only #{available_label(product, variant)} available in stock." }, status: :unprocessable_entity
    end

    existing_item = cart_items.find { |item| same_line?(item, product.id, variant&.id) }

    if existing_item
      new_quantity = existing_item['quantity'].to_i + quantity
      unless product.can_fulfill_order?(new_quantity, variant_id: variant&.id)
        return render json: { success: false, error: "Cannot add more items. Only #{available_label(product, variant)} available." }, status: :unprocessable_entity
      end
      existing_item['quantity'] = new_quantity
    else
      @cart[:items] << {
        'product_id' => product.id,
        'variant_id' => variant&.id,
        'variant_label' => variant&.label,
        'product_name' => product.name,
        'price' => (variant ? variant.effective_price : product.selling_price),
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
    variant_id = params[:variant_id].presence&.to_i
    quantity = params[:quantity].to_i
    item = cart_items.find { |i| same_line?(i, product_id, variant_id) }

    if item.nil?
      return render json: { success: false, error: 'Item not found in cart.' }, status: :not_found
    end

    if quantity <= 0
      @cart[:items].reject! { |i| same_line?(i, product_id, variant_id) }
      save_cart
      return render json: { success: true, cart_count: cart_count, cart_total: cart_total }
    end

    product = Product.find(product_id)
    unless product.can_fulfill_order?(quantity, variant_id: variant_id)
      variant = variant_id ? product.product_variants.find_by(id: variant_id) : nil
      return render json: { success: false, error: "Only #{available_label(product, variant)} available." }, status: :unprocessable_entity
    end

    item['quantity'] = quantity
    save_cart
    render json: { success: true, cart_count: cart_count, cart_total: cart_total }
  end

  def remove_item
    product_id = params[:product_id].to_i
    variant_id = params[:variant_id].presence&.to_i
    @cart[:items].reject! { |item| same_line?(item, product_id, variant_id) }
    save_cart
    render json: { success: true, cart_count: cart_count, cart_total: cart_total }
  end

  def clear
    @cart[:items] = []
    save_cart
    render json: { success: true, cart_count: 0, cart_total: 0 }
  end

  private

  # A cart line is identified by product + chosen variant (nil for a plain,
  # single-option product), so the same product in two sizes is two lines.
  def same_line?(item, product_id, variant_id)
    item['product_id'].to_i == product_id.to_i &&
      item['variant_id'].presence&.to_i == (variant_id.presence&.to_i)
  end

  def resolve_variant(product, raw_id)
    return nil if raw_id.blank?
    product.product_variants.find_by(id: raw_id)
  end

  def available_label(product, variant)
    qty = variant ? variant.available_stock : product.available_quantity
    "#{qty} units#{" of #{variant.label}" if variant}"
  end
end
