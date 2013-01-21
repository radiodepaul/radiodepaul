require 'active_support/core_ext/class'
require 'json_tools/model_cache_key'

# The most expensive part of serving a JSON request is converting the
# serialized records into JSON. Perforated cache handles the messy task of
# storing and retrieving all JSON for a particular set of models as
# effeciently as possible. It achieves this several ways:
#
# 1. Storing final json output, not marshalled objects
# 2. Retrieving the json for as many objects at once as is possible, and then
#    filling in the remaining json as if it was always there. This is where
#    the term 'perforated' comes from.
# 3. Embedding the requesting scope's role in the cache key. This ensures that
#    the same cached json won't be served to scopes with a different role.
module JSONTools
  class PerforatedCache
    cattr_writer :cache
    attr_reader :model_cache_keys

    def self.cache
      @@cache ||= Rails.cache
    end

    def initialize(models, scope)
      @model_cache_keys = models.map { |model|
        ModelCacheKey.new(model, scope)
      }
    end

    def cache
      self.class.cache
    end

    def to_json
      perforated_json = get_cached_values
      complete_json = fill_in_missing_cache(perforated_json)

      values_to_json_array(complete_json.values)
    end

    def fill_in_missing_cache(cached_json_hash)
      model_cache_keys.each do |model_cache_key|
        key = model_cache_key.key

        unless cached_json_hash.keys.include?(key)
          json = serialized_json(model_cache_key.model)

          cached_json_hash[key] = json
          cache.write(key, json)
        end
      end

      cached_json_hash
    end

    private

    def get_cached_values
      cache.read_multi(model_cache_keys.map(&:key))
    end

    def serialized_json(model)
      model.as_json.to_json
    end

    def values_to_json_array(values)
      "[#{values.join(',')}]"
    end
  end
end
