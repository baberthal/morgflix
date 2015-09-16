module TVDB
  module Caching
    def self.included(base)
      base.extend self
    end

    def with_caching(options = {})
      yield Rails.cache.fetch([api_url, options], expires: 3.days)
    end
  end
end
