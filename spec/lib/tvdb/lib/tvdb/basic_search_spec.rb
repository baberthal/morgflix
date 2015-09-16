require 'rails_helper'

RSpec.describe TVDB::BasicSearch, :dummy_tvdb do
  describe 'class methods' do
    describe '#response' do
      context 'when the search is valid' do
        context 'and it returns many responses' do
          let(:search_term) { 'Archer' }
          it 'returns an array of options' do
            expect(described_class.response(search_term)).to be_an Array
          end
        end

        context 'and it returns one response' do
          let(:search_term) { 'Archer (2009)' }
          it 'returns an array still' do
            expect(described_class.response(search_term)).to be_an Array
          end
        end
      end

      context 'when the search is invalid' do
        let(:search_term) { '123589782' }
        it 'returns an empty array' do
          expect(described_class.response(search_term)).to eq []
        end
      end
    end
  end
end
