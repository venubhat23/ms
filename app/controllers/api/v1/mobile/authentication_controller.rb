class Api::V1::Mobile::AuthenticationController < Api::V1::BaseController
  skip_before_action :authorize_request, only: [:login, :register, :forgot_password, :reset_password, :request_otp, :verify_otp]

  # POST /api/v1/mobile/auth/login
  def login
    # Support login with email or mobile number
    login_field = params[:username] || params[:email] || params[:mobile]
    password = params[:password]

    if login_field.blank? || password.blank?
      return json_response({
        success: false,
        message: 'Email/Mobile and password are required'
      }, :unprocessable_entity)
    end

    # Check if it's a user login (including customers, agents, admin)
    # Support login with both email and mobile number
    user = User.find_by(email: login_field)

    # If not found by email and login_field looks like a mobile number, try mobile search with formatting
    unless user
      formatted_mobile = format_mobile_number(login_field)
      if formatted_mobile
        # Try to find user with multiple mobile format variations
        user = find_by_mobile_variants(User, formatted_mobile)
      else
        # If format_mobile_number returns nil, try direct mobile search as fallback
        user = User.find_by(mobile: login_field)
      end
    end
    if user && user.valid_password?(password) && user.status

      if user.customer?
        # Customer login - find associated customer record
        customer = Customer.find_by(email: user.email)
        unless customer
          formatted_mobile = format_mobile_number(user.mobile)
          if formatted_mobile
            customer = find_by_mobile_variants(Customer, formatted_mobile)
          else
            customer = Customer.find_by(mobile: user.mobile)
          end
        end
        if customer
          token = generate_token(user, 'customer')
          portfolio_stats = get_customer_portfolio_stats(customer)

          json_response({
            success: true,
            data: {
              token: token,
              username: user.full_name,
              role: 'customer',
              user_id: user.id,
              customer_id: customer.id,
              email: user.email,
              mobile: user.mobile,
              customer_wallet_enabled: SystemSetting.customer_wallet_enabled?,
              portfolio_summary: {
                total_policies: portfolio_stats[:total_policies],
                upcoming_installments: portfolio_stats[:upcoming_installments],
                renewal_policies: portfolio_stats[:renewal_policies]
              }
            }
          })
          return
        end
      elsif user.agent? || user.admin? || user.sub_agent?
        # Agent/Admin login
        token = generate_token(user, user.user_type)
        agent_stats = get_agent_statistics(user)

        json_response({
          success: true,
          data: {
            token: token,
            username: user.full_name,
            role: user.user_type,
            user_id: user.id,
            email: user.email,
            mobile: user.mobile,
            commission_earned: agent_stats[:commission_earned],
            customers_count: agent_stats[:customers_count],
            policies_count: agent_stats[:policies_count],
            commission_breakdown: agent_stats[:commission_breakdown],
            dashboard_stats: {
              total_commission: agent_stats[:commission_earned],
              monthly_target: 75000,
              achievement_percentage: ((agent_stats[:commission_earned] / 75000) * 100).round(2),
              policies_this_month: (agent_stats[:policies_count] * 0.3).round,
              customers_this_month: (agent_stats[:customers_count] * 0.25).round,
              conversion_rate: "#{rand(65..85)}%"
            }
          }
        })
        return
      end
    end

    # Check direct Customer login
    customer = Customer.find_by(email: login_field)
    unless customer
      formatted_mobile = format_mobile_number(login_field)
      if formatted_mobile
        customer = find_by_mobile_variants(Customer, formatted_mobile)
      else
        customer = Customer.find_by(mobile: login_field)
      end
    end

    if customer && customer.authenticate(password) && customer.status
      token = generate_token(customer, 'customer')
      portfolio_stats = get_customer_portfolio_stats(customer)

      json_response({
        success: true,
        data: {
          token: token,
          username: customer.display_name,
          role: 'customer',
          user_id: customer.id,
          customer_id: customer.id,
          email: customer.email,
          mobile: customer.mobile,
          customer_wallet_enabled: SystemSetting.customer_wallet_enabled?,
          profile: {
            first_name: customer.first_name,
            last_name: customer.last_name,
            middle_name: customer.middle_name,
            gender: customer.gender,
            birth_date: customer.birth_date,
            address: customer.address,
            city: customer.city,
            state: customer.state,
            pincode: customer.pincode
          },
          portfolio_summary: {
            total_policies: portfolio_stats[:total_policies],
            upcoming_installments: portfolio_stats[:upcoming_installments],
            renewal_policies: portfolio_stats[:renewal_policies]
          }
        }
      })
      return
    end

    # Check DeliveryPerson login
    delivery_person = DeliveryPerson.find_by(email: login_field)
    unless delivery_person
      # First try direct mobile search (for 12-digit numbers like 919190939300)
      delivery_person = DeliveryPerson.find_by(mobile: login_field)

      unless delivery_person
        formatted_mobile = format_mobile_number(login_field)
        if formatted_mobile
          delivery_person = find_by_mobile_variants(DeliveryPerson, formatted_mobile)
        end
      end
    end
    if delivery_person && delivery_person.authenticate(password) && delivery_person.status
      token = generate_token(delivery_person, 'delivery_person')

      # Get delivery person statistics
      delivery_stats = get_delivery_person_statistics(delivery_person)

      json_response({
        success: true,
        data: {
          token: token,
          username: delivery_person.display_name,
          role: 'delivery_person',
          user_id: delivery_person.id,
          delivery_person_id: delivery_person.id,
          email: delivery_person.email,
          mobile: delivery_person.mobile,
          profile: {
            first_name: delivery_person.first_name,
            last_name: delivery_person.last_name,
            vehicle_type: delivery_person.vehicle_type,
            vehicle_number: delivery_person.vehicle_number,
            license_number: delivery_person.license_number,
            delivery_areas: delivery_person.delivery_area_list,
            joining_date: delivery_person.joining_date,
            years_of_service: delivery_person.years_of_service
          },
          dashboard_stats: {
            total_deliveries: delivery_stats[:total_deliveries],
            completed_deliveries: delivery_stats[:completed_deliveries],
            pending_deliveries: delivery_stats[:pending_deliveries],
            success_rate: delivery_stats[:success_rate],
            earnings_this_month: delivery_stats[:earnings_this_month],
            deliveries_this_month: delivery_stats[:deliveries_this_month],
            average_rating: delivery_stats[:average_rating],
            vehicle_info: delivery_person.vehicle_info
          }
        }
      })
      return
    end

    # Check sub-agent login
    sub_agent = SubAgent.find_by(email: login_field)
    unless sub_agent
      formatted_mobile = format_mobile_number(login_field)
      if formatted_mobile
        sub_agent = find_by_mobile_variants(SubAgent, formatted_mobile)
      else
        sub_agent = SubAgent.find_by(mobile: login_field)
      end
    end
    if sub_agent && sub_agent.status == 'active'
      # For sub-agents, we also don't have password in current model
      token = generate_token(sub_agent, 'sub_agent')

      # Get sub-agent statistics
      sub_agent_stats = get_sub_agent_statistics(sub_agent)

      json_response({
        success: true,
        data: {
          token: token,
          username: sub_agent.display_name,
          role: 'sub_agent',
          user_id: sub_agent.id,
          email: sub_agent.email,
          mobile: sub_agent.mobile,
          commission_earned: sub_agent_stats[:commission_earned],
          customers_count: sub_agent_stats[:customers_count],
          policies_count: sub_agent_stats[:policies_count],
          commission_breakdown: sub_agent_stats[:commission_breakdown],
          monthly_target: sub_agent_stats[:monthly_target],
          achievement_percentage: sub_agent_stats[:achievement_percentage],
          dashboard_stats: {
            total_commission: sub_agent_stats[:commission_earned],
            monthly_target: sub_agent_stats[:monthly_target],
            achievement_percentage: sub_agent_stats[:achievement_percentage],
            policies_this_month: get_current_month_policies_count(sub_agent),
            customers_this_month: get_current_month_customers_count(sub_agent),
            conversion_rate: calculate_conversion_rate(sub_agent),
            ranking: calculate_agent_ranking(sub_agent),
            team_size: get_team_size(sub_agent),
            performance_grade: calculate_performance_grade(sub_agent_stats[:achievement_percentage])
          },
          agency_info: {
            agency_name: "#{sub_agent.display_name} Agency",
            license_number: "AGY#{sub_agent.id.to_s.rjust(6, '0')}",
            territory: ["North Zone", "South Zone", "East Zone", "West Zone"][sub_agent.id % 4],
            join_date: (Date.current - rand(30..1000).days).strftime("%Y-%m-%d")
          }
        }
      })
      return
    end


    json_response({
      success: false,
      message: 'Invalid username or password'
    }, :unauthorized)
  end

  # POST /api/v1/mobile/auth/forgot_password
  def forgot_password
    email = params[:email]&.strip

    if email.blank?
      return json_response({
        success: false,
        message: 'Email is required'
      }, :unprocessable_entity)
    end

    customer = Customer.find_by('LOWER(email) = ?', email.downcase)

    unless customer
      return json_response({
        success: false,
        message: 'No account found with that email address'
      }, :not_found)
    end

    customer.generate_password_reset_token!

    begin
      CustomerMailer.password_reset_instructions(customer).deliver_now
    rescue => e
      Rails.logger.error "Forgot password mailer failed for #{customer.email}: #{e.message}"
    end

    json_response({
      success: true,
      message: 'Password reset instructions have been sent to your email'
    })
  end

  # POST /api/v1/mobile/auth/reset_password
  def reset_password
    token    = params[:token]
    password = params[:password]
    password_confirmation = params[:password_confirmation]

    if token.blank?
      return json_response({ success: false, message: 'Reset token is required' }, :unprocessable_entity)
    end

    customer = Customer.find_by_password_reset_token(token)

    unless customer
      return json_response({ success: false, message: 'Invalid or expired reset token' }, :unprocessable_entity)
    end

    if customer.password_reset_expired?
      return json_response({ success: false, message: 'Reset token has expired. Please request a new one.' }, :unprocessable_entity)
    end

    if password.blank? || password.length < 6
      return json_response({ success: false, message: 'Password must be at least 6 characters' }, :unprocessable_entity)
    end

    if password != password_confirmation
      return json_response({ success: false, message: 'Password confirmation does not match' }, :unprocessable_entity)
    end

    customer.password = password
    customer.password_confirmation = password_confirmation

    if customer.save
      customer.clear_password_reset_token!

      # Sync the associated User record so Devise-based mobile login also accepts the new password
      begin
        user = User.find_by('LOWER(email) = ?', customer.email.downcase)
        if user
          user.password = password
          user.save(validate: false)
        end
      rescue => e
        Rails.logger.error "Failed to sync User password for #{customer.email}: #{e.message}"
      end

      begin
        CustomerMailer.password_changed_notification(customer).deliver_now
      rescue => e
        Rails.logger.error "Password changed notification failed for #{customer.email}: #{e.message}"
      end
      json_response({ success: true, message: 'Password has been reset successfully. You can now log in.' })
    else
      json_response({ success: false, message: 'Failed to update password', errors: customer.errors.full_messages }, :unprocessable_entity)
    end
  end

  # POST /api/v1/mobile/auth/register
  def register
    # Handle both 'role' and 'user_type' parameters for backward compatibility
    role = params[:role]&.downcase || params[:user_type]&.downcase || 'customer'

    # Ensure valid role values
    case role
    when 'customer', 'user'
      register_customer
    when 'agent', 'sub_agent'
      register_agent
    else
      json_response({
        success: false,
        message: 'Invalid role. Only customer and agent registration are allowed.',
        valid_roles: ['customer', 'agent']
      }, :unprocessable_entity)
    end
  end

  def register_customer
    customer_params = params.permit(:first_name, :last_name, :middle_name, :email, :mobile, :password, :password_confirmation,
                                   :user_type, :role, :address, :city, :state, :pincode, :whatsapp_number, :latitude, :longitude, :is_registered_by_mobile)

    # Validate required fields
    if customer_params[:first_name].blank? || customer_params[:last_name].blank? ||
       customer_params[:email].blank? || customer_params[:mobile].blank? || customer_params[:password].blank?
      return json_response({
        success: false,
        message: 'First name, last name, email, mobile number, and password are required'
      }, :unprocessable_entity)
    end

    # Validate password confirmation if provided
    if customer_params[:password_confirmation].present? && customer_params[:password] != customer_params[:password_confirmation]
      return json_response({
        success: false,
        message: 'Password confirmation does not match'
      }, :unprocessable_entity)
    end

    # Validate email format
    unless customer_params[:email].match?(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
      return json_response({
        success: false,
        message: 'Please enter a valid email address'
      }, :unprocessable_entity)
    end

    # Validate and format mobile number
    mobile_number = format_mobile_number(customer_params[:mobile])
    unless mobile_number
      return json_response({
        success: false,
        message: 'Please enter a valid Indian mobile number (10 digits starting with 6-9)'
      }, :unprocessable_entity)
    end

    # Validate name fields
    unless validate_name_fields(customer_params[:first_name])
      return json_response({
        success: false,
        message: 'First name should contain only alphabetic characters and be 2-50 characters long'
      }, :unprocessable_entity)
    end

    unless validate_name_fields(customer_params[:last_name])
      return json_response({
        success: false,
        message: 'Last name should contain only alphabetic characters and be 2-50 characters long'
      }, :unprocessable_entity)
    end

    # Validate password strength
    if customer_params[:password].length < 6
      return json_response({
        success: false,
        message: 'Password must be at least 6 characters long'
      }, :unprocessable_entity)
    end

    # Check if customer or user already exists
    existing_customer_email = Customer.exists?(email: customer_params[:email])
    existing_customer_mobile = Customer.exists?(mobile: mobile_number)
    existing_user_email = User.exists?(email: customer_params[:email])
    existing_user_mobile = User.exists?(mobile: mobile_number)

    if existing_customer_email || existing_user_email
      return json_response({
        success: false,
        message: 'An account with this email address already exists. Please use a different email or try logging in.'
      }, :conflict)
    end

    if existing_customer_mobile || existing_user_mobile
      return json_response({
        success: false,
        message: 'An account with this mobile number already exists. Please use a different mobile number or try logging in.'
      }, :conflict)
    end

    # Use database transaction to ensure both records are created together
    begin
      ActiveRecord::Base.transaction do
        # Create Customer record (without password validations)
        customer = Customer.new(
          first_name: customer_params[:first_name],
          last_name: customer_params[:last_name],
          middle_name: customer_params[:middle_name],
          email: customer_params[:email],
          mobile: mobile_number,
          address: customer_params[:address],
          whatsapp_number: customer_params[:whatsapp_number],
          latitude: customer_params[:latitude],
          longitude: customer_params[:longitude],
          is_registered_by_mobile: true,
          status: true
        )
        # Set password so the Customer record can authenticate on the web login page too
        customer.password = customer_params[:password]
        customer.save!(validate: false)

        # Create User record for login
        user = User.new(
          first_name: customer_params[:first_name],
          last_name: customer_params[:last_name],
          middle_name: customer_params[:middle_name],
          email: customer_params[:email],
          mobile: mobile_number, # Use formatted mobile number
          user_type: 'customer',
          address: customer_params[:address],
          city: customer_params[:city],
          state: customer_params[:state],
          pincode: customer_params[:pincode],
          status: true
        )

        # Set password separately to ensure proper Devise handling
        user.password = customer_params[:password]
        user.password_confirmation = customer_params[:password_confirmation].present? ? customer_params[:password_confirmation] : customer_params[:password]
        user.save!

        json_response({
          success: true,
          message: 'Customer registration successful. You can now login with your credentials.',
          data: {
            customer_id: customer.id,
            user_id: user.id,
            email: customer.email,
            mobile: customer.mobile,
            role: 'customer'
          }
        })
      end
    rescue ActiveRecord::RecordInvalid => e
      json_response({
        success: false,
        message: 'Customer registration failed',
        errors: e.record.errors.full_messages
      }, :unprocessable_entity)
    rescue => e
      json_response({
        success: false,
        message: 'Registration failed due to system error',
        error: e.message
      }, :internal_server_error)
    end
  end

  def register_agent
    agent_params = params.permit(:first_name, :last_name, :email, :mobile, :password, :password_confirmation,
                                :pan_no, :address, :city, :state, :gender, :occupation, :annual_income)

    # Validate required fields
    if agent_params[:first_name].blank? || agent_params[:last_name].blank? ||
       agent_params[:email].blank? || agent_params[:mobile].blank? || agent_params[:password].blank?
      return json_response({
        success: false,
        message: 'First name, last name, email, mobile number, and password are required'
      }, :unprocessable_entity)
    end

    # Validate password confirmation
    if agent_params[:password_confirmation].present? && agent_params[:password] != agent_params[:password_confirmation]
      return json_response({
        success: false,
        message: 'Password confirmation does not match'
      }, :unprocessable_entity)
    end

    # Validate email format
    unless agent_params[:email].match?(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
      return json_response({
        success: false,
        message: 'Please enter a valid email address'
      }, :unprocessable_entity)
    end

    # Validate and format mobile number
    mobile_number = format_mobile_number(agent_params[:mobile])
    unless mobile_number
      return json_response({
        success: false,
        message: 'Please enter a valid Indian mobile number (10 digits starting with 6-9)'
      }, :unprocessable_entity)
    end

    # Validate name fields
    unless validate_name_fields(agent_params[:first_name])
      return json_response({
        success: false,
        message: 'First name should contain only alphabetic characters and be 2-50 characters long'
      }, :unprocessable_entity)
    end

    unless validate_name_fields(agent_params[:last_name])
      return json_response({
        success: false,
        message: 'Last name should contain only alphabetic characters and be 2-50 characters long'
      }, :unprocessable_entity)
    end

    # Validate password strength
    if agent_params[:password].length < 6
      return json_response({
        success: false,
        message: 'Password must be at least 6 characters long'
      }, :unprocessable_entity)
    end

    # Check if user already exists
    existing_user_email = User.exists?(email: agent_params[:email])
    existing_user_mobile = User.exists?(mobile: mobile_number)

    if existing_user_email
      return json_response({
        success: false,
        message: 'An account with this email address already exists. Please use a different email or try logging in.'
      }, :conflict)
    end

    if existing_user_mobile
      return json_response({
        success: false,
        message: 'An account with this mobile number already exists. Please use a different mobile number or try logging in.'
      }, :conflict)
    end

    user = User.new(
      first_name: agent_params[:first_name],
      last_name: agent_params[:last_name],
      email: agent_params[:email],
      mobile: mobile_number, # Use formatted mobile number
      user_type: 'agent',
      role: 'agent_role',
      status: false,  # Pending approval
      pan_number: agent_params[:pan_no],
      address: agent_params[:address],
      city: agent_params[:city],
      state: agent_params[:state],
      gender: agent_params[:gender],
      occupation: agent_params[:occupation],
      annual_income: agent_params[:annual_income]
    )

    # Set password separately to ensure proper Devise handling
    user.password = agent_params[:password]
    user.password_confirmation = agent_params[:password_confirmation].present? ? agent_params[:password_confirmation] : agent_params[:password]

    if user.save
      json_response({
        success: true,
        message: 'Agent registration successful. Your account is pending approval by admin.',
        data: {
          user_id: user.id,
          email: user.email,
          mobile: user.mobile,
          role: 'agent'
        }
      })
    else
      json_response({
        success: false,
        message: 'Agent registration failed',
        errors: user.errors.full_messages
      }, :unprocessable_entity)
    end
  end

  # POST /api/v1/mobile/auth/otp/request
  def request_otp
    unless SystemSetting.otp_login_enabled?
      return json_response({ success: false, message: 'OTP login is currently disabled' }, :forbidden)
    end

    mobile = format_mobile_number(params[:mobile])
    unless mobile
      return json_response({
        success: false,
        message: 'Please enter a valid Indian mobile number (10 digits starting with 6-9)'
      }, :unprocessable_entity)
    end

    status, retry_after = OtpVerification.rate_limit_status(mobile)
    if status != :ok
      message = status == :cooldown ? 'Please wait before requesting another OTP' : 'Too many OTP requests. Please try again later.'
      return json_response({ success: false, message: message, retry_after: retry_after }, :too_many_requests)
    end

    _record, otp_code = OtpVerification.generate!(mobile, purpose: 'login', request_ip: request.remote_ip)
    result = OtpSmsService.send_otp(mobile, otp_code)

    if result[:success]
      json_response({
        success: true,
        message: 'OTP sent successfully',
        retry_after: OtpVerification::RESEND_COOLDOWN.to_i
      })
    else
      json_response({ success: false, message: result[:error] || 'Failed to send OTP' }, :internal_server_error)
    end
  end

  # POST /api/v1/mobile/auth/otp/verify
  def verify_otp
    unless SystemSetting.otp_login_enabled?
      return json_response({ success: false, message: 'OTP login is currently disabled' }, :forbidden)
    end

    mobile = format_mobile_number(params[:mobile])
    otp_code = params[:otp].to_s.strip

    if mobile.nil? || otp_code.blank?
      return json_response({ success: false, message: 'Mobile number and OTP are required' }, :unprocessable_entity)
    end

    case OtpVerification.verify(mobile, otp_code, purpose: 'login')
    when :verified
      user, customer, is_new_user = find_or_create_otp_account(mobile)
      token = generate_token(user, 'customer')

      json_response({
        success: true,
        message: is_new_user ? 'Account created and logged in successfully' : 'Logged in successfully',
        data: {
          token: token,
          user_id: user.id,
          customer_id: customer.id,
          mobile: user.mobile,
          is_new_user: is_new_user,
          customer_wallet_enabled: SystemSetting.customer_wallet_enabled?
        }
      })
    when :expired
      json_response({ success: false, message: 'OTP has expired. Please request a new one.' }, :unprocessable_entity)
    when :too_many_attempts
      json_response({ success: false, message: 'Too many incorrect attempts. Please request a new OTP.' }, :too_many_requests)
    else
      json_response({ success: false, message: 'Invalid OTP' }, :unprocessable_entity)
    end
  end

  private

  # Finds the User/Customer pair for a mobile-verified OTP login, creating a
  # minimal pair (placeholder name + synthetic unique email) on first login so
  # the app can prompt the user to complete their profile afterwards via the
  # existing PUT /settings/profile endpoint. Mirrors the User+Customer
  # creation done in #register_customer above so both auth paths stay in sync.
  def find_or_create_otp_account(mobile)
    user = User.find_by(mobile: mobile)

    if user
      customer = Customer.find_by(mobile: mobile) || Customer.find_by(email: user.email)
      return [user, customer, false] if customer

      customer = Customer.new(
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        mobile: mobile,
        is_registered_by_mobile: true,
        status: true
      )
      customer.password = SecureRandom.hex(16)
      customer.save!(validate: false)
      return [user, customer, false]
    end

    random_password = SecureRandom.hex(16)
    new_user = nil
    new_customer = nil

    ActiveRecord::Base.transaction do
      new_user = User.new(
        first_name: 'Customer',
        last_name: mobile[-4..-1],
        email: "otp_#{mobile}@users.noemail",
        mobile: mobile,
        user_type: 'customer',
        status: true
      )
      new_user.password = random_password
      new_user.password_confirmation = random_password
      new_user.save!

      new_customer = Customer.new(
        first_name: new_user.first_name,
        last_name: new_user.last_name,
        email: new_user.email,
        mobile: mobile,
        is_registered_by_mobile: true,
        status: true
      )
      new_customer.password = random_password
      new_customer.save!(validate: false)
    end

    [new_user, new_customer, true]
  end

  def generate_token(user, role)
    payload = {
      user_id: user.id,
      role: role,
      exp: 30.days.from_now.to_i
    }

    # Add specific ID fields based on role
    case role
    when 'delivery_person'
      payload[:delivery_person_id] = user.id
    when 'customer'
      payload[:customer_id] = user.id
    when 'sub_agent'
      payload[:sub_agent_id] = user.id
    end

    JWT.encode(payload, Rails.application.secret_key_base)
  end

  def validate_name_fields(name)
    return false if name.blank?
    # Allow only alphabetic characters and spaces, min 2 characters
    name.match?(/\A[a-zA-Z\s]{2,50}\z/)
  end

  # One query across all mobile format variants instead of up to 5 chained
  # sequential find_by calls per login stage (User/Customer/DeliveryPerson/
  # SubAgent) — matches the same variant list each of those used.
  def find_by_mobile_variants(klass, formatted_mobile)
    variants = [
      formatted_mobile,
      "+91#{formatted_mobile}",
      "+91 #{formatted_mobile}",
      "#{formatted_mobile[0..4]} #{formatted_mobile[5..9]}",
      "+91 #{formatted_mobile[0..4]} #{formatted_mobile[5..9]}"
    ]
    klass.where(mobile: variants).first
  end

  def format_mobile_number(mobile)
    return nil if mobile.blank?
    # Remove all non-digit characters
    clean_mobile = mobile.to_s.gsub(/\D/, '')

    # Handle different mobile number formats
    if clean_mobile.length == 10
      # Standard 10-digit format, accept all (for testing purposes)
      return clean_mobile
    elsif clean_mobile.length == 12 && clean_mobile.start_with?('91')
      # 12 digits starting with 91
      return clean_mobile[2..-1]
    elsif clean_mobile.length == 13 && clean_mobile.start_with?('+91')
      # +91 prefix with spaces removed
      return clean_mobile[3..-1]
    else
      return nil
    end
  end

  def get_agent_statistics(user)
    # No insurance policy types remain (life/motor/other/health insurance were
    # all removed), so there's no real commission data to compute — fall
    # straight to the mock-data path that used to only run when real data was
    # absent.
    total_commission = generate_mock_commission(user)
    total_policies = generate_mock_policies_count(user)
    customer_ids = generate_mock_customers(user, total_policies)

    {
      commission_earned: total_commission.round(2),
      customers_count: customer_ids.uniq.count,
      policies_count: total_policies,
      commission_breakdown: {}
    }
  end

  def get_sub_agent_statistics(sub_agent)
    # Get policies where sub-agent is involved (using sub_agent_id).
    # Loaded once via .to_a and reused below for commission sum, customer_ids,
    # and count — previously each of those re-queried the same rows (up to 9
    # round trips per agent instead of 3).
    life_policies = LifeInsurance.where(sub_agent_id: sub_agent.id).to_a
    motor_policies = []

    begin
      motor_policies = MotorInsurance.where(sub_agent_id: sub_agent.id).to_a if defined?(MotorInsurance)
    rescue => e
      # Skip motor insurance if there's an error
      motor_policies = []
    end

    # Calculate commission from each policy type using actual database values
    life_commission = life_policies.sum do |policy|
      commission = 0.0
      # LifeInsurance has sub_agent_commission_amount field
      commission = policy.sub_agent_commission_amount.to_f if policy.respond_to?(:sub_agent_commission_amount) && policy.sub_agent_commission_amount.present?
      commission = policy.after_tds_value.to_f if commission == 0.0 && policy.respond_to?(:after_tds_value) && policy.after_tds_value.present?
      commission = policy.commission_amount.to_f if commission == 0.0 && policy.respond_to?(:commission_amount) && policy.commission_amount.present?
      commission = calculate_life_commission(policy) if commission == 0.0
      commission
    end

    motor_commission = 0
    if motor_policies&.any?
      motor_commission = motor_policies.sum do |policy|
        commission = 0.0
        # MotorInsurance may have different commission field names
        commission = policy.main_agent_commission_amount.to_f if policy.respond_to?(:main_agent_commission_amount) && policy.main_agent_commission_amount.present?
        commission = policy.commission_amount.to_f if commission == 0.0 && policy.respond_to?(:commission_amount) && policy.commission_amount.present?
        commission = policy.after_tds_value.to_f if commission == 0.0 && policy.respond_to?(:after_tds_value) && policy.after_tds_value.present?
        commission = calculate_motor_commission(policy) if commission == 0.0
        commission
      end
    end

    total_commission = life_commission + motor_commission

    # Get unique customer IDs from actual policies - this is the real-time customer count
    customer_ids = life_policies.map(&:customer_id)
    customer_ids += motor_policies.map(&:customer_id) if motor_policies&.any?

    total_policies = life_policies.size
    total_policies += motor_policies.size if motor_policies&.any?

    # Use only customers who have active policies for real-time data
    real_customers_count = customer_ids.uniq.count
    monthly_target = 50000.0

    {
      commission_earned: total_commission.round(2),
      customers_count: real_customers_count,
      policies_count: total_policies,
      commission_breakdown: {
        life_commission: life_commission.round(2),
        motor_commission: motor_commission.round(2)
      },
      monthly_target: monthly_target,
      achievement_percentage: total_commission > 0 ? ((total_commission / monthly_target) * 100).round(2) : 0.0
    }
  end

  # Helper methods for commission calculation
  def calculate_life_commission(policy)
    return 0.0 unless policy&.net_premium
    # Default 10% commission for life insurance first year
    (policy.net_premium.to_f * 0.10)
  end

  def calculate_motor_commission(policy)
    return 0.0 unless policy&.respond_to?(:net_premium) && policy.net_premium
    # Default 15% commission for motor insurance
    (policy.net_premium.to_f * 0.15)
  end

  # Mock data generation methods
  def generate_mock_commission(user)
    # Generate realistic commission based on user ID for consistency
    base_commission = 25000 + (user.id * 1250) % 75000
    variation = (user.id * 17) % 20000 - 10000
    [base_commission + variation, 5000].max.to_f
  end

  def generate_mock_policies_count(user)
    # Generate consistent policy count based on user ID
    base_count = 15 + (user.id * 3) % 35
    [base_count, 5].max
  end

  def generate_mock_customers(user, policies_count)
    # Generate consistent customer IDs based on user ID
    customer_count = [(policies_count * 0.7).round, 3].max
    base_id = user.id * 100
    (1..customer_count).map { |i| base_id + i }
  end

  def get_customer_portfolio_stats(customer)
    # This is an ecommerce application, so return ecommerce-related stats
    begin
      # Called on every customer login — collapsed from 5 separate round
      # trips (orders: count/sum/maximum, bookings: count/maximum) into 2,
      # one per table, using Postgres FILTER/aggregate combos via .pick.
      total_orders, total_spent, last_order_date = customer.orders.pick(Arel.sql(<<~SQL.squish))
        COUNT(*),
        COALESCE(SUM(total_amount) FILTER (WHERE status NOT IN ('cancelled', 'returned')), 0),
        MAX(created_at)
      SQL

      total_bookings, last_booking_date = customer.bookings.pick(Arel.sql('COUNT(*), MAX(created_at)'))

      {
        total_orders: total_orders,
        total_bookings: total_bookings,
        total_spent: total_spent.to_f,
        member_since: customer.created_at,
        recent_activity: {
          last_order_date: last_order_date,
          last_booking_date: last_booking_date
        }
      }
    rescue => e
      Rails.logger.error "Customer stats calculation error: #{e.message}"
      # Return basic data if there's any error
      {
        total_orders: 0,
        total_bookings: 0,
        total_spent: 0.0,
        member_since: customer.created_at,
        recent_activity: {
          last_order_date: nil,
          last_booking_date: nil
        }
      }
    end
  end

  def calculate_next_installment_date(start_date, payment_mode)
    return nil unless start_date

    case payment_mode.to_s.downcase
    when 'monthly'
      start_date + 1.month
    when 'quarterly'
      start_date + 3.months
    when 'half-yearly', 'half yearly'
      start_date + 6.months
    when 'yearly'
      start_date + 1.year
    else
      nil
    end
  end

  # Real-time dashboard calculation methods
  def get_current_month_policies_count(sub_agent)
    start_of_month = Date.current.beginning_of_month
    end_of_month = Date.current.end_of_month

    life_policies = LifeInsurance.where(sub_agent_id: sub_agent.id).where(created_at: start_of_month..end_of_month).count

    motor_policies = 0
    begin
      if defined?(MotorInsurance)
        motor_policies = MotorInsurance.where(sub_agent_id: sub_agent.id).where(created_at: start_of_month..end_of_month).count
      end
    rescue => e
      # Skip if error
    end

    life_policies + motor_policies
  end

  def get_current_month_customers_count(sub_agent)
    start_of_month = Date.current.beginning_of_month
    end_of_month = Date.current.end_of_month

    # Count unique customers who got policies this month through this sub-agent
    life_customer_ids = LifeInsurance.where(sub_agent_id: sub_agent.id).where(created_at: start_of_month..end_of_month).pluck(:customer_id)

    motor_customer_ids = []
    begin
      if defined?(MotorInsurance)
        motor_customer_ids = MotorInsurance.where(sub_agent_id: sub_agent.id).where(created_at: start_of_month..end_of_month).pluck(:customer_id)
      end
    rescue => e
      # Skip if error
    end

    (life_customer_ids + motor_customer_ids).uniq.count
  end

  def calculate_conversion_rate(sub_agent)
    # Get leads assigned to this sub-agent in the last 3 months
    three_months_ago = 3.months.ago

    begin
      total_leads = Lead.where(affiliate_id: sub_agent.id).where('created_at >= ?', three_months_ago).count
      converted_leads = Lead.where(affiliate_id: sub_agent.id).where('created_at >= ?', three_months_ago).where(current_stage: ['converted', 'policy_created']).count

      if total_leads > 0
        conversion_rate = ((converted_leads.to_f / total_leads) * 100).round
        "#{conversion_rate}%"
      else
        # If no leads data, calculate based on customers vs policies ratio
        customers_count = Customer.where(sub_agent_id: sub_agent.id).count
        policies_count = get_total_policies_count(sub_agent)

        if customers_count > 0 && policies_count > 0
          rate = [(policies_count.to_f / customers_count * 100).round, 100].min
          "#{rate}%"
        else
          "0%"
        end
      end
    rescue => e
      "N/A"
    end
  end

  def calculate_agent_ranking(sub_agent)
    # Calculate ranking based on commission earned compared to other sub-agents.
    # This used to recompute full statistics (~9 queries) for EVERY active
    # sub-agent on EVERY single login — O(N agents) DB round trips on a hot
    # auth path. The full sorted ranking is now cached for a short window and
    # shared across concurrent logins instead of rebuilt from scratch each time.
    begin
      sorted_agents = Rails.cache.fetch('sub_agent_commission_rankings', expires_in: 15.minutes) do
        SubAgent.where(status: 'active').map do |agent|
          { id: agent.id, commission: get_sub_agent_statistics(agent)[:commission_earned] }
        end.sort_by { |agent| -agent[:commission] }
      end

      # Find current agent's position
      current_agent_rank = sorted_agents.find_index { |agent| agent[:id] == sub_agent.id }

      current_agent_rank ? current_agent_rank + 1 : sorted_agents.count
    rescue => e
      # Fallback to a consistent ranking based on ID
      ((sub_agent.id * 7) % 20) + 1
    end
  end

  def get_team_size(sub_agent)
    # Count customers with active policies from this sub-agent
    life_customer_ids = LifeInsurance.where(sub_agent_id: sub_agent.id).pluck(:customer_id)

    motor_customer_ids = []
    begin
      motor_customer_ids = MotorInsurance.where(sub_agent_id: sub_agent.id).pluck(:customer_id) if defined?(MotorInsurance)
    rescue => e
      # Skip motor insurance if there's an error
      motor_customer_ids = []
    end

    (life_customer_ids + motor_customer_ids).uniq.count
  end

  def calculate_performance_grade(achievement_percentage)
    case achievement_percentage
    when 150..Float::INFINITY
      'A+'
    when 125..149.99
      'A'
    when 100..124.99
      'B+'
    when 75..99.99
      'B'
    when 50..74.99
      'C+'
    when 25..49.99
      'C'
    else
      'D'
    end
  end

  def get_total_policies_count(sub_agent)
    life_count = LifeInsurance.where(sub_agent_id: sub_agent.id).count

    motor_count = 0
    begin
      if defined?(MotorInsurance)
        motor_count = MotorInsurance.where(sub_agent_id: sub_agent.id).count
      end
    rescue => e
      # Skip if error
    end

    life_count + motor_count
  end

  # Customer portfolio calculation helper methods
  def calculate_upcoming_installments(health_policies, life_policies, motor_policies, other_policies)
    upcoming_count = 0
    thirty_days_from_now = 30.days.from_now.to_date

    # Health insurance installments
    health_policies.each do |policy|
      next_installment = get_next_installment_date(policy)
      if next_installment && next_installment <= thirty_days_from_now && next_installment >= Date.current
        upcoming_count += 1
      end
    end

    # Life insurance installments
    life_policies.each do |policy|
      next_installment = get_next_installment_date(policy)
      if next_installment && next_installment <= thirty_days_from_now && next_installment >= Date.current
        upcoming_count += 1
      end
    end

    # Motor insurance installments
    motor_policies.each do |policy|
      next_installment = get_next_installment_date(policy)
      if next_installment && next_installment <= thirty_days_from_now && next_installment >= Date.current
        upcoming_count += 1
      end
    end

    # Other insurance installments
    other_policies.each do |policy|
      next_installment = get_next_installment_date(policy)
      if next_installment && next_installment <= thirty_days_from_now && next_installment >= Date.current
        upcoming_count += 1
      end
    end

    upcoming_count
  end

  def calculate_renewal_policies(health_policies, life_policies, motor_policies, other_policies)
    renewal_count = 0
    ninety_days_from_now = 90.days.from_now.to_date

    # Health insurance renewals
    health_policies.each do |policy|
      if policy.policy_end_date.present? &&
         policy.policy_end_date >= Date.current &&
         policy.policy_end_date <= ninety_days_from_now
        renewal_count += 1
      end
    end

    # Life insurance renewals
    life_policies.each do |policy|
      if policy.policy_end_date.present? &&
         policy.policy_end_date >= Date.current &&
         policy.policy_end_date <= ninety_days_from_now
        renewal_count += 1
      end
    end

    # Motor insurance renewals
    motor_policies.each do |policy|
      if policy.respond_to?(:policy_end_date) &&
         policy.policy_end_date.present? &&
         policy.policy_end_date >= Date.current &&
         policy.policy_end_date <= ninety_days_from_now
        renewal_count += 1
      end
    end

    # Other insurance renewals
    other_policies.each do |policy|
      if policy.respond_to?(:policy_end_date) &&
         policy.policy_end_date.present? &&
         policy.policy_end_date >= Date.current &&
         policy.policy_end_date <= ninety_days_from_now
        renewal_count += 1
      end
    end

    renewal_count
  end

  def calculate_total_coverage(health_policies, life_policies, motor_policies, other_policies)
    total_coverage = 0.0

    # Health insurance coverage
    health_policies.each do |policy|
      total_coverage += policy.sum_insured.to_f if policy.sum_insured.present?
    end

    # Life insurance coverage
    life_policies.each do |policy|
      total_coverage += policy.sum_insured.to_f if policy.sum_insured.present?
    end

    # Motor insurance coverage
    motor_policies.each do |policy|
      if policy.respond_to?(:sum_insured) && policy.sum_insured.present?
        total_coverage += policy.sum_insured.to_f
      elsif policy.respond_to?(:idv_amount) && policy.idv_amount.present?
        total_coverage += policy.idv_amount.to_f
      end
    end

    # Other insurance coverage
    other_policies.each do |policy|
      total_coverage += policy.sum_insured.to_f if policy.respond_to?(:sum_insured) && policy.sum_insured.present?
    end

    total_coverage
  end

  def calculate_total_premiums(health_policies, life_policies, motor_policies, other_policies)
    total_premiums = 0.0

    # Health insurance premiums
    health_policies.each do |policy|
      total_premiums += policy.total_premium.to_f if policy.total_premium.present?
    end

    # Life insurance premiums
    life_policies.each do |policy|
      total_premiums += policy.total_premium.to_f if policy.total_premium.present?
    end

    # Motor insurance premiums
    motor_policies.each do |policy|
      total_premiums += policy.total_premium.to_f if policy.respond_to?(:total_premium) && policy.total_premium.present?
    end

    # Other insurance premiums
    other_policies.each do |policy|
      total_premiums += policy.total_premium.to_f if policy.respond_to?(:total_premium) && policy.total_premium.present?
    end

    total_premiums
  end

  def get_next_installment_date(policy)
    return nil unless policy.respond_to?(:installment_autopay_start_date) && policy.installment_autopay_start_date.present?
    return nil unless policy.respond_to?(:payment_mode) && policy.payment_mode.present?

    start_date = policy.installment_autopay_start_date
    payment_mode = policy.payment_mode

    # Calculate next installment from start date
    case payment_mode.to_s.downcase
    when 'monthly'
      # Find next monthly installment
      months_since_start = ((Date.current.year - start_date.year) * 12) + (Date.current.month - start_date.month)
      next_installment = start_date + (months_since_start + 1).months
      next_installment >= Date.current ? next_installment : start_date + (months_since_start + 2).months
    when 'quarterly'
      # Find next quarterly installment
      quarters_since_start = ((Date.current.year - start_date.year) * 4) + ((Date.current.month - start_date.month) / 3)
      next_installment = start_date + (quarters_since_start + 1).quarters
      next_installment >= Date.current ? next_installment : start_date + (quarters_since_start + 2).quarters
    when 'half_yearly', 'half yearly', 'semi_annual'
      # Find next half-yearly installment
      half_years_since_start = ((Date.current.year - start_date.year) * 2) + ((Date.current.month - start_date.month) / 6)
      next_installment = start_date + (half_years_since_start + 1) * 6.months
      next_installment >= Date.current ? next_installment : start_date + (half_years_since_start + 2) * 6.months
    when 'yearly', 'annual'
      # Find next yearly installment
      years_since_start = Date.current.year - start_date.year
      next_installment = start_date + (years_since_start + 1).years
      next_installment >= Date.current ? next_installment : start_date + (years_since_start + 2).years
    else
      nil
    end
  end

  def count_upcoming_installments(customer)
    # For ecommerce, count upcoming subscription deliveries
    begin
      customer.milk_subscriptions.where(status: 'active')
                                  .where('start_date <= ? AND (end_date IS NULL OR end_date >= ?)',
                                         Date.current, Date.current).count
    rescue
      0
    end
  end

  def count_upcoming_renewals(customer)
    # For ecommerce, count subscriptions ending soon (requiring renewal)
    begin
      customer.milk_subscriptions.where(status: 'active')
                                  .where('end_date BETWEEN ? AND ?', Date.current, 2.months.from_now)
                                  .where.not(end_date: nil).count
    rescue
      0
    end
  end

  def get_delivery_person_statistics(delivery_person)
    # Get actual delivery data if Order model has delivery_person relationship
    begin
      # Try to get actual delivery statistics
      if defined?(Order) && Order.column_names.include?('delivery_person_id')
        total_deliveries = Order.where(delivery_person_id: delivery_person.id).count
        completed_deliveries = Order.where(delivery_person_id: delivery_person.id, status: 'delivered').count
        pending_deliveries = Order.where(delivery_person_id: delivery_person.id, status: ['pending', 'shipped', 'out_for_delivery']).count

        # Calculate success rate
        success_rate = total_deliveries > 0 ? ((completed_deliveries.to_f / total_deliveries) * 100).round(2) : 0

        # Get current month stats
        current_month_deliveries = Order.where(
          delivery_person_id: delivery_person.id,
          created_at: Date.current.beginning_of_month..Date.current.end_of_month
        ).count

        # Mock earnings calculation (₹50 per delivery)
        earnings_this_month = current_month_deliveries * 50

        # Mock average rating
        average_rating = (4.0 + (rand * 1.0)).round(1) # Random rating between 4.0-5.0
      else
        # Generate realistic mock data if actual Order model doesn't have delivery person relationship
        total_deliveries = 150 + (delivery_person.id % 100)
        completed_deliveries = (total_deliveries * 0.85).to_i
        pending_deliveries = total_deliveries - completed_deliveries
        success_rate = ((completed_deliveries.to_f / total_deliveries) * 100).round(2)
        current_month_deliveries = 25 + (delivery_person.id % 15)
        earnings_this_month = current_month_deliveries * 50
        average_rating = (4.0 + (rand * 1.0)).round(1)
      end

      {
        total_deliveries: total_deliveries,
        completed_deliveries: completed_deliveries,
        pending_deliveries: pending_deliveries,
        success_rate: success_rate,
        deliveries_this_month: current_month_deliveries,
        earnings_this_month: earnings_this_month,
        average_rating: average_rating
      }
    rescue => e
      Rails.logger.error "Delivery statistics calculation error: #{e.message}"
      # Return mock data if there's any error
      {
        total_deliveries: 120,
        completed_deliveries: 102,
        pending_deliveries: 18,
        success_rate: 85.0,
        deliveries_this_month: 20,
        earnings_this_month: 1000,
        average_rating: 4.5
      }
    end
  end

end