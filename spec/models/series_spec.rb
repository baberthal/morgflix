require 'rails_helper'

RSpec.describe Series, type: :model, dummy_tvdb: true do
  describe 'instance methods' do
    describe '#create' do
      let(:series) { build(:series) }
      context 'with valid attributes' do
        it 'is valid' do
          expect(series).to be_valid
        end
      end

      context 'with invalid attributes' do
        before { series.name = nil }
        it 'is invalid' do
          expect(series).to_not be_valid
        end
      end
    end

    describe 'api methods' do
      let(:series) { create(:series) }
      stub_tvdb

      describe '#search_tvdb' do
        context 'when there is only one result' do
          it 'calls the search_series method on TVDB' do
            expect(TVDB).to receive(:series_search).with(/Archer/, {})
            described_class.search_tvdb('Archer')
          end
        end
      end
    end

    describe 'class methods' do
      describe '#base_dir' do
        it 'returns the base directory for Series' do
          expect(described_class.base_dir).to be_a Pathname
        end
      end

      describe '#base_dir=' do
        it 'sets the base directory for Series' do
          described_class.base_dir = 'media', 'shows'
          expect(described_class.base_dir.to_s).to match(%r{media/shows})
        end
      end
    end
  end
end
