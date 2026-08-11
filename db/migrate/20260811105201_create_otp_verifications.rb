class CreateOtpVerifications < ActiveRecord::Migration[8.0]
  def change
    create_table :otp_verifications do |t|
      t.string   :mobile, null: false
      t.string   :otp_digest, null: false
      t.string   :purpose, null: false, default: 'login'
      t.integer  :attempts, null: false, default: 0
      t.datetime :expires_at, null: false
      t.datetime :verified_at
      t.string   :request_ip

      t.timestamps
    end

    add_index :otp_verifications, [:mobile, :created_at]
  end
end
