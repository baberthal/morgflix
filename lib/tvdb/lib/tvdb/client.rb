module TVDB
  class Client
    attr_reader :base_uri, :base_with_key
    attr_accessor :options

    def initialize(options = {})
      @base_uri = TVDB.xml_mirror(key: false)
      @base_with_key = TVDB.xml_mirror
      @options ||= options
    end

    def search_series(search_query, opts = {})
      opts.merge!(query: { seriesname: search_query })
      _get('GetSeries.php', opts)['Data']['Series']
    end

    private

    def _get(resource, opts = {})
      HTTParty.get("#{base_uri}/#{resource}", opts)
    end
  end
end
