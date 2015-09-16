require_relative 'search_result'
require_relative 'caching'

module TVDB
  class BasicSearch
    include Caching
    class << self
      def api_url
        "#{TVDB.xml_mirror(key: false)}/GetSeries.php"
      end

      def response(series_name, opts = {})
        opts.merge!(query: { seriesname: series_name })
        with_caching(opts) do
          res = HTTParty.get(api_url, opts)
          _guard_response(res) if res.success?
        end
      end

      def parsed_response(series_name, opts = {})
        return _parse_response(response(series_name, opts)) unless _sort?(opts)
        sort_by = opts.delete(:sort_by)
        order = opts.delete(:order)
        _parse_response(response(series_name, opts)) do |results|
          results.sort_by!(&sort_by)
          results.reverse! if order == :desc
        end
      end

      private

      def _parse_response(response)
        return nil if response.empty?
        res = []
        response.each do |result|
          res.push(TVDB::SearchResult.new(result))
        end
        yield res if block_given?
        res
      end

      def _sort?(opts = {})
        opts[:sort_by] || opts[:order]
      end

      def _guard_response(response)
        return [] unless response['Data']
        case response['Data']['Series']
        when Array
          response['Data']['Series']
        when Hash
          [response['Data']['Series']]
        else
          []
        end
      end
    end
  end
end
