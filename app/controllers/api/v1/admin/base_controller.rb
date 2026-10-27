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

  # params[key] as a Date (YYYY-MM-DD); nil when blank or unparseable
  def param_date(key)
    Date.parse(params[key].to_s) if params[key].present?
  rescue Date::Error
    nil
  end

  def paginate_scope(scope)
    scope.page(params[:page] || 1).per((params[:per_page] || 20).to_i.clamp(1, 100))
  end

  def pagination_meta(scope)
    {
      current_page: scope.current_page,
      total_pages: scope.total_pages,
      total_count: scope.total_count,
      per_page: scope.limit_value
    }
  end

  private

  # This API is only for the admin@maralisanthe.com account (user_type: admin) —
  # agents/sub_agents/store_admins etc. are not permitted here.
  def require_admin_user!
    render_error('Not authorized', nil, :forbidden) unless @current_user&.admin?
  end
end
