class Api::V1::Admin::OrdersController < Api::V1::Admin::BaseController
  # GET /api/v1/admin/orders
  def index
    orders = Order.includes(:customer).order(created_at: :desc)
    orders = orders.where(status: params[:status]) if params[:status].present?
    orders = orders.where(
      "order_number ILIKE ? OR customer_name ILIKE ? OR tracking_number ILIKE ?",
      "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%"
    ) if params[:search].present?

    page = params[:page] || 1
    per_page = params[:per_page] || 20
    orders = orders.page(page).per(per_page)

    render_success(
      orders: orders.map { |o| order_response(o) },
      pagination: {
        current_page: orders.current_page,
        total_pages: orders.total_pages,
        total_count: orders.total_count,
        per_page: orders.limit_value
      }
    )
  end

  # GET /api/v1/admin/orders/:id
  def show
    order = Order.includes(:customer, order_items: :product).find(params[:id])
    render_success(order_response(order, detailed: true))
  rescue ActiveRecord::RecordNotFound
    render_error('Order not found', nil, :not_found)
  end

  # PATCH /api/v1/admin/orders/:id/update_status
  # Mirrors Admin::OrdersController#update_status (web) — same allowed statuses,
  # same per-status side-fields, kept in sync so both surfaces move an order
  # through the same workflow.
  def update_status
    order = Order.find(params[:id])
    new_status = params[:status]

    unless Order.statuses.key?(new_status)
      return render_error('Invalid status', nil, :unprocessable_entity)
    end

    update_attributes = { status: new_status }

    case new_status
    when 'shipped'
      update_attributes[:tracking_number] = params[:tracking_number].presence || generate_tracking_number
      update_attributes[:shipping_carrier] = params[:shipping_carrier] if params[:shipping_carrier].present?
      update_attributes[:shipped_at] = Time.current
    when 'delivered'
      update_attributes[:delivered_at] = Time.current
      update_attributes[:delivered_to] = params[:delivered_to] if params[:delivered_to].present?
    when 'cancelled'
      update_attributes[:cancelled_at] = Time.current
      update_attributes[:cancellation_reason] = params[:cancellation_reason] if params[:cancellation_reason].present?
    end

    if order.update(update_attributes)
      render_success(order_response(order), "Order status updated to #{new_status.humanize}")
    else
      render_validation_errors(order)
    end
  rescue ActiveRecord::RecordNotFound
    render_error('Order not found', nil, :not_found)
  end

  # PATCH /api/v1/admin/orders/:id/cancel
  def cancel
    order = Order.find(params[:id])

    unless order.can_cancel?
      return render_error('Order cannot be cancelled in its current status', nil, :unprocessable_entity)
    end

    order.update!(
      status: :cancelled,
      cancelled_at: Time.current,
      cancellation_reason: params[:reason]
    )

    render_success(order_response(order), 'Order cancelled successfully')
  rescue ActiveRecord::RecordNotFound
    render_error('Order not found', nil, :not_found)
  end

  private

  def generate_tracking_number
    "TRK#{Date.current.strftime('%Y%m%d')}#{SecureRandom.hex(4).upcase}"
  end

  def order_response(order, detailed: false)
    data = {
      id: order.id,
      order_number: order.order_number,
      status: order.status,
      payment_status: order.payment_status,
      payment_method: order.payment_method,
      total_amount: order.total_amount.to_f,
      customer_name: order.customer_name.presence || order.customer&.display_name,
      customer_phone: order.customer_phone,
      tracking_number: order.tracking_number,
      created_at: order.created_at
    }

    if detailed
      data[:items] = order.order_items.map do |item|
        {
          id: item.id,
          product_id: item.product_id,
          product_name: item.product&.name,
          quantity: item.quantity,
          price: item.price.to_f
        }
      end
      data[:delivery_address] = order.delivery_address
      data[:subtotal] = order.subtotal.to_f
      data[:tax_amount] = order.tax_amount.to_f
      data[:shipping_amount] = order.shipping_amount.to_f
      data[:discount_amount] = order.discount_amount&.to_f || 0
      data[:notes] = order.notes
    end

    data
  end
end
