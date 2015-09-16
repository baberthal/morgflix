module DummyTVDB
  class << self
    attr_reader :responder

    def included(base)
      base.extend GroupMethods
    end

    def responder
      @responder ||= DummyTVDB::Responder.new
    end
  end

  class Responder
    attr_reader :series, :actors, :banners, :search, :raw_search
    def initialize
      @series = read_xml('en')
      @actors = read_xml('actors')
      @banners = read_xml('banners')
      @raw_search = read_xml('search_results')
      @search = @raw_search['Data']['Series']
    end

    def full
      {
        'en' => series,
        'actors' => actors,
        'banners' => banners
      }
    end

    def read_xml(file)
      MultiXml.parse(
        File.read(
          Rails.root.join("spec/support/tvdb/#{file}.xml")
        )
      )
    end
  end

  module GroupMethods
    def stub_tvdb
      stub_series_search
      stub_basic_search
      stub_banner_download
    end

    def stub_series_search
      before do
        allow(TVDB::SeriesSearch).to receive(:response)
          .and_return DummyTVDB.responder.full
      end
    end

    def stub_basic_search
      before do
        allow(TVDB::BasicSearch).to receive(:response)
          .and_return DummyTVDB.responder.search
      end
    end

    def stub_banner_download
      before do
        allow(TVDB::Banner).to receive(:download).and_return true
      end
    end
  end
end
