class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  skip_load_and_authorize_resource
  skip_before_action :set_cache_control_headers
  skip_before_action :ensure_session_security

  # Themes with a real ERB template (app/views/home/<key>.html.erb, underscored)
  # render the live product catalog instead of the static HTML file. Every
  # other theme still serves its static public/websites/*.html file untouched.
  DYNAMIC_THEMES = %w[luxury-gourmet].freeze

  def index
    # `preview_theme` (used only by the admin theme-picker's Preview links) is
    # always checked against WEBSITE_THEMES's fixed key set below, never used
    # to build a path directly — no arbitrary file read is possible here.
    theme_key = params[:preview_theme].presence_in(SystemSetting::WEBSITE_THEMES.keys) || SystemSetting.website_theme

    if DYNAMIC_THEMES.include?(theme_key)
      load_catalog_products
      render template: "home/#{theme_key.underscore}", layout: false
      return
    end

    theme_file = SystemSetting::WEBSITE_THEMES.dig(theme_key, :file) || 'marali-santhe.html'
    Rails.logger.info "HomeController#index called - serving #{theme_file}"

    # Serve the selected theme's static HTML file directly without any layout
    html_content = File.read(Rails.root.join('public', theme_file))
    render html: html_content.html_safe, layout: false
  end

  private

  # Real catalog data for DYNAMIC_THEMES — grouped by category.
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