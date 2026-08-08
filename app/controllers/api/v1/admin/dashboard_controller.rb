class Api::V1::Admin::DashboardController < Api::V1::Admin::BaseController
  # GET /api/v1/admin/dashboard
  def index
    data = Rails.cache.fetch('api:admin:dashboard:small', expires_in: 5.minutes) do
      today = Date.current
      booking_counts = Booking.group(:status).count

      {
        total_revenue: Booking.sum(:total_amount).to_f,
        today_revenue: Booking.where(created_at: today.beginning_of_day..today.end_of_day).sum(:total_amount).to_f,
        month_revenue: Booking.where(created_at: today.beginning_of_month..today.end_of_month).sum(:total_amount).to_f,
        total_bookings: booking_counts.values.sum,
        pending_bookings: %w[ordered_and_delivery_pending confirmed processing packed].sum { |s| booking_counts[s].to_i },
        shipped_bookings: %w[shipped out_for_delivery].sum { |s| booking_counts[s].to_i },
        completed_bookings: %w[delivered completed].sum { |s| booking_counts[s].to_i },
        cancelled_bookings: booking_counts['cancelled'].to_i,
        total_products: Product.count,
        active_products: Product.active.count,
        out_of_stock_products: Product.where(stock: 0).count,
        total_customers: Customer.count,
        recent_bookings: Booking.includes(:customer).order(created_at: :desc).limit(5).map do |b|
          {
            id: b.id,
            booking_number: b.booking_number,
            customer_name: b.customer_name.presence || b.customer&.display_name,
            status: b.status,
            total_amount: b.total_amount.to_f,
            created_at: b.created_at
          }
        end
      }
    end

    render_success(data)
  end
end
