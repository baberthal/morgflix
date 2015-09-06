module TVDB
  class Client
    include HTTParty
    base_uri TVDB.xml_mirror

    def initialize(service, page)
      @options = { query: { site: service, page: page } }
    end
  end
end
