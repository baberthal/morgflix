module TVDB
  class SearchResult
    attr_reader :external_id, :language, :name, :overview, :banner,
                :first_aired, :network, :imdb_id, :zap2it_id

    def initialize(options = {})
      @external_id = options['seriesid']
      @language = options['language']
      @name = options['SeriesName']
      @overview = options['Overview']
      @first_aired = options['FirstAired'].to_date
      @network = options['Network']
      @imdb_id = options['IMDB_ID']
      @zap2it_id = options['zap2it_id']
      @banner = options['banner']
    end
  end
end
