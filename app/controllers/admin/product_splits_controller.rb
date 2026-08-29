class Admin::ProductSplitsController < Admin::ApplicationController
  include ConfigurablePagination

  before_action :ensure_split_feature_enabled

  def index
    products = Product.includes(:category, :product_variants).order(:name)
    products = products.where("products.name ILIKE ?", "%#{params[:search]}%") if params[:search].present?

    @products = paginate_records(products)
  end

  def transfer
    product = Product.find(params[:product_id])
    from_lines = build_lines(product, params[:from_variant_ids], params[:from_quantities])
    to_lines = build_lines(product, params[:to_variant_ids], params[:to_quantities])

    ProductVariant.transfer_stock!(product: product, from_lines: from_lines, to_lines: to_lines)

    redirect_to admin_product_splits_path, notice: "Stock transferred successfully for #{product.name}."
  rescue ProductVariant::TransferError => e
    redirect_to admin_product_splits_path, alert: e.message
  rescue ActiveRecord::RecordNotFound => e
    redirect_to admin_product_splits_path, alert: e.message
  end

  private

  def ensure_split_feature_enabled
    unless SystemSetting.split_feature_enabled?
      redirect_to admin_settings_system_path, alert: 'Enable the Split feature (Settings > System) to view product splits.'
    end
  end

  # Combines a parallel variant_id[]/quantity[] pair from the form into
  # { variant:, quantity: } lines, merging duplicate variant rows and
  # dropping any row left blank or zeroed out.
  def build_lines(product, variant_ids, quantities)
    return [] if variant_ids.blank?

    totals = Hash.new(0)
    variant_ids.each_with_index do |variant_id, index|
      next if variant_id.blank?

      quantity = quantities&.[](index).to_i
      next if quantity <= 0

      totals[variant_id] += quantity
    end

    variants = product.product_variants.where(id: totals.keys).index_by { |v| v.id.to_s }
    totals.map do |variant_id, quantity|
      variant = variants[variant_id.to_s] || raise(ActiveRecord::RecordNotFound, "Variant #{variant_id} not found for #{product.name}.")
      { variant: variant, quantity: quantity }
    end
  end
end
