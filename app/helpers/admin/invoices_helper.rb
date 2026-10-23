module Admin::InvoicesHelper
  # Builds <option> tags for the invoice line-item "Product" select, expanding
  # multi-quantity products into one option per variant so each variant's own
  # price/description is selectable instead of just the base product price.
  def invoice_product_options(selected_product_id: nil, selected_unit_price: nil)
    options = [content_tag(:option, 'Select Product...', value: '')]

    Product.active.includes(:category, :product_variants).order(:name).each do |product|
      gst_rate = product.gst_enabled ? product.gst_percentage.to_f : 0

      if product.has_multiple_quantities? && product.product_variants.any?
        variants = product.product_variants.sort_by { |v| [v.display_order || 0, v.weight.to_f] }
        # Best-effort match: pick the variant whose price is closest to what was
        # actually saved on the line item, since invoice_items has no variant_id.
        closest_variant = variants.min_by { |v| (invoice_base_price(v.effective_price, gst_rate) - selected_unit_price.to_f).abs } if selected_product_id == product.id

        variants.each do |variant|
          options << content_tag(:option, "#{product.name} - #{variant.label} - ₹#{variant.effective_price}",
            value: product.id,
            data: { price: invoice_base_price(variant.effective_price, gst_rate), description: "#{product.name} - #{variant.label}" },
            selected: selected_product_id == product.id && variant == closest_variant)
        end
      else
        options << content_tag(:option, "#{product.name} - ₹#{product.selling_price}/#{product.unit_type}",
          value: product.id,
          data: { price: invoice_base_price(product.selling_price, gst_rate), description: product.name },
          selected: selected_product_id == product.id)
      end
    end

    safe_join(options)
  end

  # Product/variant prices are GST-inclusive, but invoice line unit_price is the
  # pre-GST base (tax is added back on top), so strip GST before prefilling.
  def invoice_base_price(inclusive_price, gst_rate)
    price = inclusive_price.to_f
    return price unless gst_rate.to_f > 0

    (price / (1 + gst_rate.to_f / 100)).round(2)
  end
end
