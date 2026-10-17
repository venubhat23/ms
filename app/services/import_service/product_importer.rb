module ImportService
  class ProductImporter
    require 'csv'

    # Column order for the downloadable template. Mirrors admin/products/new.
    # Product columns are read from the first row of a product; variant_* columns
    # from every row. Rows sharing a name (or SKU) become one product.
    TEMPLATE_HEADERS = [
      # Basic info
      'name*', 'category_name*', 'description', 'sku', 'status', 'product_type',
      'unit_type', 'weight', 'dimensions', 'tags', 'meta_title', 'meta_description',
      'image_url', 'additional_images_urls', 'display_order', 'minimum_stock_alert',
      # Tax
      'hsn_code', 'gst_enabled', 'gst_percentage',
      # Subscription / occasional
      'is_subscription_enabled',
      'is_occasional_product', 'occasional_start_date', 'occasional_end_date',
      'occasional_description', 'occasional_auto_hide',
      # Delivery rule: everywhere | state | city | pincode
      'delivery_rule_type', 'delivery_locations', 'delivery_days', 'delivery_charge',
      # true = variant product (one row per variant), false = simple product
      'has_multiple_quantities',
      # Simple product pricing (has_multiple_quantities = false)
      'price', 'buying_price', 'b2b_price', 'stock', 'discount_type', 'discount_value',
      # Variant columns (has_multiple_quantities = true)
      'variant_weight', 'variant_unit', 'variant_selling_price', 'variant_buying_price',
      'variant_b2b_selling_price', 'variant_stock', 'variant_is_default',
      'variant_discount_enabled', 'variant_discount_type', 'variant_discount_value',
      'variant_gst_percentage', 'variant_display_order'
    ].freeze

    def initialize(uploaded_file)
      @uploaded_file = uploaded_file
      @imported_count = 0
      @skipped_count = 0
      @errors = []
    end

    def import
      return { success: false, error: 'No file provided' } unless @uploaded_file

      begin
        csv_content = SpreadsheetReader.read_csv_text(@uploaded_file)

        csv_data = CSV.parse(csv_content, headers: true)

        validator = CsvValidator.new(@uploaded_file, 'products')
        validation_result = validator.validate

        unless validation_result[:success]
          return { success: false, error: validation_result[:error] }
        end

        product_groups = group_rows_by_product(csv_data)

        Product.transaction do
          product_groups.each do |identifier, row_entries|
            begin
              Product.transaction(requires_new: true) { process_product_group(identifier, row_entries) }
            rescue => e
              @errors << "Product '#{identifier}': #{e.message}"
              @skipped_count += 1
            end
          end
        end

        {
          success: true,
          imported_count: @imported_count,
          skipped_count: @skipped_count,
          errors: @errors
        }

      rescue CSV::MalformedCSVError => e
        { success: false, error: "Invalid CSV format: #{e.message}" }
      rescue => e
        Rails.logger.error "Product import error: #{e.message}"
        { success: false, error: e.message }
      end
    end

    private

    def group_rows_by_product(csv_data)
      groups = {}
      csv_data.each_with_index do |row, index|
        sku = get_row_value(row, 'sku').to_s.strip
        name = get_row_value(row, 'name').to_s.strip
        key = sku.present? ? "sku:#{sku}" : "name:#{name}"
        groups[key] ||= []
        groups[key] << { row: row, row_number: index + 2 }
      end
      groups
    end

    def process_product_group(identifier, row_entries)
      first_row = row_entries.first[:row]
      first_row_number = row_entries.first[:row_number]
      has_multiple = parse_boolean(get_row_value(first_row, 'has_multiple_quantities'))

      existing_product = find_existing_product(first_row)

      if has_multiple
        process_variant_product(first_row, row_entries, existing_product, first_row_number)
      else
        process_simple_product(first_row, first_row_number, existing_product)
      end
    end

    def find_existing_product(row)
      sku = get_row_value(row, 'sku').to_s.strip
      name = get_row_value(row, 'name').to_s.strip
      product = Product.find_by(sku: sku) if sku.present?
      product ||= Product.find_by(name: name)
      product
    end

    def process_simple_product(row, row_number, existing_product)
      if existing_product
        @errors << "Row #{row_number}: Product '#{get_row_value(row, 'name')}' already exists"
        @skipped_count += 1
        return
      end

      category = find_or_create_category_from_row(row)
      product_params = build_simple_product_params(row, category)
      Product.create!(product_params)
      @imported_count += 1
    end

    def process_variant_product(first_row, row_entries, existing_product, first_row_number)
      category = find_or_create_category_from_row(first_row)

      valid_variants = []
      row_entries.each_with_index do |entry, idx|
        row = entry[:row]
        row_number = entry[:row_number]

        weight = parse_decimal(get_row_value(row, 'variant_weight'))
        selling_price = parse_decimal(get_row_value(row, 'variant_selling_price'))

        if weight.blank? || selling_price.blank?
          @errors << "Row #{row_number}: variant_weight and variant_selling_price are required for variant products"
          @skipped_count += 1
          next
        end

        unit = parse_variant_unit(get_row_value(row, 'variant_unit'))
        is_default = parse_boolean(get_row_value(row, 'variant_is_default'))
        is_default = (idx == 0) unless row_entries.any? { |e| parse_boolean(get_row_value(e[:row], 'variant_is_default')) }

        valid_variants << {
          weight: weight,
          unit: unit,
          selling_price: selling_price,
          buying_price: parse_decimal(get_row_value(row, 'variant_buying_price')),
          b2b_selling_price: parse_decimal(get_row_value(row, 'variant_b2b_selling_price')),
          available_stock: parse_integer(get_row_value(row, 'variant_stock')) || 0,
          is_default: is_default,
          discount_enabled: parse_boolean(get_row_value(row, 'variant_discount_enabled')),
          discount_type: get_row_value(row, 'variant_discount_type').presence,
          discount_value: parse_decimal(get_row_value(row, 'variant_discount_value')),
          gst_percentage: parse_decimal(get_row_value(row, 'variant_gst_percentage')),
          display_order: parse_integer(get_row_value(row, 'variant_display_order')) || idx
        }
      end

      return if valid_variants.empty?

      if existing_product
        valid_variants.each do |attrs|
          next if existing_product.product_variants.exists?(weight: attrs[:weight], unit: attrs[:unit])
          existing_product.product_variants.create!(attrs)
        end
        @imported_count += 1
      else
        product = Product.new(build_variant_product_params(first_row, category, valid_variants))
        valid_variants.each { |attrs| product.product_variants.build(attrs) }
        product.save!
        @imported_count += 1
      end
    end

    def build_simple_product_params(row, category)
      price = parse_decimal(get_row_value(row, 'price'))
      params = {
        name: get_row_value(row, 'name'),
        description: get_row_value(row, 'description'),
        category_id: category&.id,
        price: price,
        stock: parse_integer(get_row_value(row, 'stock')) || 0,
        status: parse_status(get_row_value(row, 'status')),
        sku: generate_sku(row),
        weight: parse_decimal(get_row_value(row, 'weight')),
        gst_enabled: parse_boolean(get_row_value(row, 'gst_enabled')),
        gst_percentage: parse_decimal(get_row_value(row, 'gst_percentage')),
        buying_price: parse_decimal(get_row_value(row, 'buying_price')),
        b2b_price: parse_decimal(get_row_value(row, 'b2b_price')),
        unit_type: parse_unit_type(get_row_value(row, 'unit_type')),
        has_multiple_quantities: false,
        today_price: price,
        last_price_update: Time.current
      }.merge(common_product_params(row))

      discount_type = get_row_value(row, 'discount_type').to_s.strip.downcase
      discount_value = parse_decimal(get_row_value(row, 'discount_value'))
      if %w[percentage fixed].include?(discount_type) && discount_value.to_f > 0
        params[:discount_type] = discount_type
        params[:discount_value] = discount_value
        params[:original_price] = price
      elsif get_row_value(row, 'discount_price').present?
        # Legacy column from older templates
        params[:discount_price] = parse_decimal(get_row_value(row, 'discount_price'))
      end

      if params[:gst_enabled] && params[:price] && params[:gst_percentage]
        gst_rate = params[:gst_percentage] / 100
        params[:gst_amount] = params[:price] * gst_rate
        params[:final_amount_with_gst] = params[:price] + params[:gst_amount]

        half = params[:gst_percentage] / 2
        params[:cgst_percentage] = half
        params[:sgst_percentage] = half
        params[:cgst_amount] = params[:gst_amount] / 2
        params[:sgst_amount] = params[:gst_amount] / 2
      end

      params
    end

    def build_variant_product_params(row, category, variants)
      first_unit = variants.first&.dig(:unit) || 'Kg'
      {
        name: get_row_value(row, 'name'),
        description: get_row_value(row, 'description'),
        category_id: category&.id,
        price: 0,
        stock: 0,
        status: parse_status(get_row_value(row, 'status')),
        sku: generate_sku(row),
        has_multiple_quantities: true,
        gst_enabled: parse_boolean(get_row_value(row, 'gst_enabled')),
        gst_percentage: parse_decimal(get_row_value(row, 'gst_percentage')),
        weight: parse_decimal(get_row_value(row, 'weight')),
        unit_type: parse_unit_type(get_row_value(row, 'unit_type').presence || first_unit),
        today_price: 0,
        last_price_update: Time.current
      }.merge(common_product_params(row))
    end

    # Fields shared by simple and variant products (everything on the New
    # Product form that isn't pricing/stock).
    def common_product_params(row)
      params = {
        dimensions: get_row_value(row, 'dimensions'),
        hsn_code: get_row_value(row, 'hsn_code'),
        product_type: parse_product_type(get_row_value(row, 'product_type')),
        is_subscription_enabled: parse_boolean(get_row_value(row, 'is_subscription_enabled')),
        tags: get_row_value(row, 'tags'),
        meta_title: get_row_value(row, 'meta_title').presence,
        meta_description: get_row_value(row, 'meta_description').presence,
        image_url: get_row_value(row, 'image_url').presence,
        minimum_stock_alert: parse_integer(get_row_value(row, 'minimum_stock_alert')),
        display_order: parse_integer(get_row_value(row, 'display_order'))
      }

      extra_images = get_row_value(row, 'additional_images_urls').to_s.split(',').map(&:strip).reject(&:blank?)
      params[:additional_images_urls] = extra_images.to_json if extra_images.any?

      if parse_boolean(get_row_value(row, 'is_occasional_product'))
        params[:is_occasional_product] = true
        params[:occasional_start_date] = parse_datetime(get_row_value(row, 'occasional_start_date'))
        params[:occasional_end_date] = parse_datetime(get_row_value(row, 'occasional_end_date'))
        params[:occasional_description] = get_row_value(row, 'occasional_description').presence
        auto_hide = get_row_value(row, 'occasional_auto_hide')
        params[:occasional_auto_hide] = auto_hide.blank? ? true : parse_boolean(auto_hide)
      end

      params[:delivery_rules_attributes] = [build_delivery_rule(row)]
      params
    end

    # Same default the New Product form uses: one "everywhere" rule.
    def build_delivery_rule(row)
      rule_type = get_row_value(row, 'delivery_rule_type').to_s.strip.downcase
      rule_type = 'everywhere' unless %w[state city pincode].include?(rule_type)
      locations = get_row_value(row, 'delivery_locations').to_s.split(',').map(&:strip).reject(&:blank?)
      rule_type = 'everywhere' if locations.empty?

      {
        rule_type: rule_type,
        location_data: rule_type == 'everywhere' ? '[]' : locations.to_json,
        delivery_days: parse_integer(get_row_value(row, 'delivery_days')),
        delivery_charge: parse_decimal(get_row_value(row, 'delivery_charge')) || 0
      }
    end

    def find_or_create_category_from_row(row)
      if get_row_value(row, 'category_id').present?
        begin
          return Category.find(Integer(get_row_value(row, 'category_id')))
        rescue ArgumentError, ActiveRecord::RecordNotFound
        end
      end
      find_or_create_category(get_row_value(row, 'category_name'))
    end

    def find_or_create_category(category_name)
      return nil if category_name.blank?
      name = category_name.to_s.strip
      Category.find_by(name: name) ||
        Category.create!(name: name, status: true, display_order: Category.count + 1)
    end

    def generate_sku(row)
      return get_row_value(row, 'sku') if get_row_value(row, 'sku').present?

      base = get_row_value(row, 'name').to_s.gsub(/[^a-zA-Z0-9]/, '').upcase[0..5]
      counter = 1
      sku = "#{base}#{counter.to_s.rjust(3, '0')}"
      while Product.exists?(sku: sku)
        counter += 1
        sku = "#{base}#{counter.to_s.rjust(3, '0')}"
      end
      sku
    end

    def parse_decimal(value)
      return nil if value.blank?
      BigDecimal(value.to_s)
    rescue ArgumentError
      nil
    end

    def parse_integer(value)
      return nil if value.blank?
      Integer(value.to_s)
    rescue ArgumentError
      nil
    end

    def parse_datetime(value)
      return nil if value.blank?
      Time.zone.parse(value.to_s)
    rescue ArgumentError
      nil
    end

    def parse_boolean(value)
      return false if value.blank?
      ['true', '1', 'yes', 'on'].include?(value.to_s.downcase)
    end

    def parse_status(value)
      return 'active' if value.blank?
      value.to_s.downcase == 'active' ? 'active' : 'inactive'
    end

    def parse_product_type(value)
      return 'Grocery' if value.blank?
      valid = Product::PRODUCT_TYPES.map(&:last)
      valid.find { |t| t.downcase == value.to_s.strip.downcase } || 'Grocery'
    end

    def parse_unit_type(value)
      return 'Piece' if value.blank?
      valid = Product::UNIT_TYPES.map(&:last)
      valid.find { |u| u.downcase == value.to_s.strip.downcase } || 'Piece'
    end

    def parse_variant_unit(value)
      return 'Kg' if value.blank?
      valid = ProductVariant::UNIT_TYPES.map(&:last)
      valid.find { |u| u.downcase == value.to_s.strip.downcase } || 'Kg'
    end

    def get_row_value(row, field_name)
      row["#{field_name}*"] || row[field_name]
    end
  end
end
