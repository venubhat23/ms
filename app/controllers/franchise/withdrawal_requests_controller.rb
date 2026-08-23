class Franchise::WithdrawalRequestsController < Franchise::BaseController
  before_action :ensure_franchise_commission_enabled

  def index
    @withdrawal_requests = current_franchise.franchise_withdrawal_requests
                                             .includes(:booking, :tagged_bookings)
                                             .recent.page(params[:page]).per(20)
    @wallet = current_franchise.franchise_wallet
  end

  def new
    @wallet = current_franchise.franchise_wallet
    @withdrawal_request = current_franchise.franchise_withdrawal_requests.new
    load_available_bookings
  end

  def create
    @wallet = current_franchise.franchise_wallet
    @withdrawal_request = current_franchise.franchise_withdrawal_requests.new(withdrawal_request_params)

    if @withdrawal_request.save
      tag_bookings!(@withdrawal_request)
      redirect_to franchise_withdrawal_requests_path, notice: 'Withdrawal request submitted. It will be reviewed by an admin shortly.'
    else
      load_available_bookings
      flash.now[:alert] = @withdrawal_request.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  rescue => e
    load_available_bookings
    flash.now[:alert] = "Could not submit withdrawal request: #{e.message}"
    render :new, status: :unprocessable_entity
  end

  private

  def withdrawal_request_params
    params.require(:franchise_withdrawal_request).permit(:amount, :notes)
  end

  # Bookings this franchise has already tagged to a withdrawal request — via
  # the legacy single booking_id column or the new bulk-tag join table —
  # should not be offered again for tagging.
  def already_tagged_booking_ids
    current_franchise.franchise_withdrawal_requests.where.not(booking_id: nil).pluck(:booking_id) +
      FranchiseWithdrawalRequestBooking.joins(:franchise_withdrawal_request)
                                        .where(franchise_withdrawal_requests: { franchise_id: current_franchise.id })
                                        .pluck(:booking_id)
  end

  def load_available_bookings
    @bookings = current_franchise.bookings.recent.where.not(id: already_tagged_booking_ids).limit(50)
  end

  def tag_bookings!(withdrawal_request)
    requested_ids = Array(params[:booking_ids]).reject(&:blank?).map(&:to_i)
    return if requested_ids.empty?

    taggable_ids = current_franchise.bookings.where(id: requested_ids).pluck(:id) - already_tagged_booking_ids
    taggable_ids.each do |booking_id|
      withdrawal_request.franchise_withdrawal_request_bookings.create!(booking_id: booking_id)
    end
  end
end
