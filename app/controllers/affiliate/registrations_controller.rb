class Affiliate::RegistrationsController < ApplicationController
  layout false
  skip_before_action :authenticate_user!, only: [:new, :create]
  skip_load_and_authorize_resource

  def new
    redirect_to affiliate_root_path and return if user_signed_in? && current_user.user_type == 'affiliate'
    @affiliate = Affiliate.new
  end

  def create
    @affiliate = Affiliate.new(affiliate_params)
    # SystemSetting.default_affiliate_commission returns 0.0 when the admin
    # hasn't set one yet, but Affiliate requires a positive percentage — fall
    # back to a sane default rather than blocking every self-registration.
    configured_commission = SystemSetting.default_affiliate_commission.to_f
    @affiliate.commission_percentage = configured_commission.positive? ? configured_commission : 2.0

    if @affiliate.save
      render :success
    else
      flash.now[:alert] = 'Please fix the errors below.'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def affiliate_params
    params.require(:affiliate).permit(:first_name, :last_name, :email, :mobile, :address, :city, :state, :pincode)
  end
end
