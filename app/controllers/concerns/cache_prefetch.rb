# Rails.cache is Solid Cache on the same remote Postgres as the app, so every
# Rails.cache.fetch/read is its own ~60-80ms network round trip. An action that
# reads N cache keys one after another pays N round trips even when all hit.
#
#   prefetch_cache(key_a, key_b, key_c)                  # ONE read_multi round trip
#   @a = prefetched_cache_fetch(key_a, expires_in: 1.minute) { compute_a }
#   @b = prefetched_cache_read(key_b)
#
# prefetched_cache_fetch/read serve prefetched keys from memory; a prefetched
# miss computes and writes like Rails.cache.fetch would. Keys that were never
# prefetched fall through to Rails.cache unchanged.
module CachePrefetch
  extend ActiveSupport::Concern

  private

  def prefetch_cache(*keys)
    @prefetched_cache_keys ||= Set.new
    @prefetched_cache ||= {}
    keys = keys.flatten.map(&:to_s)
    @prefetched_cache.merge!(Rails.cache.read_multi(*keys))
    @prefetched_cache_keys.merge(keys)
  end

  def prefetched_cache_fetch(key, **options)
    key = key.to_s
    return Rails.cache.fetch(key, **options) { yield } unless @prefetched_cache_keys&.include?(key)
    return @prefetched_cache[key] if @prefetched_cache.key?(key)

    @prefetched_cache[key] = yield.tap { |value| Rails.cache.write(key, value, **options) }
  end

  def prefetched_cache_read(key)
    key = key.to_s
    @prefetched_cache_keys&.include?(key) ? @prefetched_cache[key] : Rails.cache.read(key)
  end
end
