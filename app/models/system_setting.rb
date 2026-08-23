class SystemSetting < ApplicationRecord
  validates :key, presence: true, uniqueness: true
  validates :value, presence: true
  validates :setting_type, presence: true

  # See lib/local_ttl_cache.rb for why this exists: every SystemSetting read
  # (theme, collect-from-store toggle, delivery settings, etc.) otherwise
  # hits the DB directly, every single call, on every page in the app.
  # Settings only change through the admin Settings screens, so 20s of
  # staleness is unnoticeable in practice.
  LOCAL_CACHE = LocalTtlCache.new
  LOCAL_TTL = 20.seconds
  SYSTEM_CONFIG_KEY = 'system_config'
  BUSINESS_CONFIG_KEY = 'business_config'

  # Single cached read of the singleton `system_config` / `business_config`
  # rows, so the many one-off `find_by(key: ...)` accessors below share one
  # DB round trip instead of each paying their own.
  def self.cached_system_config
    LOCAL_CACHE.fetch(SYSTEM_CONFIG_KEY, LOCAL_TTL) { find_by(key: SYSTEM_CONFIG_KEY) }
  end

  def self.cached_business_config
    LOCAL_CACHE.fetch(BUSINESS_CONFIG_KEY, LOCAL_TTL) { find_by(key: BUSINESS_CONFIG_KEY) }
  end

  # Public storefront (HomeController#index) theme options — each maps to a
  # static HTML file under public/websites/. `swatch` drives the small
  # CSS-drawn thumbnail on the picker cards in admin/settings/system.
  WEBSITE_THEMES = {
    'classic-organic' => {
      name: 'Organic Classic',
      description: 'Forest green & gold, warm farm photography — the original.',
      file: 'marali-santhe.html',
      swatch: %w[#2e7d32 #c9a535 #faf7f2]
    },
    'classic-green-organic' => {
      name: 'Classic Green Organic',
      description: 'Forest green & gold, warm farm photography — same as Organic Classic.',
      file: 'websites/classic-green-organic.html',
      swatch: %w[#2e7d32 #c9a535 #faf7f2]
    },
    'modern-minimal' => {
      name: 'Modern Minimal',
      description: 'Black, white & sage — clean, editorial, lots of whitespace.',
      file: 'websites/modern-minimal.html',
      swatch: %w[#111111 #6b7a5e #ffffff]
    },
    'vibrant-market' => {
      name: 'Vibrant Market',
      description: 'Bold orange & red, playful rounded type, farmers-market energy.',
      file: 'websites/vibrant-market.html',
      swatch: %w[#ff6a3d #e63946 #ffc233]
    },
    'luxury-gourmet' => {
      name: 'Luxury Gourmet',
      description: 'Near-black with gold-foil accents — premium gourmet feel.',
      file: 'websites/luxury-gourmet.html',
      swatch: %w[#0a0a0a #c9a24b #f3ecd9]
    },
    'fresh-wellness' => {
      name: 'Fresh Wellness',
      description: 'Soft pastel green & peach, fully rounded — spa/wellness mood.',
      file: 'websites/fresh-wellness.html',
      swatch: %w[#8fae82 #f3ab7c #fdf9f2]
    },
    'rustic-farmhouse' => {
      name: 'Rustic Farmhouse',
      description: 'Warm wood & terracotta, kraft-paper texture — barn-market feel.',
      file: 'websites/rustic-farmhouse.html',
      swatch: %w[#6b4a34 #c1652f #e8dcc4]
    },
    'tropical-fresh' => {
      name: 'Tropical Fresh',
      description: 'Teal, lime & coral with organic blob shapes — resort/juice-bar vibe.',
      file: 'websites/tropical-fresh.html',
      swatch: %w[#0d9488 #a3e635 #ff7a5c]
    },
    'monochrome-editorial' => {
      name: 'Monochrome Editorial',
      description: 'Black & white high-fashion magazine style with a single red accent.',
      file: 'websites/monochrome-editorial.html',
      swatch: %w[#0a0a0a #ffffff #e10600]
    },
    'retro-vintage' => {
      name: 'Retro Vintage',
      description: "70s mustard, rust & cream with groovy badges and hand-drawn accents.",
      file: 'websites/retro-vintage.html',
      swatch: %w[#d99a2b #b8502f #f7ecd8]
    },
    'neo-tech' => {
      name: 'Neo Tech',
      description: 'Dark navy with electric blue & neon glow — futuristic smart-grocery feel.',
      file: 'websites/neo-tech.html',
      swatch: %w[#070b14 #3b82f6 #39ff88]
    },
    'ayur-wellness' => {
      name: 'Ayurvedic Wellness',
      description: 'Sage green & gold, rounded sans-serif — organic wellness-brand editorial style.',
      file: 'websites/ayur-wellness.html',
      swatch: %w[#4a6741 #c89b3c #faf8f2]
    },
    'client3' => {
      name: 'Client 3',
      description: 'Forest green, gold & cream — scrolling offers bar, search-first nav, category carousels and a torn-paper hero, in the style of a premium herbal wellness storefront.',
      file: 'websites/client3.html',
      swatch: %w[#1f7d3f #f0b923 #f7f1e3]
    }
  }.freeze

  # Business details validations
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :upi_id, format: { with: /\A[a-zA-Z0-9.\-_]+@[a-zA-Z0-9.\-_]+\z/, message: "must be a valid UPI ID" }, allow_blank: true

  # Class method to get a setting value by key
  def self.get_value(key)
    LOCAL_CACHE.fetch(key, LOCAL_TTL) { find_by(key: key)&.value }
  end

  # Class method to set a setting value by key
  def self.set_value(key, value, description: nil, setting_type: 'string')
    setting = find_or_initialize_by(key: key)
    setting.value = value
    setting.description = description if description
    setting.setting_type = setting_type
    setting.save!
    # Update this worker's copy immediately so the admin who just saved the
    # setting sees it take effect right away, rather than waiting out
    # LOCAL_TTL. Other worker processes still pick it up within LOCAL_TTL.
    LOCAL_CACHE.write(key, value, LOCAL_TTL)
    setting
  end

  # Get company expenses percentage as float
  def self.company_expenses_percentage
    value = get_value('company_expenses_percentage')
    value ? value.to_f : 2.0
  end

  # Set company expenses percentage
  def self.set_company_expenses_percentage(percentage)
    set_value(
      'company_expenses_percentage',
      percentage.to_s,
      description: 'Company expenses percentage that can be configured by admin',
      setting_type: 'percentage'
    )
  end

  # Get default pagination per page as integer
  def self.default_pagination_per_page
    value = get_value('default_pagination_per_page')
    value ? value.to_i : 10
  end

  # Set default pagination per page
  def self.set_default_pagination_per_page(per_page)
    set_value(
      'default_pagination_per_page',
      per_page.to_s,
      description: 'Default number of records per page for all index pages',
      setting_type: 'integer'
    )
  end

  # Get the selected public storefront theme key
  def self.website_theme
    value = get_value('website_theme')
    WEBSITE_THEMES.key?(value) ? value : 'classic-organic'
  end

  # Set the selected public storefront theme
  def self.set_website_theme(theme_key)
    set_value(
      'website_theme',
      theme_key.to_s,
      description: 'Selected theme for the public storefront homepage',
      setting_type: 'string'
    )
  end

  # Commission methods for new columns

  # Get default main agent commission as float
  def self.default_main_agent_commission
    setting = find_by(key: 'system_config')
    setting&.default_main_agent_commission || 0.0
  end

  # Get default affiliate commission as float
  def self.default_affiliate_commission
    setting = find_by(key: 'system_config')
    setting&.default_affiliate_commission || 0.0
  end

  # Get default ambassador commission as float
  def self.default_ambassador_commission
    setting = find_by(key: 'system_config')
    setting&.default_ambassador_commission || 0.0
  end

  # Get default company expenses as float
  def self.default_company_expenses
    setting = find_by(key: 'system_config')
    setting&.default_company_expenses || 0.0
  end

  # Update commission values
  def self.update_commission_settings(params)
    # Create a default setting if none exists
    setting = find_by(key: 'system_config') || create!(
      key: 'system_config',
      value: 'system configuration',
      setting_type: 'configuration',
      description: 'System configuration settings'
    )

    setting.update!(
      default_main_agent_commission: params[:default_main_agent_commission],
      default_affiliate_commission: params[:default_affiliate_commission],
      default_ambassador_commission: params[:default_ambassador_commission],
      default_company_expenses: params[:default_company_expenses]
    )
    LOCAL_CACHE.delete(SYSTEM_CONFIG_KEY)
    setting
  end

  # Business Settings Methods

  # Singleton pattern to get the current business settings
  def self.business_settings
    cached_business_config || new
  end

  # Update business settings
  def self.update_business_settings(params)
    setting = find_or_create_by(key: 'business_config') do |s|
      s.value = 'business configuration'
      s.setting_type = 'configuration'
      s.description = 'Business configuration settings'
    end

    update_attrs = {
      business_name: params[:business_name],
      address: params[:address],
      mobile: params[:mobile],
      email: params[:email],
      gstin: params[:gstin],
      pan_number: params[:pan_number],
      account_holder_name: params[:account_holder_name],
      bank_name: params[:bank_name],
      account_number: params[:account_number],
      ifsc_code: params[:ifsc_code],
      upi_id: params[:upi_id],
      terms_and_conditions: params[:terms_and_conditions],
      website: params[:website],
      logo_url: params[:logo_url].presence || setting.logo_url
    }
    update_attrs[:invoice_template] = params[:invoice_template] if column_names.include?('invoice_template') && params[:invoice_template].present?
    setting.update!(update_attrs)
    LOCAL_CACHE.delete(BUSINESS_CONFIG_KEY)

    setting
  end

  def logo_display_url
    logo_url.presence || '/logo.jpeg'
  end

  def formatted_terms_and_conditions
    return [] if terms_and_conditions.blank?
    terms_and_conditions.split("\n").map(&:strip).reject(&:empty?)
  end

  # Collect From Store Feature Methods

  # Check if collect from store feature is enabled
  def self.collect_from_store_enabled?
    cached_system_config&.collect_from_store_enabled || false
  end

  # Enable or disable collect from store feature
  def self.set_collect_from_store_enabled(enabled)
    setting = find_or_create_by(key: 'system_config') do |s|
      s.value = 'system configuration'
      s.setting_type = 'configuration'
      s.description = 'System configuration settings'
    end

    setting.update!(collect_from_store_enabled: enabled)
    LOCAL_CACHE.delete(SYSTEM_CONFIG_KEY)
    setting
  end

  # Update collect from store setting along with other settings
  def self.update_collect_from_store_settings(params)
    setting = find_or_create_by(key: 'system_config') do |s|
      s.value = 'system configuration'
      s.setting_type = 'configuration'
      s.description = 'System configuration settings'
    end

    setting.update!(collect_from_store_enabled: params[:collect_from_store_enabled] || false)
    LOCAL_CACHE.delete(SYSTEM_CONFIG_KEY)
    setting
  end

  # Franchise Commission Feature Methods

  # Check if the franchise commission feature (wholesale bookings, franchise
  # inventory, franchise delivery + commission wallet) is enabled
  def self.franchise_commission_enabled?
    cached_system_config&.franchise_commission_enabled || false
  end

  # Enable or disable the franchise commission feature
  def self.set_franchise_commission_enabled(enabled)
    setting = find_or_create_by(key: 'system_config') do |s|
      s.value = 'system configuration'
      s.setting_type = 'configuration'
      s.description = 'System configuration settings'
    end

    setting.update!(franchise_commission_enabled: enabled)
    LOCAL_CACHE.delete(SYSTEM_CONFIG_KEY)
    setting
  end

  # Update franchise commission setting along with other settings
  def self.update_franchise_commission_settings(params)
    setting = find_or_create_by(key: 'system_config') do |s|
      s.value = 'system configuration'
      s.setting_type = 'configuration'
      s.description = 'System configuration settings'
    end

    setting.update!(franchise_commission_enabled: params[:franchise_commission_enabled] == "1")
    LOCAL_CACHE.delete(SYSTEM_CONFIG_KEY)
    setting
  end

  # OTP Login Feature Methods

  # Check if mobile-app OTP login is enabled (admin kill-switch, default off)
  def self.otp_login_enabled?
    cached_system_config&.otp_login_enabled || false
  end

  # Enable or disable OTP login feature
  def self.set_otp_login_enabled(enabled)
    setting = find_or_create_by(key: 'system_config') do |s|
      s.value = 'system configuration'
      s.setting_type = 'configuration'
      s.description = 'System configuration settings'
    end

    setting.update!(otp_login_enabled: enabled)
    LOCAL_CACHE.delete(SYSTEM_CONFIG_KEY)
    setting
  end

  # Customer Wallet Feature Methods

  # Check if the customer wallet feature (sidebar, admin add/remove money,
  # "pay from wallet" option at mobile checkout) is enabled. Off by default.
  def self.customer_wallet_enabled?
    cached_system_config&.customer_wallet_enabled || false
  end

  # Enable or disable the customer wallet feature
  def self.set_customer_wallet_enabled(enabled)
    setting = find_or_create_by(key: 'system_config') do |s|
      s.value = 'system configuration'
      s.setting_type = 'configuration'
      s.description = 'System configuration settings'
    end

    setting.update!(customer_wallet_enabled: enabled)
    LOCAL_CACHE.delete(SYSTEM_CONFIG_KEY)
    setting
  end

  # Delivery Only At Shop Feature Methods

  # Check if delivery only at shop feature is enabled
  def self.delivery_only_at_shop_enabled?
    cached_system_config&.delivery_only_at_shop || false
  end

  # Enable or disable delivery only at shop feature
  def self.set_delivery_only_at_shop_enabled(enabled)
    setting = find_or_create_by(key: 'system_config') do |s|
      s.value = 'system configuration'
      s.setting_type = 'configuration'
      s.description = 'System configuration settings'
    end

    setting.update!(delivery_only_at_shop: enabled)
    LOCAL_CACHE.delete(SYSTEM_CONFIG_KEY)
    setting
  end

  # Get shop addresses as array
  def self.get_shop_addresses
    addresses = cached_system_config&.shop_addresses
    return [] if addresses.blank?

    JSON.parse(addresses) rescue []
  end

  # Set shop addresses from array
  def self.set_shop_addresses(addresses_array)
    setting = find_or_create_by(key: 'system_config') do |s|
      s.value = 'system configuration'
      s.setting_type = 'configuration'
      s.description = 'System configuration settings'
    end

    setting.update!(shop_addresses: addresses_array.to_json)
    LOCAL_CACHE.delete(SYSTEM_CONFIG_KEY)
    setting
  end

  # Update delivery only at shop settings with addresses
  def self.update_delivery_only_at_shop_settings(params)
    setting = find_or_create_by(key: 'system_config') do |s|
      s.value = 'system configuration'
      s.setting_type = 'configuration'
      s.description = 'System configuration settings'
    end

    # Update delivery only at shop setting
    delivery_enabled = params[:delivery_only_at_shop] == "1"

    # Process addresses if feature is enabled
    addresses = []
    if delivery_enabled && params[:shop_addresses].present?
      # Handle addresses submitted from form
      addresses = params[:shop_addresses].split("\n").map(&:strip).reject(&:empty?)
    end

    setting.update!(
      delivery_only_at_shop: delivery_enabled,
      shop_addresses: addresses.to_json
    )
    LOCAL_CACHE.delete(SYSTEM_CONFIG_KEY)

    setting
  end

  # Get formatted shop addresses for display
  def formatted_shop_addresses
    return [] if shop_addresses.blank?
    JSON.parse(shop_addresses) rescue []
  end

  # Low Stock Alert Methods

  def self.low_stock_alert_enabled?
    cached_system_config&.low_stock_alert_enabled || false
  end

  def self.low_stock_alert_threshold
    cached_system_config&.low_stock_alert_threshold || 10
  end

  def self.low_stock_alert_email
    cached_system_config&.low_stock_alert_email.presence || business_settings&.email
  end

  def self.update_low_stock_settings(params)
    setting = find_or_create_by(key: 'system_config') do |s|
      s.value = 'system configuration'
      s.setting_type = 'configuration'
      s.description = 'System configuration settings'
    end
    setting.update!(
      low_stock_alert_enabled:   params[:low_stock_alert_enabled] == '1',
      low_stock_alert_threshold: params[:low_stock_alert_threshold].to_i,
      low_stock_alert_email:     params[:low_stock_alert_email]
    )
    LOCAL_CACHE.delete(SYSTEM_CONFIG_KEY)
    setting
  end

  # Website Images
  #
  # Two independent image pools stored as JSON arrays of R2 URLs on the
  # system_config row: `home_page_images` for the storefront homepage
  # hero/banner strip, and `site_gallery_images` for a general-purpose
  # gallery. Each image is uploaded and appended one at a time (see
  # Admin::Settings::SystemController#upload_home_page_image /
  # #upload_gallery_image), so these caps are enforced on add rather than
  # on a bulk save.

  HOME_PAGE_IMAGES_MAX = 10
  SITE_GALLERY_IMAGES_MAX = 20

  def self.home_page_images
    images_for(:home_page_images)
  end

  def self.add_home_page_image(url)
    add_image(:home_page_images, url, HOME_PAGE_IMAGES_MAX)
  end

  def self.remove_home_page_image(url)
    remove_image(:home_page_images, url)
  end

  def self.site_gallery_images
    images_for(:site_gallery_images)
  end

  def self.add_site_gallery_image(url)
    add_image(:site_gallery_images, url, SITE_GALLERY_IMAGES_MAX)
  end

  def self.remove_site_gallery_image(url)
    remove_image(:site_gallery_images, url)
  end

  def self.images_for(column)
    value = cached_system_config&.public_send(column)
    return [] if value.blank?
    JSON.parse(value)
  rescue JSON::ParserError
    []
  end
  private_class_method :images_for

  def self.add_image(column, url, max)
    setting = find_or_create_by(key: SYSTEM_CONFIG_KEY) do |s|
      s.value = 'system configuration'
      s.setting_type = 'configuration'
      s.description = 'System configuration settings'
    end

    images = begin
      JSON.parse(setting.public_send(column).presence || '[]')
    rescue JSON::ParserError
      []
    end
    raise "Maximum of #{max} images allowed" if images.size >= max

    images << url
    setting.update!(column => images.to_json)
    LOCAL_CACHE.delete(SYSTEM_CONFIG_KEY)
    images
  end
  private_class_method :add_image

  def self.remove_image(column, url)
    setting = find_by(key: SYSTEM_CONFIG_KEY)
    return [] unless setting

    images = begin
      JSON.parse(setting.public_send(column).presence || '[]')
    rescue JSON::ParserError
      []
    end
    images.delete(url)
    setting.update!(column => images.to_json)
    LOCAL_CACHE.delete(SYSTEM_CONFIG_KEY)
    images
  end
  private_class_method :remove_image

  # Client3 Theme Images
  #
  # The "client3" public storefront theme (app/views/home/client3.html.erb)
  # has 5 admin-manageable image slots: the business logo (reuses the
  # existing Business Settings logo upload — see logo_display_url), a
  # rotating hero banner (up to 5 images, cycled client-side), and 3 single
  # content images (story banner + 2 testimonials). Each defaults to the
  # stock photo already baked into the template, so shipping this feature
  # changes nothing on the live site until an admin actually uploads a
  # replacement — only then does the theme dynamically pick up the new URL.

  CLIENT3_HERO_IMAGES_MAX = 5

  CLIENT3_DEFAULT_HERO_IMAGES = [
    'https://images.pexels.com/photos/2662116/pexels-photo-2662116.jpeg?auto=compress&cs=tinysrgb&w=1800',
    'https://images.pexels.com/photos/4198567/pexels-photo-4198567.jpeg?auto=compress&cs=tinysrgb&w=1800',
    'https://images.pexels.com/photos/6157228/pexels-photo-6157228.jpeg?auto=compress&cs=tinysrgb&w=1800',
    'https://images.pexels.com/photos/1640774/pexels-photo-1640774.jpeg?auto=compress&cs=tinysrgb&w=1800',
    'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=1800'
  ].freeze
  CLIENT3_DEFAULT_STORY_IMAGE = 'https://images.pexels.com/photos/3823207/pexels-photo-3823207.jpeg?auto=compress&cs=tinysrgb&w=1000'
  CLIENT3_DEFAULT_TESTIMONIAL1_IMAGE = 'https://images.pexels.com/photos/1435904/pexels-photo-1435904.jpeg?auto=compress&cs=tinysrgb&w=700'
  CLIENT3_DEFAULT_TESTIMONIAL2_IMAGE = 'https://images.pexels.com/photos/4113889/pexels-photo-4113889.jpeg?auto=compress&cs=tinysrgb&w=700'

  def self.client3_hero_images
    images = images_for(:client3_hero_images)
    images.presence || CLIENT3_DEFAULT_HERO_IMAGES
  end

  def self.add_client3_hero_image(url)
    add_image(:client3_hero_images, url, CLIENT3_HERO_IMAGES_MAX)
  end

  def self.remove_client3_hero_image(url)
    remove_image(:client3_hero_images, url)
  end

  def self.client3_story_image
    cached_system_config&.client3_story_image_url.presence || CLIENT3_DEFAULT_STORY_IMAGE
  end

  def self.client3_testimonial1_image
    cached_system_config&.client3_testimonial1_image_url.presence || CLIENT3_DEFAULT_TESTIMONIAL1_IMAGE
  end

  def self.client3_testimonial2_image
    cached_system_config&.client3_testimonial2_image_url.presence || CLIENT3_DEFAULT_TESTIMONIAL2_IMAGE
  end

  # Persists the 3 single-image slots (submitted as hidden fields, populated
  # by JS after an immediate R2 upload) when the admin clicks "Update" on the
  # Website Images tab's Client3 Theme Images card. Blank fields are left
  # untouched so re-submitting the form without picking a new file doesn't
  # wipe out an already-set image.
  def self.update_client3_theme_images(params)
    setting = find_or_create_by(key: SYSTEM_CONFIG_KEY) do |s|
      s.value = 'system configuration'
      s.setting_type = 'configuration'
      s.description = 'System configuration settings'
    end

    update_attrs = {}
    update_attrs[:client3_story_image_url] = params[:client3_story_image_url] if params[:client3_story_image_url].present?
    update_attrs[:client3_testimonial1_image_url] = params[:client3_testimonial1_image_url] if params[:client3_testimonial1_image_url].present?
    update_attrs[:client3_testimonial2_image_url] = params[:client3_testimonial2_image_url] if params[:client3_testimonial2_image_url].present?

    setting.update!(update_attrs) if update_attrs.any?
    LOCAL_CACHE.delete(SYSTEM_CONFIG_KEY)
    setting
  end
end
