namespace :invoices do
  # Repairs invoice line items where a GST-inclusive product/variant price was
  # saved as the pre-GST unit_price (the invoice edit form used to prefill it),
  # so the invoice added GST on top again (e.g. ₹450 shown as ₹472.50).
  # A line is fixed only when its unit_price is exactly a current inclusive
  # price and not a valid base price. Also resets
  # product_variants.final_price_with_gst, which used to add GST on top.
  #
  # Dry run by default; pass APPLY=1 to write.
  #   bin/rails invoices:repair_double_gst
  #   APPLY=1 bin/rails invoices:repair_double_gst
  desc "Fix invoice items whose unit_price was a GST-inclusive price"
  task repair_double_gst: :environment do
    apply = ENV["APPLY"] == "1"
    items_fixed = 0
    variants_fixed = 0

    ProductVariant.find_each do |variant|
      next if (variant.final_price_with_gst.to_f - variant.effective_price.to_f).abs < 0.01

      variants_fixed += 1
      puts "Variant ##{variant.id} (#{variant.product&.name} #{variant.label}): final_price_with_gst ₹#{variant.final_price_with_gst} -> ₹#{variant.effective_price}"
      variant.update_columns(final_price_with_gst: variant.effective_price) if apply
    end

    Invoice.includes(invoice_items: { product: :product_variants }).find_each do |invoice|
      bad_items = invoice.invoice_items.filter_map do |item|
        product = item.product
        next unless product&.gst_enabled? && product.gst_percentage.to_f > 0

        rate = product.gst_percentage.to_f
        inclusive = [product.price, product.selling_price, *product.product_variants.map(&:effective_price)]
                      .compact.map(&:to_f).uniq
        bases = inclusive.map { |c| c / (1 + rate / 100) }
        next if bases.any? { |b| (item.unit_price.to_f - b).abs < 0.01 }

        match = inclusive.find { |c| (item.unit_price.to_f - c).abs < 0.01 }
        [item, (match / (1 + rate / 100)).round(2)] if match
      end
      next if bad_items.empty?

      bad_items.each do |item, base|
        items_fixed += 1
        puts "#{invoice.invoice_number} (##{invoice.id}): #{item.product.name} unit_price ₹#{item.unit_price} -> ₹#{base}"
      end
      next unless apply

      Invoice.transaction do
        bad_items.each { |item, base| item.update!(unit_price: base) }
        invoice.invoice_items.reset
        invoice.save!
      end
      puts "  total now ₹#{invoice.total_amount}"
    end

    puts "#{apply ? 'Fixed' : 'Would fix'} #{items_fixed} invoice item(s), #{variants_fixed} variant(s).#{' Re-run with APPLY=1 to write.' unless apply}"
  end
end
