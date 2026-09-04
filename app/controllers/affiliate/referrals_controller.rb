class Affiliate::ReferralsController < Affiliate::ApplicationController
  before_action :set_referral, only: [:show, :update, :destroy, :mark_registered, :mark_converted]

  # GET /affiliate/referrals
  def index
    @referrals = current_affiliate.referrals
      .includes(:customer)
      .order(created_at: :desc)
      .page(params[:page]).per(20)

    # Filter by status if specified
    if params[:status].present?
      @referrals = @referrals.where(status: params[:status])
    end

    @stats = current_affiliate.referral_stats
  end

  # GET /affiliate/referrals/new
  def new
    @referral = current_affiliate.referrals.build
  end

  # POST /affiliate/referrals
  def create
    @referral = current_affiliate.referrals.build(referral_params)

    if @referral.save
      redirect_to affiliate_referrals_path, notice: 'Referral added successfully!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /affiliate/referrals/1
  def show
  end

  # PATCH/PUT /affiliate/referrals/1
  def update
    if @referral.update(referral_params.except(:referred_email, :referred_mobile))
      redirect_to affiliate_referral_path(@referral), notice: 'Referral updated successfully!'
    else
      render :show, status: :unprocessable_entity
    end
  end

  # DELETE /affiliate/referrals/1
  def destroy
    @referral.destroy
    redirect_to affiliate_referrals_path, notice: 'Referral deleted successfully!'
  end

  # PATCH /affiliate/referrals/1/mark_registered
  #
  # Marking a referral as registered turns the captured lead into a real
  # Customer record (tagged with this affiliate for commission tracking) and
  # links it to the referral — or links the existing account when that
  # email/mobile already belongs to one. Mirrors the admin portal's
  # "Mark as Registered" so both paths actually create the customer.
  def mark_registered
    # Allow pending referrals, and also referrals left in "registered" by the
    # old behavior that flipped the status without ever creating a customer.
    unless @referral.status == 'pending' || (@referral.status == 'registered' && @referral.customer.blank?)
      redirect_to affiliate_referrals_path, alert: 'This referral already has a linked customer.'
      return
    end

    customer = build_customer_from_referral(@referral)

    if customer.save
      @referral.mark_as_registered!(customer)
      redirect_to affiliate_referrals_path, notice: "Referral marked as registered — customer \"#{customer.display_name}\" created."
    elsif (existing = find_conflicting_customer(customer))
      @referral.mark_as_registered!(existing)
      redirect_to affiliate_referrals_path, notice: "\"#{existing.display_name}\" already has an account — linked the referral to it."
    else
      redirect_to affiliate_referrals_path, alert: "Could not create customer: #{customer.errors.full_messages.to_sentence}"
    end
  end

  # PATCH /affiliate/referrals/1/mark_converted
  def mark_converted
    unless @referral.status == 'registered'
      redirect_to affiliate_referrals_path, alert: 'Only registered referrals can be marked as converted.'
      return
    end

    created_note = ''
    if @referral.customer.blank?
      customer = build_customer_from_referral(@referral)
      if customer.save
        @referral.update!(customer: customer)
        created_note = " Customer \"#{customer.display_name}\" created."
      elsif (existing = find_conflicting_customer(customer))
        @referral.update!(customer: existing)
        created_note = " Linked to existing customer \"#{existing.display_name}\"."
      else
        redirect_to affiliate_referrals_path, alert: "Could not create customer: #{customer.errors.full_messages.to_sentence}"
        return
      end
    end

    @referral.mark_as_converted!
    redirect_to affiliate_referrals_path, notice: "Referral marked as converted! Congratulations!#{created_note}"
  end

  private

  def set_referral
    @referral = current_affiliate.referrals.find(params[:id])
  end

  def referral_params
    params.require(:referral).permit(:referred_name, :referred_mobile, :referred_email, :notes)
  end

  # Converts a referral's captured lead details into a real Customer record,
  # tagged with the affiliate that referred them (for commission tracking).
  def build_customer_from_referral(referral)
    first_name, *rest = referral.referred_name.to_s.strip.split(/\s+/)
    Customer.new(
      first_name: first_name.presence || referral.referred_name,
      last_name: rest.join(' '),
      email: referral.referred_email,
      mobile: referral.referred_mobile,
      referred_by_affiliate_id: referral.affiliate_id
    )
  end

  # When customer creation fails only on email/mobile uniqueness, the account
  # it collided with is the one we actually want to link — find it.
  def find_conflicting_customer(customer)
    scopes = []
    scopes << Customer.where(email: customer.email) if customer.errors.of_kind?(:email, :taken) && customer.email.present?
    scopes << Customer.where(mobile: customer.mobile) if customer.errors.of_kind?(:mobile, :taken) && customer.mobile.present?
    return nil if scopes.empty?

    scopes.reduce { |combined, scope| combined.or(scope) }.first
  end
end