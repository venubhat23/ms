class Affiliate::DashboardController < Affiliate::ApplicationController
  def index
    stats = current_affiliate.referral_stats
    @stats = {
      total_referrals: stats[:total],
      pending_referrals: stats[:pending],
      registered_referrals: stats[:registered],
      converted_referrals: stats[:converted],
      conversion_rate: stats[:conversion_rate]
    }

    @recent_referrals = current_affiliate.referrals.recent.limit(5)

    # Monthly referral data (last 6 months) — one grouped query instead of a
    # total + converted count per month (14 round trips), then bucketed in Ruby.
    range_start = 6.months.ago.beginning_of_month
    monthly_counts = current_affiliate.referrals
      .where('created_at >= ?', range_start)
      .group("to_char(created_at, 'YYYY-MM')", :status)
      .count

    @monthly_referrals = 6.downto(0).map do |i|
      month_start = i.months.ago.beginning_of_month
      key = month_start.strftime('%Y-%m')
      total = monthly_counts.select { |(month, _status), _count| month == key }.values.sum
      converted = monthly_counts[[key, 'converted']] || 0

      { month: month_start.strftime('%b %Y'), total: total, converted: converted }
    end

    # Referral status distribution
    @status_distribution = current_affiliate.referrals.group(:status).count
  end
end