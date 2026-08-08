class Api::V1::Admin::BaseController < Api::V1::BaseController
  before_action :require_admin_user!

  protected

  def render_success(data = nil, message = 'Success', status = :ok)
    render json: { success: true, message: message, data: data }, status: status
  end

  def render_error(message = 'Error occurred', errors = nil, status = :unprocessable_entity)
    render json: { success: false, message: message, errors: errors }, status: status
  end

  def render_validation_errors(object)
    render_error('Validation failed', object.errors.full_messages, :unprocessable_entity)
  end

  private

  # This API is only for the admin@maralisanthe.com account (user_type: admin) —
  # agents/sub_agents/store_admins etc. are not permitted here.
  def require_admin_user!
    render_error('Not authorized', nil, :forbidden) unless @current_user&.admin?
  end
end
