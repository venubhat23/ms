namespace :customers do
  # One-off after the password_is_default migration:
  #   1. customers with NO login password at all get Customer::DEFAULT_PASSWORD
  #      (customers who set their own password are never touched);
  #   2. password_is_default is backfilled for everyone else (one bcrypt
  #      compare per customer, so it takes a little while on big tables).
  # Safe to re-run.
  desc "Give password-less customers the default password and backfill password_is_default"
  task apply_default_passwords: :environment do
    unless Customer.column_names.include?('password_is_default')
      abort "customers.password_is_default is missing — run the migration first"
    end

    no_password = Customer.where(password_digest: [nil, '']).where(auto_generated_password: [nil, ''])
    assigned = 0
    no_password.find_each do |customer|
      customer.password = Customer::DEFAULT_PASSWORD
      customer.password_confirmation = Customer::DEFAULT_PASSWORD
      customer.auto_generated_password = Customer::DEFAULT_PASSWORD
      if customer.save(validate: false)
        assigned += 1
      else
        puts "  could not update customer ##{customer.id}"
      end
    end

    default_count = 0
    Customer.where.not(password_digest: [nil, '']).find_each do |customer|
      is_default = (BCrypt::Password.new(customer.password_digest).is_password?(Customer::DEFAULT_PASSWORD) rescue false)
      customer.update_columns(password_is_default: is_default) if customer.password_is_default != is_default
      default_count += 1 if is_default
    end

    puts "Set #{Customer::DEFAULT_PASSWORD} for #{assigned} customer(s) that had no password."
    puts "#{default_count} customer(s) now on the default password; the rest keep their own."
  end
end
