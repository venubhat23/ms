class CommissionCalculatorService
  # Commission percentage structure based on user requirements
  COMMISSION_RATES = {
    main_agent: 10.0,      # 10% of premium
    affiliate: 2.0,        # 2% of premium
    ambassador: 2.0,       # 2% of premium
    investor: 1.0,         # 1% of premium
    company_expense: 3.0   # 3% of premium (from main agent's share)
  }.freeze

  def self.calculate_commission_breakdown(policy)
    return {} unless policy.respond_to?(:total_premium) && policy.total_premium.present?

    premium = policy.total_premium.to_f

    # Get commission percentages from the policy (if stored) or use defaults
    main_agent_rate = policy.try(:main_agent_commission_percentage) || COMMISSION_RATES[:main_agent]
    affiliate_rate = policy.try(:affiliate_commission_percentage) || COMMISSION_RATES[:affiliate]
    ambassador_rate = policy.try(:ambassador_commission_percentage) || COMMISSION_RATES[:ambassador]
    investor_rate = policy.try(:investor_commission_percentage) || COMMISSION_RATES[:investor]
    company_expense_rate = policy.try(:company_expense_percentage) || COMMISSION_RATES[:company_expense]

    # Calculate base commission amounts
    main_agent_total = premium * (main_agent_rate / 100.0)
    affiliate_commission = premium * (affiliate_rate / 100.0)
    ambassador_commission = premium * (ambassador_rate / 100.0)
    investor_commission = premium * (investor_rate / 100.0)

    # Calculate deductions from main agent commission
    total_deductions = affiliate_commission + ambassador_commission + investor_commission
    company_expense = main_agent_total * (company_expense_rate / 100.0)

    # Main agent's final profit
    main_agent_profit = main_agent_total - total_deductions - company_expense

    {
      premium_amount: premium,
      main_agent: {
        total_commission: main_agent_total,
        deductions: {
          affiliate: affiliate_commission,
          ambassador: ambassador_commission,
          investor: investor_commission,
          company_expense: company_expense,
          total: total_deductions + company_expense
        },
        final_profit: main_agent_profit
      },
      payouts: {
        affiliate: affiliate_commission,
        ambassador: ambassador_commission,
        investor: investor_commission,
        company_expense: company_expense
      },
      summary: {
        total_commission_generated: main_agent_total,
        total_distributed: total_deductions,
        company_expense: company_expense,
        agent_profit: main_agent_profit
      }
    }
  end

  def self.get_policy_commission_summary(policy)
    breakdown = calculate_commission_breakdown(policy)
    return nil if breakdown.empty?

    # Get existing payout records
    policy_type = policy.class.name.underscore.gsub('_insurance', '')
    existing_payouts = CommissionPayout.where(
      policy_type: policy_type,
      policy_id: policy.id
    )

    {
      policy: {
        type: policy_type.titleize,
        number: policy.policy_number,
        customer: policy.customer.display_name,
        premium: breakdown[:premium_amount]
      },
      commission_breakdown: breakdown,
      payout_status: {
        affiliate: get_payout_status(existing_payouts, 'affiliate'),
        ambassador: get_payout_status(existing_payouts, 'ambassador'),
        investor: get_payout_status(existing_payouts, 'investor'),
        company_expense: get_payout_status(existing_payouts, 'company_expense')
      }
    }
  end

  def self.get_payout_status(existing_payouts, payout_type)
    payout = existing_payouts.find { |p| p.payout_to == payout_type }
    return { status: 'not_applicable', amount: 0 } unless payout

    {
      status: payout.status,
      amount: payout.payout_amount,
      payout_date: payout.payout_date,
      transaction_id: payout.transaction_id,
      id: payout.id
    }
  end
end
