class BookingDiscount < ApplicationRecord
  SOURCES = %w[manual franchise coupon].freeze
  TYPES = %w[fixed percentage].freeze

  belongs_to :booking
  belongs_to :coupon, optional: true

  validates :source, inclusion: { in: SOURCES }
  validates :discount_type, inclusion: { in: TYPES }
  validates :value, numericality: { greater_than_or_equal_to: 0 }
  validates :computed_amount, numericality: { greater_than_or_equal_to: 0 }
end
