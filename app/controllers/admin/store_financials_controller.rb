class Admin::StoreFinancialsController < Admin::ApplicationController
  before_action :authenticate_user!
  before_action(only: [:vendor_tracking]) { require_sidebar_permission!('store_financials_vendor_tracking') }
  before_action(only: [:commission]) { require_sidebar_permission!('store_financials_commission') }
  before_action(only: [:gst_report]) { require_sidebar_permission!('store_financials_gst_report') }

  def vendor_tracking
    @stores = Store.all.order(:name)
    @selected_store_id = params[:store_id].presence

    batch_scope = StockBatch.where.not(store_id: nil)
    batch_scope = batch_scope.where(store_id: @selected_store_id) if @selected_store_id.present?

    # SQL-side GROUP BY instead of loading every StockBatch row and
    # group_by/sum-ing it in Ruby.
    rows = batch_scope.group(:store_id, :vendor_id)
                      .select(
                        :store_id, :vendor_id,
                        'COUNT(*) AS batches_count',
                        'SUM(quantity_purchased) AS items_received',
                        'SUM(quantity_purchased * purchase_price) AS total_cost'
                      )

    vendors_by_id = Vendor.where(id: rows.map(&:vendor_id).compact.uniq).index_by(&:id)
    stores_by_id = @stores.index_by(&:id)

    @store_vendor_data = rows.group_by(&:store_id).map do |store_id, store_rows|
      store = stores_by_id[store_id]
      next unless store

      vendor_breakdown = store_rows.map do |r|
        {
          vendor: vendors_by_id[r.vendor_id],
          batches_count: r.batches_count,
          items_received: r.items_received.to_f,
          total_cost: r.total_cost.to_f
        }
      end.sort_by { |v| -v[:total_cost] }

      {
        store: store,
        vendor_breakdown: vendor_breakdown,
        total_procurement: vendor_breakdown.sum { |v| v[:total_cost] },
        vendors_count: vendor_breakdown.size
      }
    end.compact.sort_by { |d| -d[:total_procurement] }
  end

  def commission
    @stores = Store.all.order(:name)
    @month  = params[:month].present? ? Date.parse(params[:month]) : Date.current.beginning_of_month
    period  = @month.beginning_of_month..@month.end_of_month

    # One grouped query for every store's revenue instead of one query per
    # store (this used to fire N serial round trips for N stores).
    revenue_by_store = Booking.where(store_id: @stores.map(&:id), created_at: period, status: %w[completed delivered])
                              .group(:store_id).sum(:total_amount)

    @commission_data = @stores.map do |store|
      revenue = (revenue_by_store[store.id] || 0).to_f

      pct         = store.commission_percentage.to_f
      store_share = (revenue * pct / 100.0).round(2)
      company_share = (revenue - store_share).round(2)

      {
        store:         store,
        revenue:       revenue,
        commission_pct: pct,
        store_share:   store_share,
        company_share: company_share
      }
    end

    @total_revenue      = @commission_data.sum { |d| d[:revenue] }
    @total_store_share  = @commission_data.sum { |d| d[:store_share] }
    @total_company_share = @commission_data.sum { |d| d[:company_share] }
  end

  def gst_report
    @stores            = Store.all.order(:name)
    @selected_store_id = params[:store_id].presence
    @month             = params[:month].present? ? Date.parse(params[:month]) : Date.current.beginning_of_month
    period             = @month.beginning_of_month..@month.end_of_month

    store_scope = @selected_store_id.present? ? Store.where(id: @selected_store_id) : Store.all.order(:name)
    store_ids = store_scope.map(&:id)

    # 3 grouped queries for every store on the page instead of 3 separate
    # sum/sum/count round trips per store (this used to fire 3×N serial
    # queries for N stores).
    revenue_by_store = Booking.where(store_id: store_ids, created_at: period).group(:store_id).sum(:total_amount)
    tax_by_store     = Booking.where(store_id: store_ids, created_at: period).group(:store_id).sum(:tax_amount)
    count_by_store   = Booking.where(store_id: store_ids, created_at: period).group(:store_id).count

    @gst_data = store_scope.map do |store|
      total_revenue = (revenue_by_store[store.id] || 0).to_f
      total_tax     = (tax_by_store[store.id] || 0).to_f

      {
        store:         store,
        total_revenue: total_revenue,
        total_tax:     total_tax,
        cgst:          (total_tax / 2.0).round(2),
        sgst:          (total_tax / 2.0).round(2),
        igst:          0.0,
        taxable_amount: (total_revenue - total_tax).round(2),
        bookings_count: count_by_store[store.id] || 0
      }
    end

    @grand_total = {
      revenue: @gst_data.sum { |d| d[:total_revenue] },
      tax:     @gst_data.sum { |d| d[:total_tax] },
      cgst:    @gst_data.sum { |d| d[:cgst] },
      sgst:    @gst_data.sum { |d| d[:sgst] }
    }
  end
end
