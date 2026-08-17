#!/usr/bin/env ruby
puts "=== Updating Customer 5 Policies for Testing ==="

# Update a life insurance policy too
customer_5_life = LifeInsurance.where(customer_id: 5).first
if customer_5_life
  customer_5_life.update!(
    payment_mode: 'Half-Yearly',
    installment_autopay_start_date: 10.days.from_now
  )
  puts "Updated Life Policy ##{customer_5_life.id}: Half-Yearly, next installment in 10 days"
end

puts "\n=== Updates Complete ==="

# Test the logic again
puts "\n=== Testing Logic After Updates ==="
installments = []

# Life Insurance installments
life_policies = LifeInsurance.where(customer_id: 5).where('policy_end_date >= ?', Date.current)
life_policies.each do |policy|
  next unless policy.installment_autopay_start_date.present?

  next_installment = case policy.payment_mode.downcase
  when 'monthly'
    policy.installment_autopay_start_date + 1.month
  when 'quarterly'
    policy.installment_autopay_start_date + 3.months
  when 'half-yearly', 'half yearly'
    policy.installment_autopay_start_date + 6.months
  when 'yearly'
    policy.installment_autopay_start_date + 1.year
  else
    nil
  end

  if next_installment && next_installment <= 30.days.from_now
    installment_amount = case policy.payment_mode.downcase
    when 'monthly'
      policy.total_premium / 12.0
    when 'quarterly'
      policy.total_premium / 4.0
    when 'half-yearly', 'half yearly'
      policy.total_premium / 2.0
    when 'yearly'
      policy.total_premium
    else
      policy.total_premium
    end

    installments << {
      id: policy.id,
      insurance_name: policy.plan_name || "Life Insurance",
      insurance_type: "Life",
      policy_number: policy.policy_number,
      next_installment_date: next_installment,
      installment_amount: installment_amount
    }
  end
end

puts "Found #{installments.count} upcoming installments:"
installments.each do |inst|
  puts "- #{inst[:insurance_type]} Policy ##{inst[:id]}: #{inst[:insurance_name]}"
  puts "  Next: #{inst[:next_installment_date]}, Amount: ₹#{inst[:installment_amount].round(2)}"
end