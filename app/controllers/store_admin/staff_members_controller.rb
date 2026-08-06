class StoreAdmin::StaffMembersController < StoreAdmin::ApplicationController
  before_action :set_staff_member, only: [:show, :edit, :update, :toggle_status]

  def index
    @staff_members  = @current_store.staff_members.order(:name).to_a
    @total_count    = @staff_members.size
    @active_count   = @staff_members.count(&:active?)
    @inactive_count = @total_count - @active_count

    # One grouped query for every staff member's paid-this-month total instead
    # of one query per record via pending_for -> paid_for (mirrors
    # Admin::StaffMembersController#index).
    today = Date.current
    paid_totals = StaffPayment.where(staff_member_id: @staff_members.map(&:id), month: today.month, year: today.year)
                              .group(:staff_member_id).sum(:amount)
    @staff_members.each { |s| s.preload_paid_for(today.month, today.year, paid_totals[s.id] || 0) }

    @total_pending = @staff_members.select(&:active?).sum { |s| s.pending_for(today.month, today.year) }
  end

  def show
    @month = (params[:month] || Date.current.month).to_i
    @year  = (params[:year] || Date.current.year).to_i

    @attendances = @staff_member.staff_attendances
                                .where(attendance_date: Date.new(@year, @month, 1)..Date.new(@year, @month, -1))
                                .order(attendance_date: :desc)
    @payments = @staff_member.staff_payments
                             .where(month: @month, year: @year)
                             .order(payment_date: :desc)

    @attendance_summary = @staff_member.attendance_summary_for(@month, @year)
    @paid    = @staff_member.paid_for(@month, @year)
    @pending = @staff_member.pending_for(@month, @year)
  end

  def new
    @staff_member = @current_store.staff_members.build(joining_date: Date.current)
  end

  def create
    @staff_member = @current_store.staff_members.build(staff_member_params)

    if @staff_member.save
      redirect_to store_admin_staff_member_path(@staff_member), notice: 'Staff member added successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @staff_member.update(staff_member_params)
      redirect_to store_admin_staff_member_path(@staff_member), notice: 'Staff member updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def toggle_status
    @staff_member.update(status: @staff_member.active? ? 'inactive' : 'active')
    redirect_to store_admin_staff_members_path, notice: "#{@staff_member.name} has been #{@staff_member.active? ? 'enabled' : 'disabled'}."
  end

  private

  def set_staff_member
    @staff_member = @current_store.staff_members.find(params[:id])
  end

  def staff_member_params
    params.require(:staff_member).permit(:name, :mobile, :email, :designation, :monthly_salary, :joining_date, :notes)
  end
end
