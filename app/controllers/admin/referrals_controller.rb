class Admin::ReferralsController < ApplicationController
  before_action :authenticate_user!
  before_action { require_sidebar_permission!('referrals') }
  before_action :set_referral, only: [:show, :update, :destroy, :mark_registered, :mark_converted]

  # GET /admin/referrals
  def index
    @referrals = Referral.includes(:affiliate, :referring_customer, :customer)
                        .order(created_at: :desc)

    # Filter by referral source (affiliate or customer)
    if params[:source].present?
      case params[:source]
      when 'customer'
        @referrals = @referrals.customer_referrals
      when 'affiliate'
        @referrals = @referrals.affiliate_referrals
      end
    end

    # Filter by status if specified
    if params[:status].present?
      @referrals = @referrals.where(status: params[:status])
    end

    # Add basic search functionality
    if params[:search].present?
      search_term = "%#{params[:search].downcase}%"
      @referrals = @referrals.where(
        "LOWER(referred_name) LIKE ? OR LOWER(referred_email) LIKE ? OR LOWER(referred_mobile) LIKE ?",
        search_term, search_term, search_term
      )
    end

    # Add pagination manually (25 per page)
    @referrals = @referrals.limit(25).offset((params[:page]&.to_i || 0) * 25)

    # Calculate statistics — 3 queries instead of the 8 serial counts this
    # used to run (status breakdown collapsed into one GROUP BY).
    @stats = build_referral_stats(Referral.all).merge(
      customer_referrals: Referral.customer_referrals.count,
      affiliate_referrals: Referral.affiliate_referrals.count
    )
  end

  # GET /admin/referrals/1
  def show
  end

  # PATCH/PUT /admin/referrals/1
  def update
    if @referral.update(referral_params)
      redirect_to admin_referral_path(@referral), notice: 'Referral was successfully updated.'
    else
      render :show, status: :unprocessable_entity
    end
  end

  # DELETE /admin/referrals/1
  def destroy
    @referral.destroy
    redirect_to admin_referrals_path, notice: 'Referral was successfully deleted.'
  end

  # PATCH /admin/referrals/1/mark_registered
  def mark_registered
    if params[:customer_id].present? && params[:customer_id] != 'new'
      customer = Customer.find(params[:customer_id])
      @referral.mark_as_registered!(customer)
      redirect_to admin_referral_path(@referral), notice: 'Referral marked as registered successfully.'
    else
      customer = build_customer_from_referral(@referral)
      if customer.save
        @referral.mark_as_registered!(customer)
        redirect_to admin_referral_path(@referral), notice: "New customer \"#{customer.display_name}\" created (referred by #{@referral.referrer_name}) and referral marked as registered."
      else
        redirect_to admin_referral_path(@referral), alert: "Could not create customer: #{customer.errors.full_messages.to_sentence}"
      end
    end
  end

  # PATCH /admin/referrals/1/mark_converted
  def mark_converted
    @referral.mark_as_converted!
    redirect_to admin_referral_path(@referral), notice: 'Referral marked as converted successfully.'
  end

  # GET /admin/referrals/affiliate_referrals
  def affiliate_referrals
    @referrals = Referral.affiliate_referrals
                        .includes(:affiliate, :referring_customer, :customer)
                        .order(created_at: :desc)

    # Filter by status if specified
    if params[:status].present?
      @referrals = @referrals.where(status: params[:status])
    end

    # Add basic search functionality
    if params[:search].present?
      search_term = "%#{params[:search].downcase}%"
      @referrals = @referrals.where(
        "LOWER(referred_name) LIKE ? OR LOWER(referred_email) LIKE ? OR LOWER(referred_mobile) LIKE ?",
        search_term, search_term, search_term
      )
    end

    # Add pagination manually (25 per page)
    @referrals = @referrals.limit(25).offset((params[:page]&.to_i || 0) * 25)

    # Calculate statistics for affiliate referrals only — 1 grouped query
    # instead of the 5 serial counts this used to run.
    stats = build_referral_stats(Referral.affiliate_referrals)
    @stats = stats.merge(affiliate_referrals: stats[:total])

    render :index
  end

  # GET /admin/referrals/analytics
  def analytics
    @date_range = params[:date_range] || '30_days'

    case @date_range
    when '7_days'
      start_date = 7.days.ago
    when '30_days'
      start_date = 30.days.ago
    when '90_days'
      start_date = 90.days.ago
    when '1_year'
      start_date = 1.year.ago
    else
      start_date = 30.days.ago
    end

    # total_in_period/conversions_in_period reused for the rate below instead
    # of calculate_conversion_rate(start_date) re-running the same 2 queries.
    total_in_period = Referral.where(created_at: start_date..).count
    conversions_in_period = Referral.converted.where(created_at: start_date..).count

    @referrals_data = {
      total_in_period: total_in_period,
      customer_referrals_in_period: Referral.customer_referrals.where(created_at: start_date..).count,
      affiliate_referrals_in_period: Referral.affiliate_referrals.where(created_at: start_date..).count,
      conversions_in_period: conversions_in_period,
      conversion_rate_in_period: total_in_period > 0 ? ((conversions_in_period.to_f / total_in_period) * 100).round(2) : 0
    }

    # Daily breakdown for charts
    @daily_referrals = Referral.where(created_at: start_date..)
                               .group_by_day(:created_at, range: start_date..Date.current)
                               .count

    @daily_conversions = Referral.converted
                                .where(created_at: start_date..)
                                .group_by_day(:created_at, range: start_date..Date.current)
                                .count

    # Top referrers
    @top_customer_referrers = Customer.joins(:referrals)
                                    .group('customers.id', 'customers.first_name', 'customers.last_name')
                                    .order('COUNT(referrals.id) DESC')
                                    .limit(10)
                                    .count

    @top_affiliate_referrers = Affiliate.joins(:referrals)
                                      .group('affiliates.id', 'affiliates.first_name', 'affiliates.last_name')
                                      .order('COUNT(referrals.id) DESC')
                                      .limit(10)
                                      .count
  end

  private

  def set_referral
    @referral = Referral.find(params[:id])
  end

  def referral_params
    params.require(:referral).permit(:status, :notes)
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

  def calculate_conversion_rate(start_date = nil)
    if start_date
      total = Referral.where(created_at: start_date..).count
      converted = Referral.converted.where(created_at: start_date..).count
    else
      total = Referral.count
      converted = Referral.converted.count
    end

    return 0 if total == 0
    ((converted.to_f / total) * 100).round(2)
  end

  # One GROUP BY query for status breakdown instead of 3 separate
  # pending/registered/converted counts.
  def build_referral_stats(scope)
    status_counts = scope.group(:status).count
    total = status_counts.values.sum
    converted = status_counts['converted'] || 0

    {
      total: total,
      pending: status_counts['pending'] || 0,
      registered: status_counts['registered'] || 0,
      converted: converted,
      conversion_rate: total.zero? ? 0 : ((converted.to_f / total) * 100).round(2)
    }
  end
end