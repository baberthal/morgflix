module TVDB
  module Responses
    class Banner < Abstract
      def initialize(options = {}, series_id = nil)
        super
        _filter_unwanted
        @series_id = series_id
      end

      private

      def _key_crosswalk
        {
          id: :tvdb_banner_id,
          banner_type2: :dimensions
        }
      end

      def _filter_unwanted
        @app_attributes.delete_if { |k, _| _unwanted.include?(k) }
      end

      def _unwanted
        %i(colors series_name)
      end
    end
  end
end
