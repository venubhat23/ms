#!/usr/bin/env ruby

puts '🔧 ADDING REFERRALS PERMISSION TO ADMIN'
puts '=' * 50

email = 'admin@atmanirbharfarm.com'
user = User.find_by(email: email)

if user
  # Parse existing permissions
  current_permissions = JSON.parse(user.sidebar_permissions || '{}')

  # Add referrals permission
  current_permissions['referrals'] = {
    'view' => true,
    'create' => true,
    'edit' => true,
    'delete' => true
  }

  # Update user permissions
  user.update!(sidebar_permissions: current_permissions.to_json)

  puts "✅ Added referrals permission to admin user"
  puts "   Total permissions: #{current_permissions.keys.count}"

  # Verify the permission was added
  if user.has_sidebar_permission?('referrals')
    puts "✅ Verification: Referrals permission is now active"
    puts "   🎯 Admin should now see Referrals section in sidebar"
    puts ""
    puts "🚀 Please refresh your browser and login again to see the changes"
  else
    puts "❌ Verification failed: Permission not properly set"
  end

else
  puts "❌ Admin user not found"
  puts "Available admin users:"
  User.where(user_type: 'admin').each do |u|
    puts "   - #{u.email}"
  end
end