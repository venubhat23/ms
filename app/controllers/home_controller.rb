class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  skip_load_and_authorize_resource
  skip_before_action :set_cache_control_headers
  skip_before_action :ensure_session_security

  def index
    # `preview_theme` (used only by the admin theme-picker's Preview links) is
    # always checked against WEBSITE_THEMES's fixed key set below, never used
    # to build a path directly — no arbitrary file read is possible here.
    theme_key = params[:preview_theme].presence_in(SystemSetting::WEBSITE_THEMES.keys) || SystemSetting.website_theme

    load_catalog_products
    @top_category = Category.top_selling
    @secondary_category = Category.active.ordered.where.not(id: @top_category&.id).first
    @best_seller_ids = Product.best_seller_ids.to_set
    @new_arrivals = Product.active.includes(image_attachment: :blob).order(created_at: :desc).limit(8)
    @new_arrival_ids = @new_arrivals.map(&:id).to_set

    render template: "home/#{theme_key.underscore}", layout: false
  end

  private

  # Guest cart count for the storefront nav badge — same session[:cart] the
  # Storefront::CartsController reads/writes.
  def cart_count
    items = session[:cart].try(:[], 'items') || session[:cart].try(:[], :items)
    return 0 if items.blank?
    items.sum { |item| item['quantity'].to_i }
  end
  helper_method :cart_count

  # Real catalog data, grouped by category, shared by every theme template.
  def load_catalog_products
    products = Product.active
                       .includes(:category, image_attachment: :blob)
                       .references(:category)
                       .order(Arel.sql("categories.display_order ASC NULLS LAST, categories.name ASC, products.name ASC"))
                       .to_a

    @products_by_category = products.group_by { |p| p.category&.name.presence || 'Other' }
    @total_products = products.size
  end
end