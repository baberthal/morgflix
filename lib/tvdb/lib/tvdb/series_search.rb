require 'fileutils'
require 'tmpdir'
require_relative 'zip_downloader'
require_relative 'responses'

module TVDB
  class SeriesSearch
    include Caching
    class << self
      def response(series_id, options = {})
        options[:language] ||= 'en'
        ZipDownloader.download(series_id, options)
      end

      def parsed_response(series_id, options = {})
        lang = options[:language] || 'en'
        res = response(series_id, options)
        [Responses::FullSeries.new(_guard_response(:series, res[lang])),
         Responses::Banner.multi_new(_guard_response(:banners, res['banners']),
                                     series_id),
         Responses::Actor.multi_new(_guard_response(:actors, res['actors']),
                                    series_id)]
      end

      private

      def _guard_response(response_type, response)
        case response_type
        when :series
          response['Data']['Series'] unless response['Data']['Series'].nil?
        when :banners
          _guard_banners_response(response)
        when :actors
          _guard_actors_response(response)
        else
          []
        end
      end

      def _guard_banners_response(response)
        return [] unless response['Banners'] && response['Banners']['Banner']
        case response['Banners']['Banner']
        when Array
          response['Banners']['Banner']
        when Hash
          [response['Banners']['Banner']]
        else
          []
        end
      end

      def _guard_actors_response(response)
        return nil unless response['Actors'] && response['Actors']['Actor']
        response['Actors']['Actor']
      end
    end
  end
end
