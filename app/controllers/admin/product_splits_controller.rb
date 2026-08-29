class Admin::ProductSplitsController < Admin::ApplicationController
  include ConfigurablePagination

  before_action :ensure_split_feature_enabled

  def index
    products = Product.includes(:category, :product_variants).order(:name)
    products = products.where("products.name ILIKE ?", "%#{params[:search]}%") if params[:search].present?

    @products = paginate_records(products)
  end

  private

  def ensure_split_feature_enabled
    unless SystemSetting.split_feature_enabled?
      redirect_to admin_settings_system_path, alert: 'Enable the Split feature (Settings > System) to view product splits.'
    end
  end
end
