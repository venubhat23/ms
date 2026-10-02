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
      from = product.product_variants.find(params[:from_variant_id]) if params[:from_variant_id].present?
      to = if params[:to_variant_id] == "new"
        weight = params[:to_new_weight].to_f
        price = params[:to_new_price].to_f
        raise ProductVariant::TransferError, "Enter a weight for the new variant." if weight <= 0
        raise ProductVariant::TransferError, "Enter a selling price for the new variant." if price <= 0
        find_or_create_variant(product, weight, price)
      elsif params[:to_variant_id].present?
        product.product_variants.find(params[:to_variant_id])
      end

      ProductVariant.transfer_stock!(product: product, from: from, to: to, quantity: params[:quantity])
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
