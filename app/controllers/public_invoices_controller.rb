# app/controllers/public_invoices_controller.rb
class PublicInvoicesController < ApplicationController
  include ActionController::MimeResponds

  # Skip authentication for all actions in this controller
  skip_before_action :authenticate_user!
  # Skip CanCan load_and_authorize_resource since this controller doesn't follow standard resource naming
  skip_load_and_authorize_resource
  layout false

  before_action :find_invoice, only: [:show]

  private

  def find_invoice
    @invoice = Invoice.find_by!(share_token: params[:token])
    @customer = @invoice.customer
    @business_settings = SystemSetting.business_settings
  end

  public

  def show
    respond_to do |format|
      format.html { render template: 'public_invoices/show' }
      format.pdf do
        # Simple test PDF generation
        html = <<~HTML
          <!DOCTYPE html>
          <html>
          <head>
            <style>
              body { font-family: Arial, sans-serif; }
              .invoice-header { text-align: center; margin-bottom: 20px; }
              .invoice-details { margin: 20px 0; }
              table { width: 100%; border-collapse: collapse; }
              th, td { padding: 8px; text-align: left; border-bottom: 1px solid #ddd; }
            </style>
          </head>
          <body>
            <div class="invoice-header">
              <h1>TAX INVOICE</h1>
              <h2>Atma Nirbhar Farm</h2>
            </div>
            <div class="invoice-details">
              <p><strong>Invoice Number:</strong> #{@invoice.invoice_number}</p>
              <p><strong>Customer:</strong> #{@customer&.display_name || 'N/A'}</p>
              <p><strong>Date:</strong> #{@invoice.invoice_date&.strftime('%d/%m/%Y') || Date.current.strftime('%d/%m/%Y')}</p>
              <p><strong>Total Amount:</strong> ₹#{@invoice.total_amount}</p>
            </div>
          </body>
          </html>
        HTML

        pdf = WickedPdf.new.pdf_from_string(
          html,
          page_size: 'A4',
          orientation: 'Portrait',
          margin: { top: 10, bottom: 10, left: 10, right: 10 }
        )

        send_data(pdf,
                  filename: "Invoice_#{@invoice.invoice_number}.pdf",
                  type: 'application/pdf',
                  disposition: 'inline')
      end
    end
  rescue ActiveRecord::RecordNotFound
    render template: 'public_invoices/not_found', status: :not_found
  end

  def index
    # Start with optimized base query for regular invoices - include all needed associations
    @invoices = Invoice.includes(:customer)

    # Apply filters
    if params[:customer_name].present?
      # Use case-insensitive search that works across databases
      search_term = "%#{params[:customer_name].downcase}%"
      @invoices = @invoices.joins(:customer)
                          .where("LOWER(customers.first_name) LIKE ? OR LOWER(customers.last_name) LIKE ? OR LOWER(CONCAT(customers.first_name, ' ', customers.last_name)) LIKE ?", search_term, search_term, search_term)
    end

    if params[:month].present? && params[:month] != 'all'
      @invoices = @invoices.where("EXTRACT(MONTH FROM invoice_date) = ?", params[:month].to_i)
    end

    if params[:status].present? && params[:status] != 'all'
      @invoices = @invoices.where(status: params[:status])
    end

    # Apply sorting
    case params[:sort_by]
    when 'amount_high_to_low'
      @invoices = @invoices.order(total_amount: :desc, created_at: :desc)
    when 'amount_low_to_high'
      @invoices = @invoices.order(total_amount: :asc, created_at: :desc)
    when 'date_newest'
      @invoices = @invoices.order(created_at: :desc)
    when 'date_oldest'
      @invoices = @invoices.order(created_at: :asc)
    else
      # Default: sort by highest amount first
      @invoices = @invoices.order(total_amount: :desc, created_at: :desc)
    end

    # Previously loaded the entire invoices table into memory on every hit —
    # paginate instead. The view (app/views/public_invoices/index.html.erb)
    # renders a `paginate @invoices` control so pages beyond the first stay
    # reachable rather than silently disappearing. total_count comes off the
    # same paginated relation (Kaminari memoizes it) so this stays a single
    # COUNT round trip rather than an extra one.
    per_page = SystemSetting.default_pagination_per_page || 20
    @invoices = @invoices.page(params[:page]).per(per_page)
    @total_invoice_count = @invoices.total_count

    # The view backfills a blank share_token per invoice as it renders each
    # one (generate_share_token + save!) — that loop is now bounded to this
    # page's rows instead of the whole table, simply by virtue of @invoices
    # itself being paginated above. Nothing further to do here.
  end

  def complete
    @invoice = Invoice.find(params[:id])

    if @invoice.update(status: 'paid', payment_status: 'fully_paid', paid_at: Time.current)
      render json: {
        success: true,
        message: "Invoice ##{@invoice.invoice_number} marked as completed successfully!"
      }
    else
      render json: {
        success: false,
        message: "Failed to complete invoice: #{@invoice.errors.full_messages.join(', ')}"
      }
    end
  rescue ActiveRecord::RecordNotFound
    render json: {
      success: false,
      message: "Invoice not found"
    }, status: :not_found
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    invoice_number = @invoice.invoice_number

    # Delete the invoice
    @invoice.destroy!

    render json: {
      success: true,
      message: "Invoice ##{invoice_number} and all associated items deleted successfully!"
    }
  rescue ActiveRecord::RecordNotFound
    render json: {
      success: false,
      message: "Invoice not found"
    }, status: :not_found
  rescue => e
    render json: {
      success: false,
      message: "Failed to delete invoice: #{e.message}"
    }, status: :unprocessable_entity
  end
end