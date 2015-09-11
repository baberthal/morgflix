require 'rails_helper'

RSpec.describe SeriesSearcher, :dummy_tvdb do
  let(:client) { instance_double('TVDB::Client') }
  let(:searcher) { described_class.new }
  let(:dummy) { dummy_archer_response }

  before do
    allow(TVDB::Client).to receive(:new).and_return(client)
    allow(client).to receive(:search_series).with(/Archer/, {}).and_return dummy
  end

  describe '#new' do
    it 'initializes with a client' do
      expect(searcher.client).to be client
    end
  end

  describe '#client' do
    it 'has a client' do
      expect(searcher.client).to be client
    end
  end

  describe '#client=' do
    it 'can set the client' do
      expect { searcher.client = 7 }.to change(searcher, :client)
    end
  end

  describe '#info' do
    it 'queries client for the term provided' do
      expect(searcher.info('Archer (2009)')).to eq dummy
      expect(client).to receive(:search_series)
      searcher.info('Archer (2009)')
    end
  end
end
