class Franchise::DeliveriesController < Franchise::BaseController
  before_action :ensure_franchise_commission_enabled
  before_action :set_delivery, only: [:show, :mark_delivered, :mark_completed]

  def index
    @deliveries = Booking.where(delivery_franchise_id: current_franchise.id)
                         .includes(:customer, :booking_items)
                         .order(created_at: :desc)
                         .page(params[:page]).per(SystemSetting.default_pagination_per_page)
  end

  def show
  end

  def mark_delivered
    if @delivery.update(status: 'delivered', stage_updated_at: Time.current, stage_updated_by: current_user&.email)
      redirect_to franchise_delivery_path(@delivery), notice: 'Booking marked as delivered.'
    else
      redirect_to franchise_delivery_path(@delivery), alert: "Failed to update: #{@delivery.errors.full_messages.join(', ')}"
    end
  end

  def mark_completed
    if @delivery.update(status: 'completed', stage_updated_at: Time.current, stage_updated_by: current_user&.email)
      redirect_to franchise_delivery_path(@delivery), notice: 'Booking marked as completed. Commission credited to your wallet if applicable.'
    else
      redirect_to franchise_delivery_path(@delivery), alert: "Failed to update: #{@delivery.errors.full_messages.join(', ')}"
    end
  end

  private

  def set_delivery
    @delivery = Booking.where(delivery_franchise_id: current_franchise.id).find(params[:id])
  end
end
