class Customer::OrdersController < Customer::BaseController
  before_action :set_booking, only: [:show, :invoice]

  def index
    customer = current_customer

    # Single GROUP BY replaces 7 separate count queries fired from the view
    status_counts = customer.bookings.group(:status).count
    @total_order_count    = status_counts.values.sum
    @stat_pending         = status_counts['ordered_and_delivery_pending'] || 0
    @stat_processing      = (status_counts['confirmed'] || 0) + (status_counts['processing'] || 0) + (status_counts['packed'] || 0)
    @stat_shipped         = (status_counts['shipped'] || 0) + (status_counts['out_for_delivery'] || 0)
    @stat_completed       = status_counts['completed'] || 0
    @stat_issues          = (status_counts['cancelled'] || 0) + (status_counts['returned'] || 0)

    # Paginated list — includes :booking_items for view; :user/:franchise only if needed
    @bookings = customer.bookings
                        .includes(:booking_items)
                        .recent

    if params[:search].present?
      @bookings = @bookings.where(
        "booking_number LIKE ? OR customer_name LIKE ? OR customer_email LIKE ? OR customer_phone LIKE ?",
        "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%"
      )
    end

    @bookings = @bookings.where(status: params[:status]) if params[:status].present? && params[:status].strip != ''

    if params[:date_from].present? && params[:date_to].present?
      @bookings = @bookings.where(created_at: params[:date_from]..params[:date_to])
    end

    @per_page = SystemSetting.default_pagination_per_page || 20
    @bookings = @bookings.page(params[:page]).per(@per_page)
  end

  def show
    @booking_items = @booking.booking_items.includes(product: [:category, image_attachment: :blob, additional_images_attachments: :blob])
  end

  def invoice
    respond_to do |format|
      format.html { render template: 'customer/orders/invoice', layout: 'invoice' }
      format.pdf do
        pdf = WickedPdf.new.pdf_from_string(
          render_to_string('customer/orders/invoice', layout: 'invoice_pdf'),
          page_size: 'A4',
          margin: {
            top: '0.75in',
            bottom: '0.75in',
            left: '0.75in',
            right: '0.75in'
          },
          dpi: 300,
          encoding: 'UTF-8',
          disable_smart_shrinking: true,
          print_media_type: true,
          orientation: 'Portrait'
        )

        invoice_filename = "invoice-#{@booking.invoice_number || @booking.booking_number}-#{Date.current.strftime('%Y%m%d')}.pdf"

        send_data pdf,
                  filename: invoice_filename,
                  type: 'application/pdf',
                  disposition: 'attachment'
      end
    end
  end

  private

  def set_booking
    # Ensure customer can only access their own bookings
    @booking = current_customer.bookings.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to customer_orders_path, alert: 'Order not found.'
  end
end