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

    ActiveRecord::Base.transaction do
      from_lines = build_lines(product, params[:from_variant_ids], params[:from_quantities])
      to_lines = build_to_lines(product, params[:to_variant_ids], params[:to_quantities], params[:to_new_weights], params[:to_new_prices])

      ProductVariant.transfer_stock!(product: product, from_lines: from_lines, to_lines: to_lines)
    end

    redirect_to admin_product_splits_path, notice: "Stock transferred successfully for #{product.name}."
  rescue ProductVariant::TransferError => e
    redirect_to admin_product_splits_path, alert: e.message
  rescue ActiveRecord::RecordNotFound => e
    redirect_to admin_product_splits_path, alert: e.message
  rescue ActiveRecord::RecordInvalid => e
    redirect_to admin_product_splits_path, alert: "Couldn't create the new variant: #{e.record.errors.full_messages.to_sentence}"
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

  # Like build_lines, but the destination side may name a variant that doesn't
  # exist yet ("new"). In that case the paired to_new_weights[]/to_new_prices[]
  # entry (same index as the variant_id) is used to find an existing variant
  # with that weight/unit — reusing it if present — or create a fresh one.
  def build_to_lines(product, variant_ids, quantities, new_weights, new_prices)
    return [] if variant_ids.blank?

    totals = Hash.new(0)
    variant_ids.each_with_index do |variant_id, index|
      next if variant_id.blank?

      quantity = quantities&.[](index).to_i
      next if quantity <= 0

      if variant_id == "new"
        weight = new_weights&.[](index).to_f
        price = new_prices&.[](index).to_f
        raise ProductVariant::TransferError, "Enter a weight for the new variant." if weight <= 0
        raise ProductVariant::TransferError, "Enter a selling price for the new variant." if price <= 0

        variant = find_or_create_variant(product, weight, price)
        totals[variant.id.to_s] += quantity
      else
        totals[variant_id] += quantity
      end
    end

    variants = product.product_variants.where(id: totals.keys).index_by { |v| v.id.to_s }
    totals.map do |variant_id, quantity|
      variant = variants[variant_id.to_s] || raise(ActiveRecord::RecordNotFound, "Variant #{variant_id} not found for #{product.name}.")
      { variant: variant, quantity: quantity }
    end
  end

  # Reuses an existing variant with a matching weight/unit if one exists on
  # the product (covers the case where the destination pack size already
  # exists but wasn't picked from the dropdown), otherwise creates it.
  def find_or_create_variant(product, weight, price)
    existing = product.product_variants.detect { |v| (v.weight.to_f - weight).abs < 0.001 && v.unit == product.unit_type }
    return existing if existing

    product.product_variants.create!(
      weight: weight,
      unit: product.unit_type,
      selling_price: price,
      available_stock: 0
    )
  end
end
