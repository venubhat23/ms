class Customer::OrdersController < Customer::BaseController
  before_action :set_booking, only: [:show, :invoice]

  def index
    customer = current_customer

    # Single GROUP BY replaces 7 separate count queries fired from the view.
    # Started async so it overlaps with the listing query below.
    status_counts_promise = customer.bookings.group(:status).async_count

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
    # load_async: the view's `.any?` then reads the loaded page instead of
    # firing its own EXISTS query.
    @bookings = @bookings.page(params[:page]).per(@per_page).load_async

    status_counts = status_counts_promise.value
    @total_order_count    = status_counts.values.sum
    @stat_pending         = status_counts['ordered_and_delivery_pending'] || 0
    @stat_processing      = (status_counts['confirmed'] || 0) + (status_counts['processing'] || 0) + (status_counts['packed'] || 0)
    @stat_shipped         = (status_counts['shipped'] || 0) + (status_counts['out_for_delivery'] || 0)
    @stat_completed       = status_counts['completed'] || 0
    @stat_issues          = (status_counts['cancelled'] || 0) + (status_counts['returned'] || 0)

    # Unfiltered list total == the status total we already have; seed
    # Kaminari's memo so pagination doesn't issue its own COUNT(*).
    unfiltered = params[:search].blank? && params[:status].blank? && params[:date_from].blank?
    @bookings.instance_variable_set(:@total_count, @total_order_count) if unfiltered
  end

  def show
    @booking_items = @booking.booking_items # fully preloaded by set_booking
  end

  def invoice
    respond_to do |format|
      format.html { render template: 'customer/orders/invoice', layout: 'invoice' }
      format.pdf do
        pdf = WickedPdf.new.pdf_from_string(
          render_to_string('customer/orders/invoice', formats: [:html], layout: 'invoice_pdf'),
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
    # Ensure customer can only access their own bookings. Preloading
    # booking_items: :product here (not just in #show) also fixes the N+1 in
    # the #invoice view, which walks @booking.booking_items/item.product directly.
    # eager_load: booking + items + products + category + images in ONE
    # JOIN query (instead of one round trip per association level).
    # where(id:).to_a.first instead of find: find + a has_many eager_load
    # adds a separate "limited ids" query.
    @booking = current_customer.bookings
                               .eager_load(booking_items: { product: [:category, { image_attachment: :blob }, { additional_images_attachments: :blob }] })
                               .order('booking_items.id')
                               .where(id: params[:id]).to_a.first
    raise ActiveRecord::RecordNotFound unless @booking
  rescue ActiveRecord::RecordNotFound
    redirect_to customer_orders_path, alert: 'Order not found.'
  end
end