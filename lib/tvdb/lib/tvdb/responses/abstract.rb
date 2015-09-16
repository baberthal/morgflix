module TVDB
  module Responses
    class MalformedResponseError < StandardError
      def initialize(msg = 'The response was malformed. Please try again.')
        super(msg)
      end
    end

    class Abstract
      class << self
        def multi_new(arg_hashes, series_id = nil)
          arg_hashes.map { |res| new(res, series_id) }
        end
      end

      attr_reader :options, :series_id, :app_attributes

      def initialize(options = {}, series_id = nil)
        fail MalformedResponseError if options.empty?
        @options = options
        @series_id = series_id
        @app_attributes = _transform_keys(@options)
      end

      private

      def _transform_keys(hash)
        hash.transform_keys do |k|
          _key_crosswalk.fetch(k.underscore.to_sym, k.underscore.to_sym)
        end
      end
    end
  end
end
