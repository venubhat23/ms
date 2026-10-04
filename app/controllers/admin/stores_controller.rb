class Admin::StoresController < Admin::ApplicationController
  before_action :authenticate_user!
  before_action { require_sidebar_permission!('stores') }
  before_action :set_store, only: [:show, :edit, :update, :destroy, :toggle_status, :assign_admin, :update_admin, :view_as_store_admin]
  before_action :check_collect_from_store_enabled, only: [:index, :new, :create]

  def index
    @stores = Store.all.order(:name)
    @can_add_more = Store.can_add_more_stores?
    @remaining_slots = Store.remaining_store_slots
    @collect_from_store_enabled = SystemSetting.collect_from_store_enabled?
    # One grouped query for every store's booking count instead of one
    # `store.bookings.count` round trip per card in the view.
    @booking_counts = Booking.group(:store_id).count

    respond_to do |format|
      format.html
      format.json { render json: @stores }
    end
  end

  def show
    # Independent stats fired async up front so their round trips overlap
    # (remote DB: each query is a full network round trip); resolved below.
    bookings_count = @store.bookings.async_count
    pending_bookings_count = @store.bookings.where(status: 'pending').async_count
    @expenses_this_month = @store.expenses.by_date_range(Date.current.beginning_of_month, Date.current.end_of_month)
    expenses_total = @expenses_this_month.async_sum(:amount)
    store_end_expenses_count = @store.expenses
                                     .joins(:created_by)
                                     .where(users: { user_type: 'store_admin' })
                                     .async_count
    expenses_by_category = @expenses_this_month.group(:category).async_sum(:amount)
    @recent_expenses = @store.expenses.recent.limit(10).includes(:created_by).load_async
    @recent_bookings = @store.bookings.order(created_at: :desc).limit(5).load_async

    @inventory_summary = @store.store_inventory_summary

    @stock_items = @store.stock_batches
                         .where(status: 'active')
                         .where('quantity_remaining > 0')
                         .includes(:product)
                         .group_by(&:product)
                         .map do |product, batches|
                           {
                             product: product,
                             total_qty: batches.sum(&:quantity_remaining),
                             batches_count: batches.size,
                             min_price: batches.map(&:selling_price).min,
                             max_price: batches.map(&:selling_price).max
                           }
                         end
                         .sort_by { |item| item[:product].name }

    @bookings_count = bookings_count.value
    @pending_bookings_count = pending_bookings_count.value
    @expenses_total_this_month = expenses_total.value
    @store_end_expenses_count = store_end_expenses_count.value
    @expenses_by_category = expenses_by_category.value
  end

  def new
    unless Store.can_add_more_stores?
      redirect_to admin_stores_path, alert: "Maximum #{Store::MAX_STORES_LIMIT} stores allowed. Cannot add more stores."
      return
    end

    @store = Store.new
    @store.status = true # Default to active
  end

  def create
    unless Store.can_add_more_stores?
      redirect_to admin_stores_path, alert: "Maximum #{Store::MAX_STORES_LIMIT} stores allowed. Cannot add more stores."
      return
    end

    @store = Store.new(store_params)

    if params[:store][:create_admin_user] == '1'
      @store.create_admin_user = true
      @store.admin_first_name = params[:store][:admin_first_name]
      @store.admin_last_name = params[:store][:admin_last_name]
      @store.admin_email = params[:store][:admin_email]
      @store.admin_mobile = params[:store][:admin_mobile]
      @store.admin_password = params[:store][:admin_password]
    end

    if @store.save
      if @store.create_admin_user && @store.has_store_admin?
        redirect_to admin_store_path(@store), notice: "Store created with admin login. Email: #{@store.store_admin_user.email}, Password: #{@store.admin_plain_password}"
      else
        redirect_to admin_stores_path, notice: 'Store was successfully created.'
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def assign_admin
  end

  def update_admin
    first_name = params[:admin_first_name]
    last_name = params[:admin_last_name]
    email = params[:admin_email]
    mobile = params[:admin_mobile]
    password = params[:admin_password]

    if @store.has_store_admin?
      user = @store.store_admin_user
      attrs = { first_name: first_name, last_name: last_name, email: email, mobile: mobile }
      attrs[:password] = attrs[:password_confirmation] = password if password.present?
      if user.update(attrs)
        redirect_to admin_store_path(@store), notice: 'Store admin updated successfully.'
      else
        redirect_to admin_store_path(@store), alert: "Failed: #{user.errors.full_messages.join(', ')}"
      end
    else
      @store.admin_first_name = first_name
      @store.admin_last_name = last_name
      @store.admin_email = email
      @store.admin_mobile = mobile
      @store.admin_password = password
      @store.create_admin_user = true
      if @store.valid? && @store.create_store_admin_user!
        redirect_to admin_store_path(@store), notice: "Store admin created. Email: #{email}, Password: #{password}"
      else
        redirect_to admin_store_path(@store), alert: "Failed to create admin: #{@store.errors.full_messages.join(', ')}"
      end
    end
  end

  def view_as_store_admin
    redirect_to store_admin_root_path
  end

  def edit
  end

  def update
    if @store.update(store_params)
      redirect_to admin_stores_path, notice: 'Store was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @store.can_be_deleted?
      @store.destroy
      redirect_to admin_stores_path, notice: 'Store was successfully deleted.'
    else
      redirect_to admin_stores_path, alert: 'Cannot delete store. It has associated bookings.'
    end
  end

  def toggle_status
    @store.update(status: !@store.status)

    respond_to do |format|
      format.html { redirect_to admin_stores_path, notice: "Store status updated." }
      format.json { render json: { status: 'success', new_status: @store.status } }
    end
  end

  private

  def set_store
    @store = Store.find(params[:id])
  end

  def check_collect_from_store_enabled
    unless SystemSetting.collect_from_store_enabled?
      redirect_to admin_settings_system_path, alert: 'Enable "Collect From Store" feature first in System Settings.'
    end
  end

  def store_params
    params.require(:store).permit(:name, :description, :address, :city, :state,
                                   :pincode, :contact_person, :contact_mobile,
                                   :email, :gst_no, :status, :commission_percentage)
  end
end