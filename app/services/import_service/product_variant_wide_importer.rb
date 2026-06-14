module ImportService
  # Handles the "wide" CSV format where one row = one product with up to 5 variants.
  # Columns: name*, category*, product_type*, status, description, is_subscription_enabled,
  #          is_discounted, discount_type, discount_value, gst_enabled, gst_percentage,
  #          hsn_code, is_occasional_product,
  #          weight1*, unit1*, selling_price1*, buying_price1*, stock1*,
  #          weight2,  unit2,  selling_price2,  buying_price2,  stock2,
  #          ...up to weight5/unit5/selling_price5/buying_price5/stock5
  class ProductVariantWideImporter
    require 'csv'

    MAX_VARIANTS = 5

    def initialize(uploaded_file)
      @uploaded_file = uploaded_file
      @imported_count = 0
      @skipped_count  = 0
      @errors         = []
    end

    def import
      return { success: false, error: 'No file provided' } unless @uploaded_file

      begin
        raw = @uploaded_file.read
        sep = detect_separator(raw)
        csv_data = CSV.parse(raw, headers: true, col_sep: sep)

        Product.transaction do
          csv_data.each_with_index do |row, idx|
            row_number = idx + 2
            begin
              import_row(row, row_number)
            rescue => e
              @errors << "Row #{row_number}: #{e.message}"
              @skipped_count += 1
            end
          end
        end

        { success: true, imported_count: @imported_count, skipped_count: @skipped_count, errors: @errors }

      rescue CSV::MalformedCSVError => e
        { success: false, error: "Invalid CSV format: #{e.message}" }
      rescue => e
        Rails.logger.error "ProductVariantWideImporter error: #{e.message}\n#{e.backtrace.first(5).join("\n")}"
        { success: false, error: e.message }
      end
    end

    private

    def detect_separator(content)
      first_line = content.lines.first.to_s
      first_line.count("\t") > first_line.count(",") ? "\t" : ","
    end

    def import_row(row, row_number)
      name = val(row, 'name').strip
      if name.blank?
        @errors << "Row #{row_number}: name is required"
        @skipped_count += 1
        return
      end

      variants = collect_variants(row, row_number)
      if variants.empty?
        @errors << "Row #{row_number}: '#{name}' — at least one variant with weight and selling_price is required"
        @skipped_count += 1
        return
      end

      # Mark first variant as default
      variants.first[:is_default] = true

      existing = Product.find_by(name: name)
      if existing
        variants.each do |attrs|
          next if existing.product_variants.exists?(weight: attrs[:weight], unit: attrs[:unit])
          existing.product_variants.create!(attrs)
        end
        @imported_count += 1
      else
        category = find_or_create_category(val(row, 'category'))
        product  = Product.new(build_product_params(row, category, variants))
        variants.each { |attrs| product.product_variants.build(attrs) }
        product.save!
        @imported_count += 1
      end
    end

    def collect_variants(row, row_number)
      variants = []
      MAX_VARIANTS.times do |i|
        n      = i + 1
        weight = parse_decimal(val(row, "weight#{n}"))
        price  = parse_decimal(val(row, "selling_price#{n}"))

        # Empty slot — skip silently
        next if weight.nil? && price.nil? && val(row, "unit#{n}").blank?

        if weight.nil? || price.nil?
          @errors << "Row #{row_number} variant #{n}: both weight and selling_price are required"
          next
        end

        variants << {
          weight:          weight,
          unit:            parse_unit(val(row, "unit#{n}")),
          selling_price:   price,
          buying_price:    parse_decimal(val(row, "buying_price#{n}")),
          available_stock: parse_integer(val(row, "stock#{n}")) || 0,
          is_default:      false,
          display_order:   i
        }
      end
      variants
    end

    def build_product_params(row, category, variants)
      {
        name:                    val(row, 'name').strip,
        description:             val(row, 'description').presence,
        category_id:             category&.id,
        status:                  parse_status(val(row, 'status')),
        product_type:            parse_product_type(val(row, 'product_type')),
        is_subscription_enabled: parse_bool(val(row, 'is_subscription_enabled')),
        is_occasional_product:   parse_bool(val(row, 'is_occasional_product')),
        is_discounted:           parse_bool(val(row, 'is_discounted')),
        discount_type:           val(row, 'discount_type').presence,
        discount_value:          parse_decimal(val(row, 'discount_value')),
        gst_enabled:             parse_bool(val(row, 'gst_enabled')),
        gst_percentage:          parse_decimal(val(row, 'gst_percentage')),
        hsn_code:                val(row, 'hsn_code').presence,
        has_multiple_quantities: true,
        unit_type:               parse_unit(variants.first[:unit].to_s),
        price:                   0,
        stock:                   0,
        today_price:             0,
        last_price_update:       Time.current,
        sku:                     generate_sku(val(row, 'name').strip)
      }
    end

    def find_or_create_category(name)
      return nil if name.blank?
      n = name.strip
      Category.find_by(name: n) ||
        Category.create!(name: n, status: true, display_order: Category.count + 1)
    end

    def generate_sku(name)
      base    = name.gsub(/[^a-zA-Z0-9]/, '').upcase[0..5]
      counter = 1
      sku     = "#{base}#{counter.to_s.rjust(3, '0')}"
      while Product.exists?(sku: sku)
        counter += 1
        sku = "#{base}#{counter.to_s.rjust(3, '0')}"
      end
      sku
    end

    # Reads column trying both plain name and name* (required-field marker)
    def val(row, key)
      (row["#{key}*"] || row[key] || '').to_s.strip
    end

    def parse_bool(v)
      %w[true 1 yes].include?(v.to_s.downcase.strip)
    end

    def parse_decimal(v)
      return nil if v.blank?
      BigDecimal(v.to_s.gsub(/[^\d.]/, ''))
    rescue ArgumentError, TypeError
      nil
    end

    def parse_integer(v)
      return nil if v.blank?
      v.to_s.to_i
    end

    def parse_status(v)
      v.to_s.downcase == 'inactive' ? 'inactive' : 'active'
    end

    def parse_product_type(v)
      valid = Product::PRODUCT_TYPES.map(&:last)
      valid.find { |t| t.casecmp?(v.to_s.strip) } || 'Grocery'
    end

    def parse_unit(v)
      valid = Product::UNIT_TYPES.map(&:last)
      valid.find { |u| u.casecmp?(v.to_s.strip) } || 'Kg'
    end
  end
end
