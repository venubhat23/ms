class Customer::RegistrationsController < Customer::BaseController
  skip_before_action :authenticate_customer!
  skip_before_action :ensure_customer_role
  layout 'customer_auth'

  def new
    # Check if customer is already signed in before showing registration form
    if session[:customer_id].present? && Customer.find_by(id: session[:customer_id])
      redirect_to customer_root_path and return
    end
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    @customer.password = params[:customer][:password]
    @customer.password_confirmation = params[:customer][:password_confirmation]
    @customer.referred_by_affiliate_id = referring_affiliate&.id

    if @customer.save
      session.delete(:referral_affiliate_code)
      sign_in_customer(@customer)
      redirect_to customer_dashboard_path, notice: 'Account created successfully! Welcome!'
    else
      flash.now[:alert] = 'Please fix the errors below.'
      render :new
    end
  end

  private

  # A code typed into the registration form wins over one captured earlier
  # from a ?ref= link, in case the visitor is registering with someone
  # else's code (e.g. a friend told them the code directly).
  def referring_affiliate
    code = params[:customer][:affiliate_code].presence || session[:referral_affiliate_code]
    return nil if code.blank?

    Affiliate.active.find_by(affiliate_code: code)
  end

  def customer_params
    params.require(:customer).permit(
      :first_name, :last_name, :middle_name, :email, :mobile,
      :whatsapp_number, :address, :longitude, :latitude
    )
  end
end