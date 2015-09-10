require 'rails_helper'
require './lib/tvdb/lib/tvdb'

RSpec.describe TVDB::Client do
  let(:client) { described_class.new }

  describe 'retrieving info' do
    describe '#search_series' do
      it 'returns an array of series' do
        expect(client.search_series('Archer')).to be_an Array
      end

      it 'returns the proper results' do
        expect(client.search_series('Archer').length).to eq 3
      end
    end
  end
end
