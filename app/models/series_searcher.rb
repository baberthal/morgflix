class SeriesSearcher
  attr_accessor :client
  def initialize
    @client = TVDB::Client.new
  end

  def search(query, options = {})
    @client.search_series(query, options)
  end
end
