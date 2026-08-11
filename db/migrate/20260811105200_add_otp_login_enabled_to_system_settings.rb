class AddOtpLoginEnabledToSystemSettings < ActiveRecord::Migration[8.0]
  def change
    add_column :system_settings, :otp_login_enabled, :boolean, default: false
  end
end
