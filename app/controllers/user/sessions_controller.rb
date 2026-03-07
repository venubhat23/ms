class User::SessionsController < ApplicationController
  layout 'affiliate_auth'
  skip_before_action :authenticate_user!, only: [:new, :create]
  skip_load_and_authorize_resource
  before_action :redirect_if_authenticated, only: [:new, :create]

  def new
    # Simple user login form
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user&.valid_password?(params[:password])
      if @user.status? # Check if user is active
        sign_in(@user)
        redirect_to root_path, notice: 'Welcome back!'
      else
        flash.now[:alert] = 'Your user account has been deactivated. Please contact support.'
        render :new, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = 'Invalid email or password.'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    sign_out(current_user)
    redirect_to user_login_path, notice: 'You have been logged out.'
  end

  private

  def redirect_if_authenticated
    if user_signed_in?
      redirect_to root_path
    end
  end
end