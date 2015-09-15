require 'spec_helper'

RSpec.describe SeriesScraper, :dummy_tvdb do
  let(:scraper) { described_class.new(110_381) }
  let(:client) { instance_double('TVDB::Client') }
  let(:dummy) { single_response }
  let(:info_dummy) { raw_response }

  before do
    allow(TVDB::Client).to receive(:new).and_return(client)
    allow(client).to receive(:search_series).with(/Archer/, {})
      .and_return dummy
    allow(client).to receive(:series_base_info).with(110_381, {language: :en})
      .and_return info_dummy
  end

  describe '#client' do
    it 'has a client' do
      expect(scraper.client).to be client
    end
  end

  describe '#info' do
    context 'with options' do
      let(:options) { { language: :en } }
      it 'calls #series_base_info on the client' do
        expect(client).to receive(:series_base_info).with(110_381, options)
        scraper.info(options)
      end
    end
  end
end
