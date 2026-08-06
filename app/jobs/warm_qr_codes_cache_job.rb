class WarmQrCodesCacheJob < ApplicationJob
  queue_as :default

  # Keeps Admin::QrCodesController#index's default (no-search) product list
  # warm ahead of its expiry, and pre-generates each product's QR SVG cache
  # entry too — same rationale as the other Warm*CacheJob jobs.
  def perform
    products = Rails.cache.fetch('admin_qr_codes/all_products', expires_in: 5.minutes) do
      Product.where.not(barcode: nil)
             .select(:id, :name, :barcode, :sku, :category_id)
             .includes(:category)
             .order(:name).to_a
    end

    products.each(&:qr_code_svg)
  end
end
