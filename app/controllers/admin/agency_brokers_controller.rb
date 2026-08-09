class Admin::AgencyBrokersController < Admin::ApplicationController
  # This is a placeholder controller for agency/broker management
  # In practice, this might be handled through the Users controller with specific user_types

  def index
    scope = User.where(user_type: ['agent', 'sub_agent'])
    @agency_brokers = scope.order(:first_name).page(params[:page])

    # One grouped query for all 4 header stats instead of 4 separate .count
    # round trips — also fixes those counts being silently capped at the
    # per-page limit (a bare .count on a .page()'d relation counts only the
    # current page, not the true total).
    counts = scope.group(:user_type, :status).count
    @agency_brokers_total      = counts.values.sum
    @agency_brokers_active     = counts.sum { |(_type, status), n| status ? n : 0 }
    @agency_brokers_agents     = counts.sum { |(type, _status), n| type == 'agent' ? n : 0 }
    @agency_brokers_affiliates = counts.sum { |(type, _status), n| type == 'sub_agent' ? n : 0 }
  end

  def show
    @agency_broker = User.find(params[:id])
  end

  def new
    @agency_broker = User.new(user_type: 'agent')
  end

  def edit
    @agency_broker = User.find(params[:id])
  end

  def create
    @agency_broker = User.new(agency_broker_params)
    @agency_broker.user_type = 'agent'

    if @agency_broker.save
      redirect_to admin_agency_broker_path(@agency_broker), notice: 'Agency/Broker was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @agency_broker = User.find(params[:id])

    if @agency_broker.update(agency_broker_params)
      redirect_to admin_agency_broker_path(@agency_broker), notice: 'Agency/Broker was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @agency_broker = User.find(params[:id])
    @agency_broker.destroy
    redirect_to admin_agency_brokers_path, notice: 'Agency/Broker was successfully deleted.'
  end

  private

  def agency_broker_params
    params.require(:user).permit(
      :first_name, :last_name, :email, :mobile, :user_type, :role, :status,
      :address, :state, :city, :pan_number, :gst_number
    )
  end
end