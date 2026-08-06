class Admin::Settings::SystemController < Admin::Settings::BaseController

  def index
    # Placeholder for system settings
    @system_settings = {
      app_name: 'DemoFarm Admin',
      version: '1.0.0',
      maintenance_mode: false,
      email_notifications: true,
      backup_frequency: 'Daily',
      session_timeout: 30,
      max_file_upload_size: 10
    }

    # Batches the 4 distinct SystemSetting keys this page needs into one query
    # (was 4 serial round trips — repeated `find_by(key: 'system_config')`
    # calls were already free via Rails' per-request query cache, but the 4
    # distinct keys were not) and caches the result since these change rarely.
    settings_by_key = cached_system_settings_by_key
    system_config = settings_by_key['system_config']
    business_config = settings_by_key['business_config']

    # Get company expenses percentage from database
    company_expenses_setting = settings_by_key['company_expenses_percentage']
    @company_expenses_percentage = company_expenses_setting ? company_expenses_setting.value.to_f : 2.0

    # Get default pagination per page from database
    pagination_setting = settings_by_key['default_pagination_per_page']
    @default_pagination_per_page = pagination_setting ? pagination_setting.value.to_i : 10

    # Get commission settings from database
    @default_main_agent_commission = system_config&.default_main_agent_commission || 0.0
    @default_affiliate_commission = system_config&.default_affiliate_commission || 0.0
    @default_ambassador_commission = system_config&.default_ambassador_commission || 0.0
    @default_company_expenses = system_config&.default_company_expenses || 0.0

    # Get business settings
    @business_setting = business_config || SystemSetting.new
    @invoice_template = begin
      SystemSetting.column_names.include?('invoice_template') ? (@business_setting.invoice_template.presence || 'classic') : 'classic'
    rescue
      'classic'
    end

    # Get collect from store settings
    @collect_from_store_enabled = system_config&.collect_from_store_enabled || false
    @stores_count = Rails.cache.fetch('admin_settings/stores_count', expires_in: 2.minutes) { Store.count }
    @max_stores_limit = Store::MAX_STORES_LIMIT

    # Get delivery only at shop settings
    @delivery_only_at_shop_enabled = system_config&.delivery_only_at_shop || false
    @shop_addresses = begin
      system_config&.shop_addresses.present? ? JSON.parse(system_config.shop_addresses) : []
    rescue JSON::ParserError
      []
    end

    # Get low stock alert settings
    @low_stock_alert_enabled   = system_config&.low_stock_alert_enabled || false
    @low_stock_alert_threshold = system_config&.low_stock_alert_threshold || 10
    @low_stock_alert_email     = system_config&.low_stock_alert_email.presence || @business_setting&.email

    # Get selected public storefront theme
    website_theme_setting = settings_by_key['website_theme']
    @website_theme = SystemSetting::WEBSITE_THEMES.key?(website_theme_setting&.value) ? website_theme_setting.value : 'classic-organic'
  end

  def update
    success_messages = []

    # Handle company expenses percentage
    if params[:company_expenses_percentage].present?
      percentage = params[:company_expenses_percentage].to_f

      # Validate percentage (should be between 0 and 100)
      if percentage >= 0 && percentage <= 100
        SystemSetting.set_company_expenses_percentage(percentage)
        success_messages << 'Company expenses percentage updated successfully!'
      else
        redirect_to admin_settings_system_path, alert: 'Invalid percentage. Please enter a value between 0 and 100.'
        return
      end
    end

    # Handle default pagination per page
    if params[:default_pagination_per_page].present?
      per_page = params[:default_pagination_per_page].to_i

      # Validate per_page (should be between 5 and 100)
      if per_page >= 5 && per_page <= 100
        SystemSetting.set_default_pagination_per_page(per_page)
        Rails.cache.delete('system_setting/default_pagination_per_page')
        success_messages << 'Default pagination per page updated successfully!'
      else
        redirect_to admin_settings_system_path, alert: 'Invalid pagination value. Please enter a value between 5 and 100.'
        return
      end
    end

    # Handle commission settings update
    if params[:commission_settings_update] == "true"
      commission_params = {
        default_main_agent_commission: params[:default_main_agent_commission]&.to_f,
        default_affiliate_commission: params[:default_affiliate_commission]&.to_f,
        default_ambassador_commission: params[:default_ambassador_commission]&.to_f,
        default_company_expenses: params[:default_company_expenses]&.to_f
      }

      # Validate all commission values
      valid_commissions = commission_params.values.all? do |value|
        value && value >= 0 && value <= 100
      end

      if valid_commissions
        begin
          SystemSetting.update_commission_settings(commission_params)
          success_messages << 'Commission settings updated successfully!'
        rescue => e
          redirect_to admin_settings_system_path, alert: "Error updating commission settings: #{e.message}"
          return
        end
      else
        redirect_to admin_settings_system_path, alert: 'Invalid commission values. Please enter percentages between 0 and 100.'
        return
      end
    end

    # Handle business settings update
    if params[:business_settings_update] == "true"
      begin
        business_params = {
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
          invoice_template: params[:invoice_template],
          website: params[:website],
          logo_url: params[:logo_url]
        }

        @business_setting = SystemSetting.update_business_settings(business_params)

        # Generate QR code if UPI ID is present
        generate_qr_code if @business_setting.upi_id.present?

        # Handle store settings if present
        if params[:collect_from_store_enabled].present?
          SystemSetting.set_collect_from_store_enabled(params[:collect_from_store_enabled] == "1")
          success_messages << 'Store collection settings updated!'
        end

        # Handle delivery only at shop settings if present
        if params[:delivery_only_at_shop].present?
          delivery_params = {
            delivery_only_at_shop: params[:delivery_only_at_shop],
            shop_addresses: params[:shop_addresses]
          }
          SystemSetting.update_delivery_only_at_shop_settings(delivery_params)
          success_messages << 'Delivery settings updated!'
        end

        success_messages << 'Business settings updated successfully!'
      rescue => e
        redirect_to admin_settings_system_path, alert: "Error updating business settings: #{e.message}"
        return
      end
    end

    # Handle collect from store settings update
    if params[:collect_from_store_update] == "true"
      begin
        collect_from_store_enabled = params[:collect_from_store_enabled] == "1"

        SystemSetting.set_collect_from_store_enabled(collect_from_store_enabled)

        if collect_from_store_enabled
          success_messages << 'Collect From Store feature enabled successfully! You can now manage stores.'
        else
          success_messages << 'Collect From Store feature disabled successfully!'
        end
      rescue => e
        redirect_to admin_settings_system_path, alert: "Error updating Collect From Store settings: #{e.message}"
        return
      end
    end

    # Handle low stock alert settings update
    if params[:low_stock_alert_update] == "true"
      begin
        SystemSetting.update_low_stock_settings(
          low_stock_alert_enabled:   params[:low_stock_alert_enabled],
          low_stock_alert_threshold: params[:low_stock_alert_threshold],
          low_stock_alert_email:     params[:low_stock_alert_email]
        )
        success_messages << 'Low stock alert settings updated successfully!'
      rescue => e
        redirect_to admin_settings_system_path, alert: "Error updating low stock settings: #{e.message}"
        return
      end
    end

    # Handle delivery only at shop settings update
    if params[:delivery_only_at_shop_update] == "true"
      begin
        delivery_params = {
          delivery_only_at_shop: params[:delivery_only_at_shop],
          shop_addresses: params[:shop_addresses]
        }

        SystemSetting.update_delivery_only_at_shop_settings(delivery_params)

        if params[:delivery_only_at_shop] == "1"
          success_messages << 'Delivery Only at Shop feature enabled successfully with addresses!'
        else
          success_messages << 'Delivery Only at Shop feature disabled successfully!'
        end
      rescue => e
        redirect_to admin_settings_system_path, alert: "Error updating Delivery Only at Shop settings: #{e.message}"
        return
      end
    end

    # Handle website theme update
    if params[:website_theme_update] == "true"
      if SystemSetting::WEBSITE_THEMES.key?(params[:website_theme])
        SystemSetting.set_website_theme(params[:website_theme])
        success_messages << 'Website theme updated successfully!'
      else
        redirect_to admin_settings_system_path, alert: 'Invalid website theme selected.'
        return
      end
    end

    if success_messages.any?
      Rails.cache.delete('admin_settings/system_index_settings')
      redirect_to admin_settings_system_path, notice: success_messages.join(' ')
    else
      redirect_to admin_settings_system_path, alert: 'Please enter valid values to update.'
    end
  end

  # POST /admin/settings/system/upload_logo
  def upload_logo
    respond_to do |format|
      if params[:logo].present?
        begin
          result = R2Service.upload(params[:logo], folder: 'business_logo')

          if result[:error]
            format.json { render json: { error: result[:error] }, status: :unprocessable_entity }
          else
            format.json { render json: {
              key: result[:key],
              filename: result[:filename],
              public_url: result[:public_url],
              size: result[:size]
            } }
          end
        rescue => e
          Rails.logger.error "Logo R2 upload exception: #{e.message}"
          format.json { render json: { error: "Upload failed: #{e.message}" }, status: :internal_server_error }
        end
      else
        format.json { render json: { error: "No logo file provided" }, status: :bad_request }
      end
    end
  end

  def preview_invoice_template
    allowed = %w[classic tally modern corporate saffron minimal proforma]
    @preview_template = allowed.include?(params[:template]) ? params[:template] : 'classic'
    @booking       = build_dummy_booking
    @booking_items = build_dummy_booking_items
    if params[:inline].present?
      response.headers['X-Frame-Options'] = 'SAMEORIGIN'
      render template: 'admin/bookings/invoice', layout: false
    else
      render template: 'admin/bookings/invoice', layout: 'invoice'
    end
  end

  private

  # Busted in #update whenever any settings branch succeeds.
  def cached_system_settings_by_key
    Rails.cache.fetch('admin_settings/system_index_settings', expires_in: 2.minutes) do
      SystemSetting.where(key: %w[company_expenses_percentage default_pagination_per_page system_config business_config website_theme])
                   .index_by(&:key)
    end
  end

  def build_dummy_booking
    dummy_customer = OpenStruct.new(
      display_name: 'Rahul Kumar',
      address:      "45, 2nd Cross, Indiranagar\nBengaluru, Karnataka - 560038",
      mobile:       '9876543210',
      gstin:        '29ABCDE1234F1Z5'
    )

    booking = OpenStruct.new(
      invoice_number:  'INV-2025-0001',
      booking_number:  'BK-2025-0001',
      customer_name:   'Rahul Kumar',
      customer:        dummy_customer,
      delivery_address: "45, 2nd Cross, Indiranagar\nBengaluru, Karnataka - 560038",
      customer_phone:  '9876543210',
      shipping_charges: 0
    )
    booking.define_singleton_method(:payment_status_paid?) { false }
    booking
  end

  def build_dummy_booking_items
    product1 = OpenStruct.new(
      name:             'Organic Tomatoes (Grade A)',
      hsn_code:         '07020000',
      unit_type:        'KG',
      gst_enabled:      true,
      gst_percentage:   5.0,
      cgst_percentage:  nil,
      sgst_percentage:  nil,
      igst_percentage:  nil
    )
    product2 = OpenStruct.new(
      name:             'Fresh Coconut Oil 1L',
      hsn_code:         '15131100',
      unit_type:        'PCS',
      gst_enabled:      true,
      gst_percentage:   18.0,
      cgst_percentage:  nil,
      sgst_percentage:  nil,
      igst_percentage:  nil
    )
    product3 = OpenStruct.new(
      name:             'Turmeric Powder 500g',
      hsn_code:         '09103010',
      unit_type:        'PCS',
      gst_enabled:      true,
      gst_percentage:   5.0,
      cgst_percentage:  nil,
      sgst_percentage:  nil,
      igst_percentage:  nil
    )

    [
      OpenStruct.new(quantity: 10, price: 63.0,  product: product1),
      OpenStruct.new(quantity: 3,  price: 354.0, product: product2),
      OpenStruct.new(quantity: 5,  price: 105.0, product: product3)
    ]
  end

  def system_setting_params
    params.require(:system_setting).permit(
      :maintenance_mode, :email_notifications, :backup_frequency, :session_timeout,
      :max_file_upload_size, :company_expenses_percentage, :default_pagination_per_page,
      :default_main_agent_commission, :default_affiliate_commission,
      :default_ambassador_commission, :default_company_expenses
    )
  end

  def generate_qr_code
    require 'rqrcode'

    qr = RQRCode::QRCode.new(@business_setting.upi_id)

    # Generate SVG
    svg = qr.as_svg(
      color: "000",
      shape_rendering: "crispEdges",
      module_size: 6,
      standalone: true
    )

    # Upload to R2 rather than local disk — Render's filesystem is ephemeral
    # and wipes public/qr_codes on every deploy/restart.
    result = R2Service.upload_content(
      svg,
      filename: "upi_qr_#{@business_setting.id}.svg",
      content_type: 'image/svg+xml',
      folder: 'qr_codes'
    )

    if result[:error]
      Rails.logger.error "UPI QR R2 upload failed: #{result[:error]}"
      return
    end

    @business_setting.update(qr_code_path: result[:public_url])
  end
end