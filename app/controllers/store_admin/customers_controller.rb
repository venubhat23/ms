class StoreAdmin::CustomersController < StoreAdmin::ApplicationController
  before_action :set_customer, only: [:show]

  def index
    @customers = Customer.order(created_at: :desc)

    if params[:search].present?
      q = "%#{params[:search].strip}%"
      @customers = @customers.where(
        'first_name ILIKE ? OR last_name ILIKE ? OR mobile ILIKE ? OR email ILIKE ?',
        q, q, q, q
      )
    end

    @total_count = @customers.count
    @customers = @customers.page(params[:page]).per(25) if @customers.respond_to?(:page)
  end

  def show
    @store_bookings = @customer.bookings
                               .where(store_id: @current_store.id)
                               .order(created_at: :desc)
                               .limit(10)
    @store_booking_count = @customer.bookings.where(store_id: @current_store.id).count
    @store_total_spent   = @customer.bookings.where(store_id: @current_store.id).sum(:total_amount).to_f
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to store_admin_customer_path(@customer), notice: 'Customer created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(
      :first_name, :middle_name, :last_name,
      :mobile, :whatsapp_number, :email,
      :address, :gender, :notes
    )
  end
end
