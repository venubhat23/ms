class OtpVerification < ApplicationRecord
  OTP_LENGTH = 6
  OTP_TTL = 5.minutes
  MAX_VERIFY_ATTEMPTS = 5
  RESEND_COOLDOWN = 60.seconds
  MAX_REQUESTS_PER_HOUR = 5

  validates :mobile, presence: true
  validates :otp_digest, presence: true
  validates :purpose, presence: true

  scope :for_mobile, ->(mobile) { where(mobile: mobile) }
  scope :active, -> { where(verified_at: nil).where('expires_at > ?', Time.current) }

  def self.digest(otp_code)
    Digest::SHA256.hexdigest("#{otp_code}:#{Rails.application.secret_key_base}")
  end

  # Returns [:ok] or [:rate_limited, retry_after_seconds]
  def self.rate_limit_status(mobile)
    last = for_mobile(mobile).order(created_at: :desc).first
    if last && last.created_at > RESEND_COOLDOWN.ago
      return [:cooldown, (RESEND_COOLDOWN - (Time.current - last.created_at)).ceil]
    end

    recent_count = for_mobile(mobile).where('created_at > ?', 1.hour.ago).count
    return [:hourly_limit, 1.hour.to_i] if recent_count >= MAX_REQUESTS_PER_HOUR

    [:ok, 0]
  end

  # Generates and persists a new OTP, invalidating any still-active ones for
  # this mobile/purpose so only the most recent code can ever verify.
  def self.generate!(mobile, purpose: 'login', request_ip: nil)
    for_mobile(mobile).where(purpose: purpose).active.update_all(expires_at: Time.current)

    otp_code = SecureRandom.random_number(10**OTP_LENGTH).to_s.rjust(OTP_LENGTH, '0')
    record = create!(
      mobile: mobile,
      purpose: purpose,
      otp_digest: digest(otp_code),
      expires_at: OTP_TTL.from_now,
      request_ip: request_ip
    )
    [record, otp_code]
  end

  # Returns :verified, :invalid, :expired, or :too_many_attempts
  def self.verify(mobile, otp_code, purpose: 'login')
    record = for_mobile(mobile).where(purpose: purpose).active.order(created_at: :desc).first
    return :invalid if record.nil?
    return :too_many_attempts if record.attempts >= MAX_VERIFY_ATTEMPTS

    if record.expires_at < Time.current
      return :expired
    end

    if ActiveSupport::SecurityUtils.secure_compare(record.otp_digest, digest(otp_code))
      record.update!(verified_at: Time.current)
      :verified
    else
      record.increment!(:attempts)
      record.attempts >= MAX_VERIFY_ATTEMPTS ? :too_many_attempts : :invalid
    end
  end
end
