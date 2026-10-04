class Customer::ProductsController < Customer::BaseController
  before_action :find_product, only: [:show]

  def index
    # :stock_batches preloaded so in_stock?/available_quantity (called per
    # card in the view) use Product#cached_total_batch_stock's already-built
    # "loaded?" fast path instead of a fresh SUM query per product.
    @products = Product.active.includes(:category, :approved_reviews, :stock_batches, :product_variants, image_attachment: :blob)

    # Apply filters
    @products = @products.by_category(params[:category_id]) if params[:category_id].present?
    @products = @products.search(params[:search]) if params[:search].present?

    # Price range filter
    if params[:min_price].present? && params[:max_price].present?
      @products = @products.where(price: params[:min_price]..params[:max_price])
    end

    # Stock filter
    case params[:stock_filter]
    when 'in_stock'
      @products = @products.joins(:stock_batches)
                          .where(stock_batches: { status: 'active' })
                          .group('products.id')
                          .having('SUM(stock_batches.quantity_remaining) > 0')
    when 'out_of_stock'
      @products = @products.left_joins(:stock_batches)
                          .group('products.id')
                          .having('COALESCE(SUM(CASE WHEN stock_batches.status = ? THEN stock_batches.quantity_remaining ELSE 0 END), 0) = 0', 'active')
    end

    # Sort
    case params[:sort]
    when 'price_low_to_high'
      @products = @products.order(:price)
    when 'price_high_to_low'
      @products = @products.order(price: :desc)
    when 'name_a_to_z'
      @products = @products.order(:name)
    when 'name_z_to_a'
      @products = @products.order(name: :desc)
    when 'newest'
      @products = @products.order(created_at: :desc)
    else
      @products = @products.order(:name)
    end

    # load_async: the page loads on a background connection while the
    # categories query runs, and the view's .any?/.size read the loaded page
    # instead of each firing their own EXISTS/COUNT query.
    @products = @products.page(params[:page]).per(12).load_async

    # For filters
    @categories = Category.where(status: true).order(:name).load_async
    @price_ranges = [
      { label: 'Under ₹100', min: 0, max: 100 },
      { label: '₹100 - ₹500', min: 100, max: 500 },
      { label: '₹500 - ₹1000', min: 500, max: 1000 },
      { label: 'Above ₹1000', min: 1000, max: Float::INFINITY }
    ]
  end

  def show
    # Reviews load in the background while related products load.
    @reviews = @product.approved_reviews.recent.limit(10).load_async
    @related_products = Product.active
                              .where.not(id: @product.id)
                              .where(category: @product.category)
                              .eager_load(:category, image_attachment: :blob)
                              .limit(4)
    @related_products = Product.preload_batch_stock(@related_products)
  end

  def search
    @products = Product.active.search(params[:q])
    @products = @products.page(params[:page]).per(12)
    @search_term = params[:q]
  end

  def category
    @category = Category.find(params[:id])
    @products = @category.products.active.includes(:approved_reviews)
    @products = @products.page(params[:page]).per(12)
  end

  private

  def find_product
    # :approved_reviews/:stock_batches preloaded so average_rating (called 3x
    # in show.html.erb), total_reviews (2x), and in_stock?/available_quantity
    # (2x each) all hit their model-level "loaded?" fast paths instead of a
    # fresh query per call — was ~9-10 extra round trips per product page.
    # eager_load joins the single-row associations (category, main image)
    # into the product query itself; has_many ones stay as preloads.
    @product = Product.active
                      .eager_load(:category, image_attachment: :blob)
                      .preload(:approved_reviews, :stock_batches)
                      .find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to customer_products_path, alert: 'Product not found.'
  end
end