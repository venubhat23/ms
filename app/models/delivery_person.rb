class DeliveryPerson < ApplicationRecord
  has_one_attached :profile_picture
  has_one_attached :license_document
  has_one_attached :vehicle_document
  has_many :bookings, dependent: :nullify
  has_many :milk_delivery_tasks, dependent: :nullify

  # Password authentication
  has_secure_password

  # Define enum first (Rails 7 syntax)
  enum :vehicle_type, { bike: 0, scooter: 1, car: 2, truck: 3, van: 4 }

  validates :first_name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :mobile, presence: true, uniqueness: true
  validate :mobile_number_format
  validates :vehicle_type, presence: true
  validates :vehicle_number, presence: true, uniqueness: { case_sensitive: false }
  validates :license_number, presence: true, uniqueness: { case_sensitive: false }
  validates :address, presence: true, length: { minimum: 10 }
  validates :city, presence: true
  validates :state, presence: true
  validates :pincode, presence: true, format: { with: /\A[0-9]{6}\z/, message: "must be a 6-digit number" }
  validates :emergency_contact_name, presence: true
  validates :emergency_contact_mobile, presence: true
  validate :emergency_contact_mobile_format
  validates :joining_date, presence: true
  validates :salary, presence: true, numericality: { greater_than: 0 }

  scope :active, -> { where(status: true) }
  scope :inactive, -> { where(status: false) }
  scope :by_vehicle_type, ->(type) { where(vehicle_type: type) }
  scope :by_city, ->(city) { where(city: city) }
  scope :search, ->(query) { where('first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ? OR mobile ILIKE ? OR vehicle_number ILIKE ?', "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%") }
  scope :recent, -> { order(created_at: :desc) }

  before_validation :normalize_attributes
  before_validation :set_default_status, if: :new_record?
  before_validation :generate_password, if: :new_record?

  def full_name
    "#{first_name} #{last_name}"
  end

  def display_name
    full_name
  end

  def active?
    status
  end

  def delivery_area_list
    return [] if delivery_areas.blank?
    delivery_areas.split(',').map(&:strip).reject(&:blank?)
  end

  def delivery_area_list=(areas)
    self.delivery_areas = areas.reject(&:blank?).join(', ')
  end

  def vehicle_info
    "#{vehicle_type&.humanize || 'N/A'} - #{vehicle_number}"
  end

  def contact_info
    "#{mobile} | #{email}"
  end

  def formatted_salary
    "₹#{salary&.to_i&.to_s&.reverse&.gsub(/(\d{3})(?=\d)/, '\\1,')&.reverse}"
  end

  def status_badge_class
    active? ? 'success' : 'secondary'
  end

  def status_text
    active? ? 'Active' : 'Inactive'
  end

  def years_of_service
    return 0 unless joining_date
    ((Date.current - joining_date) / 365.25).to_i
  end

  private

  def normalize_attributes
    self.email = email&.downcase&.strip
    self.mobile = normalize_mobile_number(mobile)
    self.emergency_contact_mobile = normalize_mobile_number(emergency_contact_mobile)
    self.vehicle_number = vehicle_number&.upcase&.strip
    self.license_number = license_number&.upcase&.strip
    self.first_name = first_name&.strip&.titleize
    self.last_name = last_name&.strip&.titleize
    self.city = city&.strip&.titleize
    self.state = state&.strip&.titleize
  end

  def set_default_status
    self.status = true if status.nil?
  end

  DEFAULT_PASSWORD = "ms@123"

  def generate_password
    return if password.present?

    self.auto_generated_password = DEFAULT_PASSWORD
    self.password = DEFAULT_PASSWORD
    self.password_confirmation = DEFAULT_PASSWORD
  end

  def mobile_number_format
    return if mobile.blank?

    unless mobile.match?(/\A\d{10}\z/)
      errors.add(:mobile, 'must be exactly 10 digits')
    end
  end

  def emergency_contact_mobile_format
    return if emergency_contact_mobile.blank?

    unless emergency_contact_mobile.match?(/\A\d{10}\z/)
      errors.add(:emergency_contact_mobile, 'must be exactly 10 digits')
    end
  end

  # Strips a leading "91" country code so mobile is always stored as a bare
  # 10-digit number — same normalization Customer#normalize_indian_mobile
  # uses. Storing "917975918232" instead of "7975918232" is what broke
  # mobile-number login for delivery people (Api::V1::Mobile::
  # AuthenticationController#find_by_mobile_variants never generated that
  # exact bare-91-prefix format as a candidate).
  def normalize_mobile_number(number)
    return nil if number.blank?

    cleaned = number.to_s.gsub(/\D/, '')
    cleaned = cleaned[2..-1] if cleaned.length == 12 && cleaned.start_with?('91')
    cleaned = cleaned[2..-1] if cleaned.length == 11 && cleaned.start_with?('91')
    cleaned
  end
end
