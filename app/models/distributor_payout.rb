class DistributorPayout < ApplicationRecord
  belongs_to :distributor

  validates :policy_type, presence: true, inclusion: { in: %w[health life motor other] }
  validates :policy_id, presence: true
  validates :payout_amount, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true, inclusion: { in: %w[pending paid cancelled] }

  scope :pending, -> { where(status: 'pending') }
  scope :paid, -> { where(status: 'paid') }
  scope :for_distributor, ->(distributor_id) { where(distributor_id: distributor_id) }
  scope :for_policy, ->(policy_type, policy_id) { where(policy_type: policy_type, policy_id: policy_id) }

  # Memoized (via `defined?` rather than `||=` since a nil lookup is a valid
  # result and shouldn't be retried) so callers looping over many payouts can
  # batch-fetch via .preload_policies and prime each instance instead of
  # firing one find_by per payout.
  def policy
    return @policy if defined?(@policy)
    @policy = case policy_type
    when 'health'
      HealthInsurance.find_by(id: policy_id)
    when 'life'
      LifeInsurance.find_by(id: policy_id)
    when 'motor'
      MotorInsurance.find_by(id: policy_id)
    when 'other'
      OtherInsurance.find_by(id: policy_id)
    end
  end

  def preload_policy(policy)
    @policy = policy
  end

  # Batch-fetches the policy (with its customer) behind every given
  # DistributorPayout, grouped by policy_type — one query per type instead of
  # one #policy call per record, plus one #customer call per record.
  def self.preload_policies(payouts)
    ids_by_type = payouts.group_by(&:policy_type).transform_values { |ps| ps.map(&:policy_id).uniq }
    policies_by_type_and_id = {}

    if (ids = ids_by_type['health'])
      HealthInsurance.includes(:customer).where(id: ids).each { |p| policies_by_type_and_id[['health', p.id]] = p }
    end
    if (ids = ids_by_type['life'])
      LifeInsurance.includes(:customer).where(id: ids).each { |p| policies_by_type_and_id[['life', p.id]] = p }
    end
    if (ids = ids_by_type['motor'])
      MotorInsurance.includes(:customer).where(id: ids).each { |p| policies_by_type_and_id[['motor', p.id]] = p }
    end
    if (ids = ids_by_type['other'])
      OtherInsurance.where(id: ids).each { |p| policies_by_type_and_id[['other', p.id]] = p }
    end

    payouts.each { |payout| payout.preload_policy(policies_by_type_and_id[[payout.policy_type, payout.policy_id]]) }
  end

  def mark_as_paid!(transaction_id: nil, payment_date: nil, notes: nil, processed_by: nil)
    update!(
      status: 'paid',
      transaction_id: transaction_id,
      payout_date: payment_date || Date.current,
      notes: notes,
      processed_by: processed_by,
      processed_at: Time.current
    )
  end
end
