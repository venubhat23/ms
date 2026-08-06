class Payout < ApplicationRecord
  # Associations
  has_many :commission_payouts, dependent: :destroy
  belongs_to :customer

  # Validations
  validates :policy_type, presence: true, inclusion: { in: ['health', 'life', 'motor', 'other'] }
  validates :policy_id, presence: true
  validates :status, presence: true, inclusion: { in: ['pending', 'processing', 'completed', 'failed'] }
  validates :total_commission_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # Enums
  enum :status, { pending: 'pending', processing: 'processing', completed: 'completed', failed: 'failed' }

  # Scopes
  scope :by_policy_type, ->(type) { where(policy_type: type) }
  scope :by_status, ->(status) { where(status: status) }
  scope :recent, -> { order(created_at: :desc) }

  # Instance methods

  # Memoized (not `||=` — a legitimately-missing policy resolves to nil, and
  # `||=` would re-query every time for that case) so callers that loop over
  # many payouts can batch-fetch policies up front and prime each instance via
  # `preload_policy` instead of firing one find_by per payout per call.
  def policy
    return @policy if defined?(@policy)
    @policy = case policy_type
    when 'health'
      HealthInsurance.find_by(id: policy_id)
    when 'life'
      LifeInsurance.find_by(id: policy_id)
    when 'motor'
      MotorInsurance.find_by(id: policy_id) if defined?(MotorInsurance)
    when 'other'
      OtherInsurance.find_by(id: policy_id) if defined?(OtherInsurance)
    end
  end

  def preload_policy(policy)
    @policy = policy
  end

  # Batch-fetches the policy behind every given Payout (grouped by
  # policy_type, one query per type instead of one #policy call per payout)
  # and primes each instance via #preload_policy. Callers that loop over many
  # payouts and call #policy on each should run this first.
  #
  # Deliberately does NOT eager-load :customer here — OtherInsurance has no
  # `belongs_to :customer` (only a delegated `#customer` method through its
  # own `belongs_to :policy`), so `.includes(:customer)` would raise
  # ActiveRecord::AssociationNotFoundError for that type. Callers that need
  # customer data should batch it themselves from policy.customer_id.
  def self.preload_policies(payouts)
    ids_by_type = payouts.group_by(&:policy_type).transform_values { |ps| ps.map(&:policy_id).uniq }
    policies_by_type_and_id = {}

    if (ids = ids_by_type['health'])
      HealthInsurance.where(id: ids).each { |p| policies_by_type_and_id[['health', p.id]] = p }
    end
    if (ids = ids_by_type['life'])
      LifeInsurance.where(id: ids).each { |p| policies_by_type_and_id[['life', p.id]] = p }
    end
    if (ids = ids_by_type['motor']) && defined?(MotorInsurance)
      MotorInsurance.where(id: ids).each { |p| policies_by_type_and_id[['motor', p.id]] = p }
    end
    if (ids = ids_by_type['other']) && defined?(OtherInsurance)
      OtherInsurance.where(id: ids).each { |p| policies_by_type_and_id[['other', p.id]] = p }
    end

    payouts.each { |payout| payout.preload_policy(policies_by_type_and_id[[payout.policy_type, payout.policy_id]]) }
  end

  def main_agent_commission
    commission_payouts.find_by(payout_to: 'main_agent')
  end

  def affiliate_commission
    commission_payouts.find_by(payout_to: 'affiliate')
  end

  def ambassador_commission
    commission_payouts.find_by(payout_to: 'ambassador')
  end

  def investor_commission
    commission_payouts.find_by(payout_to: 'investor')
  end

  def company_expense
    commission_payouts.find_by(payout_to: 'company_expense')
  end

  def total_sub_commissions
    commission_payouts.where.not(payout_to: 'main_agent').sum(:payout_amount)
  end

  def completion_percentage
    return 0 if commission_payouts.count == 0
    completed_count = commission_payouts.where(status: 'paid').count
    (completed_count.to_f / commission_payouts.count * 100).round(2)
  end

  # Commission detail access methods
  def main_agent_commission_payout
    CommissionPayout.find_by(id: main_agent_commission_id) if main_agent_commission_id
  end

  def affiliate_commission_payout
    CommissionPayout.find_by(id: affiliate_commission_id) if affiliate_commission_id
  end

  def ambassador_commission_payout
    CommissionPayout.find_by(id: ambassador_commission_id) if ambassador_commission_id
  end

  def investor_commission_payout
    CommissionPayout.find_by(id: investor_commission_id) if investor_commission_id
  end

  def company_expense_commission_payout
    CommissionPayout.find_by(id: company_expense_commission_id) if company_expense_commission_id
  end

  # Get all commission details as a hash
  def commission_breakdown
    {
      main_agent: {
        percentage: main_agent_percentage,
        amount: main_agent_commission_amount,
        commission_id: main_agent_commission_id,
        payout: main_agent_commission_payout
      },
      affiliate: {
        percentage: affiliate_percentage,
        amount: affiliate_commission_amount,
        commission_id: affiliate_commission_id,
        payout: affiliate_commission_payout
      },
      ambassador: {
        percentage: ambassador_percentage,
        amount: ambassador_commission_amount,
        commission_id: ambassador_commission_id,
        payout: ambassador_commission_payout
      },
      investor: {
        percentage: investor_percentage,
        amount: investor_commission_amount,
        commission_id: investor_commission_id,
        payout: investor_commission_payout
      },
      company_expense: {
        percentage: company_expense_percentage,
        amount: company_expense_amount,
        commission_id: company_expense_commission_id,
        payout: company_expense_commission_payout
      }
    }
  end

  # Get formatted commission summary
  def formatted_commission_summary
    return commission_summary if commission_summary.present?

    breakdown = commission_breakdown
    summary_parts = []

    breakdown.each do |type, details|
      next unless details[:amount]&.> 0
      type_name = type.to_s.titleize.gsub('_', ' ')
      summary_parts << "#{type_name}: #{details[:percentage]}% (₹#{details[:amount]})"
    end

    summary_parts.join(" | ")
  end

  # Get commission IDs array for easy reference
  def all_commission_ids
    [
      main_agent_commission_id,
      affiliate_commission_id,
      ambassador_commission_id,
      investor_commission_id,
      company_expense_commission_id
    ].compact
  end

  # Check if all commissions are paid
  def all_commissions_paid?
    return false if all_commission_ids.empty?

    paid_count = CommissionPayout.where(id: all_commission_ids, status: 'paid').count
    paid_count == all_commission_ids.count
  end

  # Get total pending commission amount
  def total_pending_commission_amount
    pending_ids = CommissionPayout.where(id: all_commission_ids, status: ['pending', 'processing']).pluck(:id)
    return 0 if pending_ids.empty?

    CommissionPayout.where(id: pending_ids).sum(:payout_amount)
  end
end
