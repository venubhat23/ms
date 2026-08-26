class StaffMember < ApplicationRecord
  belongs_to :store
  has_many :staff_attendances, dependent: :destroy
  has_many :staff_payments, dependent: :destroy

  STATUSES = %w[active inactive].freeze

  validates :name, presence: true
  validates :monthly_salary, numericality: { greater_than_or_equal_to: 0 }
  validates :status, inclusion: { in: STATUSES }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true

  scope :active, -> { where(status: 'active') }
  scope :inactive, -> { where(status: 'inactive') }

  def active?
    status == 'active'
  end

  # Memoized per (month, year) so the index/show views can call paid_for and
  # pending_for (which itself calls paid_for) on the same record without each
  # call re-hitting the DB. #preload_paid_for lets a controller seed this from
  # one batched query instead of one query per record.
  def paid_for(month, year)
    @paid_for_cache ||= {}
    @paid_for_cache[[month, year]] ||= staff_payments.where(month: month, year: year).sum(:amount)
  end

  def preload_paid_for(month, year, amount)
    @paid_for_cache ||= {}
    @paid_for_cache[[month, year]] = amount
  end

  def pending_for(month, year)
    [monthly_salary.to_f - paid_for(month, year).to_f, 0].max
  end

  # Memoized like paid_for/preload_paid_for above, so the index page can
  # batch-preload "already marked today?" for every listed staff member in
  # one query instead of one per row.
  def todays_attendance
    defined?(@todays_attendance) ? @todays_attendance : staff_attendances.find_by(attendance_date: Date.current)
  end

  def preload_todays_attendance(attendance)
    @todays_attendance = attendance
  end

  def attendance_summary_for(month, year)
    counts = staff_attendances
             .where(attendance_date: Date.new(year, month, 1)..Date.new(year, month, -1))
             .group(:status).count
    {
      'present'  => counts['present'] || 0,
      'absent'   => counts['absent'] || 0,
      'half_day' => counts['half_day'] || 0,
      'leave'    => counts['leave'] || 0
    }
  end
end
