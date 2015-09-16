module TVDB
  module Responses
    class FullSeries < Abstract
      attr_reader :raw_info, :app_attributes

      def initialize(opts = {})
        super
        _typeify_keys
        _filter_unwanted
      end

      def _typeify_keys
        @app_attributes.tap do |attrs|
          attrs[:genres] = attrs[:genres].split('|').delete_if(&:empty?)
        end
      end

      def _key_crosswalk
        { id: :external_id,
          airs_day_of_week: :air_day_of_week,
          airs_time: :air_time,
          series_id: :tvdb_series_id,
          series_name: :name,
          tvdb_last_update: :lastupdated,
          tms_wanted_old: :tvdb_tms_wanted_old,
          genre: :genres,
          lastupdated: :tvdb_last_update }
      end

      def _filter_unwanted
        @app_attributes.delete_if { |k, _| _unwanted.include?(k) }
      end

      def _unwanted
        %i(actors banner fanart poster network_id)
      end
    end
  end
end
