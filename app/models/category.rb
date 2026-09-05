class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :display_order, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # Store image URL as backup when image is attached
  after_commit :backup_image_url, if: :saved_change_to_id?
  after_commit :bust_mobile_api_cache

  def bust_mobile_api_cache
    MobileApiCache.bust_categories!
  end

  scope :active, -> { where(status: true) }
  scope :inactive, -> { where(status: false) }
  scope :ordered, -> { order(:display_order, :name) }

  # Same "sold" statuses as Product#total_sold_quantity, so a category only
  # counts revenue from bookings that actually went through.
  SOLD_STATUSES = %w[confirmed processing packed shipped out_for_delivery delivered completed].freeze

  scope :ranked_by_sales, -> {
    left_joins(products: { booking_items: :booking })
      .where(bookings: { status: SOLD_STATUSES })
      .group('categories.id')
      .order(Arel.sql('COALESCE(SUM(booking_items.quantity * booking_items.price), 0) DESC'))
  }

  # Best-selling active category by revenue, for the storefront's "top
  # category" banner. Falls back to the first active category by
  # display_order when there's no sales data yet (new store).
  def self.top_selling
    active.ranked_by_sales.first || active.ordered.first
  end

  before_validation :set_default_display_order, if: :new_record?

  def active?
    status?
  end

  def inactive?
    !status?
  end

  def products_count
    products.loaded? ? products.size : products.count
  end

  def self.for_select
    ordered.pluck(:name, :id)
  end

  def display_image_url
    if image.attached?
      Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true)
    else
      ActionController::Base.helpers.asset_path("category-placeholder.png")
    end
  end

  def has_image?
    image.attached?
  end

  ICON_GRADIENTS = [
    %w[#56CCF2 #2F80ED],
    %w[#F2994A #F2C94C],
    %w[#6FCF97 #219653],
    %w[#BB6BD9 #8E44AD],
    %w[#F06292 #EC407A],
    %w[#4FD1C5 #319795],
    %w[#FFD166 #FB8B24],
    %w[#EF5350 #E53935],
    %w[#26C6DA #00838F],
    %w[#9575CD #5E35B1]
  ].freeze

  ICON_KEYWORDS = {
    /dairy|milk/i          => 'bi-cup-fill',
    /grain|millet|rice|wheat|flour/i => 'bi-basket3-fill',
    /sweet|honey|jaggery|sugar/i     => 'bi-droplet-fill',
    /oil/i                 => 'bi-droplet-half',
    /drink|juice|beverage/i => 'bi-cup-hot-fill',
    /snack/i               => 'bi-bag-fill',
    /spice|masala/i        => 'bi-fire',
    /vegetable|veggie/i    => 'bi-flower1',
    /fruit/i               => 'bi-apple',
    /pulse|dal|lentil/i    => 'bi-circle-half'
  }.freeze

  # A distinctive Bootstrap icon for this category's circle badge, chosen by
  # keyword match on the name so it stays sensible for categories admins add
  # later without needing a dedicated icon field.
  def icon_class
    _, icon = ICON_KEYWORDS.find { |pattern, _| name.to_s.match?(pattern) }
    icon || 'bi-tag-fill'
  end

  # Deterministic (per category id) gradient pair for the icon badge, so
  # each category gets a stable, visually distinct color.
  def gradient_colors
    ICON_GRADIENTS[id.to_i % ICON_GRADIENTS.length]
  end

  def gradient_style
    start_color, end_color = gradient_colors
    "background: linear-gradient(135deg, #{start_color}, #{end_color});"
  end

  private

  def set_default_display_order
    max_order = Category.maximum(:display_order) || 0
    self.display_order ||= max_order + 1
  end

  def backup_image_url
    if image.attached?
      update_column(:image_backup_url, display_image_url)
    end
  rescue => e
    Rails.logger.error "Failed to backup image URL for category #{id}: #{e.message}"
  end
end