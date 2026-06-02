module GstCalculatorHelper
  # GST-inclusive price extraction — single source of truth used by show, edit, invoice views.
  # Prices stored on booking items already include GST.
  # Formula: base = round(price) / (1 + rate/100),  tax = round(price) - base

  # Returns aggregate summary for a collection of booking items.
  # { base:, tax:, cgst:, sgst:, igst:, avg_tax_rate:, tax_display: }
  def gst_booking_summary(booking_items)
    base = 0.0; tax = 0.0; cgst = 0.0; sgst = 0.0; igst = 0.0
    total_rate = 0.0; gst_count = 0

    Array(booking_items).each do |item|
      t = gst_item_totals(item)
      base  += t[:base];  tax  += t[:tax]
      cgst  += t[:cgst];  sgst += t[:sgst];  igst += t[:igst]
      if t[:gst_rate] > 0
        total_rate += t[:gst_rate]
        gst_count  += 1
      end
    end

    avg = gst_count > 0 ? (total_rate / gst_count.to_f).round(2) : 0
    { base: base.round(2), tax: tax.round(2),
      cgst: cgst.round(2), sgst: sgst.round(2), igst: igst.round(2),
      avg_tax_rate: avg,
      tax_display: avg.to_i == avg ? avg.to_i : avg }
  end

  # Returns per-rate CGST/SGST groupings for the invoice tax table.
  # { cgst: { rate => amount }, sgst: { rate => amount } }
  def gst_rate_groups(booking_items)
    cgst_groups = {}
    sgst_groups = {}

    Array(booking_items).each do |item|
      t = gst_item_totals(item)
      next unless t[:gst_rate] > 0

      cr = t[:cgst_rate]; sr = t[:sgst_rate]
      cgst_groups[cr] = (cgst_groups[cr] || 0) + t[:cgst] if cr > 0
      sgst_groups[sr] = (sgst_groups[sr] || 0) + t[:sgst] if sr > 0
    end

    { cgst: cgst_groups, sgst: sgst_groups }
  end

  # Returns GST breakdown for a single booking item.
  # { base:, tax:, cgst:, sgst:, igst:, gst_rate:, cgst_rate:, sgst_rate: }
  def gst_item_totals(item)
    qty        = item.quantity.to_f
    unit_price = (item.price || 0).to_f

    unless item.product&.gst_enabled && item.product.gst_percentage.to_f > 0
      return { base: (unit_price * qty).round(2), tax: 0.0,
               cgst: 0.0, sgst: 0.0, igst: 0.0,
               gst_rate: 0.0, cgst_rate: 0.0, sgst_rate: 0.0 }
    end

    total_rate = item.product.gst_percentage.to_f
    if item.product.cgst_percentage.present? && item.product.sgst_percentage.present?
      cgst_rate  = item.product.cgst_percentage.to_f
      sgst_rate  = item.product.sgst_percentage.to_f
      igst_rate  = item.product.igst_percentage.to_f
      total_rate = cgst_rate + sgst_rate + igst_rate
    else
      cgst_rate = total_rate / 2.0
      sgst_rate = total_rate / 2.0
      igst_rate = 0.0
    end

    rounded_final = unit_price.round
    rounded_base  = (rounded_final / (1 + total_rate / 100.0)).round
    item_base     = rounded_base * qty
    item_tax      = (rounded_final - rounded_base) * qty

    cgst_amt = (item_tax * cgst_rate / total_rate).round(2)
    sgst_amt = (item_tax * sgst_rate / total_rate).round(2)
    igst_amt = (item_tax * igst_rate / total_rate).round(2)
    # Absorb any rounding residual into CGST
    diff = item_tax.round(2) - cgst_amt - sgst_amt - igst_amt
    cgst_amt += diff if diff != 0

    { base: item_base.round(2), tax: item_tax.round(2),
      cgst: cgst_amt, sgst: sgst_amt, igst: igst_amt,
      gst_rate: total_rate, cgst_rate: cgst_rate, sgst_rate: sgst_rate }
  end
end
