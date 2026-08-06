class Admin::QrCodesController < Admin::ApplicationController
  before_action :authenticate_user!
  before_action { require_sidebar_permission!('qr_codes') }

  def index
    # id/name/barcode/sku/category_id are all the view needs (qr_code_svg only
    # reads barcode) — trims the row payload on an otherwise unpaginated,
    # full-table query.
    base_scope = Product.where.not(barcode: nil)
                        .select(:id, :name, :barcode, :sku, :category_id)
                        .includes(:category)

    if params[:search].present?
      @products = base_scope.where("name LIKE ? OR barcode LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
                            .order(:name)
    else
      # The common case (no search = "print all") is cached: this is a bulk
      # reference listing, not live data, so a few minutes of staleness after
      # a product/barcode is added is an acceptable trade for skipping the
      # full-table round trip on every request.
      @products = Rails.cache.fetch('admin_qr_codes/all_products', expires_in: 5.minutes) do
        base_scope.order(:name).to_a
      end
    end
  end

  def lookup
    product = Product.find_by(barcode: params[:barcode].to_s.strip)
    unless product
      render json: { found: false, message: "No product found for barcode: #{params[:barcode]}" }
      return
    end

    gst_rate = (product.gst_enabled? && product.gst_percentage.present?) ? product.gst_percentage.to_f : 0.0

    response = {
      found: true,
      id: product.id,
      name: product.name,
      sku: product.sku,
      barcode: product.barcode,
      unit_type: product.unit_type,
      has_multiple_quantities: product.has_multiple_quantities?,
      gst_enabled: product.gst_enabled?,
      gst_rate: gst_rate
    }

    if product.has_multiple_quantities? && product.product_variants.any?
      default_v = product.default_variant || product.product_variants.ordered.first
      response[:variants] = product.product_variants.default_first.map do |v|
        {
          id: v.id,
          label: v.label,
          price: v.effective_price.to_f,
          stock: v.available_stock.to_i,
          is_default: v.is_default
        }
      end
      response[:default_variant_id] = default_v.id
      response[:price] = default_v.effective_price.to_f
    else
      avail = product.total_batch_stock.to_i
      response[:price] = product.price.to_f
      response[:available_stock] = avail
    end

    render json: response
  end
end
