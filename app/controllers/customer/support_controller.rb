class Customer::SupportController < Customer::BaseController
  skip_before_action :authenticate_customer!, only: [:index]
  skip_before_action :ensure_customer_role, only: [:index]

  def index
    # Support page with FAQ, contact info, etc.
    # Computed once here — the view referenced this same count 4 separate times.
    @active_requests_count = current_customer&.client_requests&.where(status: ['pending', 'in_progress'])&.count || 0
  end
end