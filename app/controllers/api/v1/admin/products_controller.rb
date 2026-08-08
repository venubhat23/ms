class Api::V1::Admin::ProductsController < Api::V1::Admin::BaseController
  # GET /api/v1/admin/products
  def index
    products = Product.includes(:category)
    products = products.where(category_id: params[:category_id]) if params[:category_id].present?
    products = products.search(params[:search]) if params[:search].present?
    products = products.order(created_at: :desc)

    page = params[:page] || 1
    per_page = params[:per_page] || 20
    products = products.page(page).per(per_page)

    render_success(
      products: products.map { |p| product_response(p) },
      pagination: {
        current_page: products.current_page,
        total_pages: products.total_pages,
        total_count: products.total_count,
        per_page: products.limit_value
      }
    )
  end

  # GET /api/v1/admin/products/:id
  def show
    product = Product.includes(:category).find(params[:id])
    render_success(product_response(product, detailed: true))
  rescue ActiveRecord::RecordNotFound
    render_error('Product not found', nil, :not_found)
  end

  # POST /api/v1/admin/products
  def create
    product = Product.new(product_params)

    if product.save
      render_success(product_response(product, detailed: true), 'Product created successfully', :created)
    else
      render_validation_errors(product)
    end
  end

  # PATCH/PUT /api/v1/admin/products/:id
  def update
    product = Product.find(params[:id])

    if product.update(product_params)
      render_success(product_response(product, detailed: true), 'Product updated successfully')
    else
      render_validation_errors(product)
    end
  rescue ActiveRecord::RecordNotFound
    render_error('Product not found', nil, :not_found)
  end

  # DELETE /api/v1/admin/products/:id
  # Mirrors Admin::ProductsController#destroy (web) — nullifies historical
  # booking/order/invoice references instead of deleting them, and removes
  # records that only ever make sense in the context of this product.
  def destroy
    product = Product.find(params[:id])
    product_name = product.name

    ActiveRecord::Base.transaction do
      product.booking_items.update_all(product_id: nil)
      product.order_items.update_all(product_id: nil)
      InvoiceItem.where(product_id: product.id).update_all(product_id: nil)

      task_ids = MilkDeliveryTask.where(product_id: product.id).pluck(:id)
      InvoiceItem.where(milk_delivery_task_id: task_ids).update_all(milk_delivery_task_id: nil) if task_ids.any?
      MilkDeliveryTask.where(id: task_ids).delete_all
      MilkSubscription.where(product_id: product.id).delete_all

      schedule_ids = BookingSchedule.where(product_id: product.id).pluck(:id)
      Booking.where(booking_schedule_id: schedule_ids).update_all(booking_schedule_id: nil) if schedule_ids.any?
      BookingSchedule.where(id: schedule_ids).delete_all

      Wishlist.where(product_id: product.id).delete_all
      SubscriptionTemplate.where(product_id: product.id).delete_all
      CustomerFormat.where(product_id: product.id).delete_all
      StockTransfer.where(product_id: product.id).delete_all

      product.destroy!
    end

    render_success(nil, "Product '#{product_name}' deleted successfully")
  rescue ActiveRecord::RecordNotFound
    render_error('Product not found', nil, :not_found)
  rescue ActiveRecord::InvalidForeignKey => e
    blocking_table = e.message[/referenced from table "(\w+)"/, 1] || 'related records'
    render_error("Could not delete: it still has #{blocking_table.humanize.downcase} referencing it.", nil, :unprocessable_entity)
  end

  # POST /api/v1/admin/products/:id/upload_image
  # Pass main=true to replace the main image; otherwise it's appended to the gallery.
  def upload_image
    product = Product.find(params[:id])
    return render_error('Please provide an image file', nil, :unprocessable_entity) if params[:image].blank?

    result = R2Service.upload(params[:image], folder: 'products')
    return render_error("Upload failed: #{result[:error]}", nil, :unprocessable_entity) if result[:error]

    if params[:main].to_s == 'true' || product.r2_image_url.blank?
      old_url = product.r2_image_url
      product.update!(r2_image_url: result[:public_url])
      R2Service.delete(extract_r2_key_from_url(old_url)) if old_url.present?
    else
      product.add_additional_r2_image(result[:public_url])
      product.save!
    end

    render_success(product_response(product, detailed: true), 'Image uploaded successfully')
  rescue ActiveRecord::RecordNotFound
    render_error('Product not found', nil, :not_found)
  end

  # DELETE /api/v1/admin/products/:id/remove_image?gallery_id=r2_main
  def remove_image
    product = Product.find(params[:id])
    removed_url = product.remove_gallery_image!(params[:gallery_id])
    R2Service.delete(extract_r2_key_from_url(removed_url)) if removed_url.present?

    render_success(product_response(product, detailed: true), 'Image removed successfully')
  rescue ActiveRecord::RecordNotFound
    render_error('Product not found', nil, :not_found)
  end

  private

  def product_params
    params.require(:product).permit(
      :name, :description, :category_id, :price, :discount_price, :stock,
      :status, :sku, :weight, :buying_price,
      :product_type, :unit_type,
      :image_url, :r2_image_url,
      :gst_enabled, :gst_percentage
    )
  end

  def extract_r2_key_from_url(image_url)
    return nil if image_url.blank?
    uri = URI.parse(image_url)
    uri.path[1..-1] if uri.path
  rescue URI::InvalidURIError
    nil
  end

  def product_response(product, detailed: false)
    data = {
      id: product.id,
      name: product.name,
      price: product.price.to_f,
      discount_price: product.discount_price&.to_f,
      selling_price: product.selling_price.to_f,
      stock: product.stock,
      status: product.status,
      sku: product.sku,
      category: { id: product.category_id, name: product.category&.name },
      main_image_url: product.main_image_url
    }

    if detailed
      data[:description] = product.description
      data[:gallery] = product.image_gallery
      data[:buying_price] = product.buying_price&.to_f
      data[:gst_enabled] = product.gst_enabled
      data[:gst_percentage] = product.gst_percentage&.to_f
    end

    data
  end
end
