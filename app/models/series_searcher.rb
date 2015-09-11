class SeriesSearcher
  attr_accessor :client
  def initialize
    @client = TVDB::Client.new
  end

  def info(query, options = {})
    info = @client.search_series(query, options)
    # TODO: What happens when we have more than one series returned?
    info
  end
end
