class DistributorPayout < ApplicationRecord
  belongs_to :distributor

  # No insurance policy types remain (life/motor/other/health insurance were
  # all removed), so there's nothing left to constrain policy_type against —
  # only require it be present so existing records stay valid.
  validates :policy_type, presence: true
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
    @policy = nil
  end

  def preload_policy(policy)
    @policy = policy
  end

  # Batch-fetches the policy (with its customer) behind every given
  # DistributorPayout, grouped by policy_type — one query per type instead of
  # one #policy call per record, plus one #customer call per record.
  def self.preload_policies(payouts)
    payouts.each { |payout| payout.preload_policy(nil) }
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
