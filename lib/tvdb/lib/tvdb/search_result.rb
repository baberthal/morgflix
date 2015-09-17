module TVDB
  class SearchResult
    include ActiveModel::Serialization
    include ActiveModel::Serializers::JSON
    attr_reader :external_id, :language, :name, :overview, :first_banner,
                :first_aired, :network, :imdb_id, :zap2it_id

    def initialize(options = {})
      @external_id = options['seriesid']
      @language = options['language']
      @name = options['SeriesName']
      @overview = options['Overview']
      @first_aired = _first_aired(options)
      @network = options['Network']
      @imdb_id = options['IMDB_ID']
      @zap2it_id = options['zap2it_id']
      _handle_banner(options)
    end

    def banner
      first_banner
    end

    def banner_preview
      "#{TVDB.banner_mirror}/#{first_banner}"
    end

    alias_method :default_banner, :banner

    def attributes
      {
        external_id: nil,
        name: nil,
        default_banner: nil
      }
    end

    def css_id
      name.gsub(/(\(|\))/, '').underscore.tr(' ', '_')
    end

    private

    def _first_aired(options)
      options['FirstAired'] ? options['FirstAired'].to_date : '1-1-1940'.to_date
    end

    def _handle_banner(options)
      @first_banner = options['banner']
      Banner.download(@banner) if @banner
    end
  end
end
