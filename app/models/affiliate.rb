class Affiliate < ApplicationRecord
  has_one :user, as: :authenticatable, dependent: :destroy
  has_one :affiliate_wallet, dependent: :destroy
  has_many :referrals, dependent: :destroy
  has_many :bookings, foreign_key: :affiliate_id
  has_many :referred_customers, class_name: 'Customer', foreign_key: :referred_by_affiliate_id
  has_many :affiliate_withdrawal_requests, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :mobile, presence: true, uniqueness: true
  validates :commission_percentage, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 100 }

  scope :active, -> { where(status: true) }
  scope :inactive, -> { where(status: false) }

  before_create :set_username
  before_create :set_affiliate_code
  after_create :create_user_account
  after_create :create_wallet

  # base_url should be request.base_url from the calling controller/view —
  # the app doesn't have routes.default_url_options configured for a fixed
  # host, so this can't safely build an absolute URL on its own.
  def referral_link(base_url)
    "#{base_url}/?ref=#{affiliate_code}"
  end

  def display_name
    "#{first_name} #{last_name}".strip
  end

  def formatted_commission
    "#{commission_percentage}%"
  end

  def status_badge_class
    status? ? 'success' : 'danger'
  end

  def status_text
    status? ? 'Active' : 'Inactive'
  end

  # Referral statistics — one grouped COUNT query, memoized per instance, so
  # calling total_referrals/pending_referrals/.../conversion_rate together
  # (as the dashboard and admin show page do) costs a single DB round trip
  # instead of up to 6.
  def referral_stats
    @referral_stats ||= begin
      counts = referrals.group(:status).count
      total = counts.values.sum
      converted = counts['converted'] || 0

      {
        total: total,
        pending: counts['pending'] || 0,
        registered: counts['registered'] || 0,
        converted: converted,
        conversion_rate: total.zero? ? 0 : ((converted.to_f / total) * 100).round(2)
      }
    end
  end

  def total_referrals
    referral_stats[:total]
  end

  def pending_referrals
    referral_stats[:pending]
  end

  def registered_referrals
    referral_stats[:registered]
  end

  def converted_referrals
    referral_stats[:converted]
  end

  def conversion_rate
    referral_stats[:conversion_rate]
  end

  private

  def set_username
    self.username ||= generate_username
  end

  def set_affiliate_code
    self.affiliate_code ||= mobile
  end

  def create_wallet
    create_affiliate_wallet!(balance: 0)
  end

  def create_user_account
    password = generate_secure_password
    affiliate_role = Role.find_or_create_by!(name: 'affiliate') { |r| r.description = 'Affiliate portal user'; r.status = true }

    create_user!(
      first_name: first_name,
      last_name: last_name,
      email: email,
      mobile: mobile,
      password: password,
      password_confirmation: password,
      user_type: 'affiliate',
      role: affiliate_role,
      status: true
    )

    update_column(:auto_generated_password, password)
  end

  def generate_secure_password
    name_part = first_name[0..3].upcase.ljust(4, 'X')
    year_part = Date.current.year.to_s
    "#{name_part}@#{year_part}"
  end

  def generate_username
    base_username = "#{first_name.downcase}#{last_name.downcase}".gsub(/[^a-z0-9]/, '')
    counter = 1
    username = base_username

    while User.exists?(email: "#{username}@affiliate.com")
      username = "#{base_username}#{counter}"
      counter += 1
    end

    username
  end
end
