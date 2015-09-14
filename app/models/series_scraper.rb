class SeriesScraper
  attr_accessor :client, :series_id
  def initialize(series_id)
    @client = TVDB::Client.new
    @series_id = series_id
  end

  def info(options = {})
    lang = options[:language] || :en
    @client.series_base_info(@series_id, options)[lang]['Data']['Series']
  end
end
