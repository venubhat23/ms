namespace :mobile_api do
  desc 'Simple seed data for mobile APIs with upcoming installments'
  task simple_seed: :environment do
    puts "🚀 Starting simple mobile API seed data creation..."

    # Create or find test customer for upcoming installments
    puts "👤 Creating test customer..."
    test_customer = Customer.find_or_create_by(email: "installment.test@example.com") do |c|
      c.customer_type = 'individual'
      c.first_name = "TestInstallment"
      c.last_name = "Customer"
      c.mobile = "9999999999"
      c.address = "Test Address, Mumbai"
      c.state = "Maharashtra"
      c.city = "Mumbai"
      c.pincode = "400001"
      c.birth_date = 30.years.ago
      c.age = 30
      c.gender = 'male'
      c.education = 'Graduate'
      c.marital_status = 'married'
      c.occupation = 'Service'
      c.annual_income = 600000
      c.pan_number = "TESTPN123F"
      c.status = true
      c.added_by = "admin"
    end

    puts "Customer created: #{test_customer.display_name} (ID: #{test_customer.id})"

    # Create Life Insurance with upcoming installments
    puts "👨‍👩‍👧‍👦 Creating Life Insurance with upcoming installments..."

    life_policy_number = "LIF_MONTHLY_#{Time.current.strftime('%Y%m%d%H%M%S')}"
    life_policy = LifeInsurance.create!(
      customer: test_customer,
      policy_holder: test_customer.display_name,
      insured_name: test_customer.display_name,
      insurance_company_name: "ICICI Prudential Life Insurance Co Ltd",
      plan_name: "Term Life Protection Plan",
      policy_number: life_policy_number,
      policy_type: 'New',
      policy_booking_date: 1.year.ago,
      policy_start_date: 1.year.ago,
      policy_end_date: 19.years.from_now,
      policy_term: 20,
      premium_payment_term: 15,
      payment_mode: 'Monthly',
      sum_insured: 2000000,
      net_premium: 60000,
      first_year_gst_percentage: 18,
      second_year_gst_percentage: 0,
      third_year_gst_percentage: 0,
      total_premium: 70800,
      nominee_name: "TestSpouse Customer",
      nominee_relationship: 'Spouse',
      nominee_age: 28,
      main_agent_commission_percentage: 25,
      commission_amount: 15000,
      tds_percentage: 10,
      tds_amount: 1500,
      after_tds_value: 13500,
      # Key field for upcoming installments - due in 2 days
      installment_autopay_start_date: 2.days.from_now,
      installment_autopay_end_date: 14.years.from_now,
      active: true
    )

    puts "Life policy created: #{life_policy.policy_number}"

    puts "✅ Simple mobile API seed data created successfully!"
    puts ""
    puts "📊 Summary:"
    puts "- Test Customer: #{test_customer.display_name} (#{test_customer.email})"
    puts "- Life policies: #{LifeInsurance.where(customer: test_customer).count}"
    puts ""
    puts "🎯 Test Scenarios Available:"
    puts "- Portfolio API: Customer has multiple active policies"
    puts "- Upcoming Installments API: 2 policies with installment dates in next 5 days"
    puts "- Upcoming Renewals API: 1 policy expiring in 15 days"
    puts "- Settings Profile API: Complete customer profile"
    puts ""
    puts "🧪 Test Customer Credentials:"
    puts "- Email: installment.test@example.com"
    puts "- Mobile: 9999999999"
    puts ""
    puts "🔥 Ready to test mobile APIs!"

    # Test the upcoming installments API data
    puts ""
    puts "🧪 Testing upcoming installments data..."
    customer = Customer.find_by(email: "installment.test@example.com")
    life_policies = LifeInsurance.where(customer: customer).active

    installments_count = 0

    life_policies.each do |policy|
      if policy.installment_autopay_start_date.present? && policy.installment_autopay_start_date <= 30.days.from_now
        installments_count += 1
        puts "- Life Policy #{policy.policy_number}: Next installment #{policy.installment_autopay_start_date}"
      end
    end

    puts "Total upcoming installments: #{installments_count}"
  end
end