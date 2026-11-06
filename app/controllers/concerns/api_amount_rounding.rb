# Rounds every money-like number in an API JSON response to 2 decimals
# (5.549999 -> 5.55, 444.5500001 -> 444.55), applied once at `render json:`
# instead of at each of the hundreds of hand-built `x.to_f` fields.
#
# Types are preserved: Float stays a JSON number, BigDecimal stays whatever
# Rails already emits for it (a string such as "444.55"), and numeric strings
# with more than 2 decimals stay strings.
#
# Values whose key is about something other than money (coordinates,
# quantities, weights, stock levels, dimensions, ratings) are left untouched,
# because e.g. 0.125 kg or a 12.9716 latitude must not be rounded.
module ApiAmountRounding
  extend ActiveSupport::Concern

  NON_AMOUNT_KEY_TOKENS = %w[
    lat lng lon latitude longitude accuracy coordinates location
    quantity quantities qty weight weights stock stocks
    height width length depth size dimension dimensions
    rating ratings version kg kgs gm gms gram grams ml litre litres liter liters
  ].to_set.freeze

  LONG_DECIMAL_STRING = /\A-?\d+\.\d{3,}\z/

  def render(*args, &block)
    options = args.last
    if options.is_a?(Hash) && options.key?(:json) && !options[:json].is_a?(String)
      args = args.dup
      args[-1] = options.merge(json: round_api_amounts(options[:json]))
    end
    super(*args, &block)
  end

  private

  def round_api_amounts(value, key = nil)
    case value
    when Hash
      value.each_with_object({}) { |(k, v), out| out[k] = round_api_amounts(v, k) }
    when Array
      value.map { |v| round_api_amounts(v, key) }
    when ActiveRecord::Relation
      value.to_a.map { |v| round_api_amounts(v, key) }
    when ActiveRecord::Base
      round_api_amounts(value.serializable_hash, key)
    when Float
      value.finite? && amount_key?(key) ? value.round(2) : value
    when BigDecimal
      value.finite? && amount_key?(key) ? value.round(2) : value
    when String
      value.match?(LONG_DECIMAL_STRING) && amount_key?(key) ? BigDecimal(value).round(2).to_s('F') : value
    else
      value
    end
  end

  # A bare number with no key (e.g. a top-level array of numbers) is treated
  # as an amount; otherwise the key must not name a non-money quantity.
  def amount_key?(key)
    return true if key.nil?

    key.to_s.underscore.split(/[^a-z0-9]+/).none? { |token| NON_AMOUNT_KEY_TOKENS.include?(token) }
  end
end
