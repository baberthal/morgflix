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

    describe '#search' do
      context 'when there is only one result' do
        let(:series) { create(:series) }
        let(:search_results) { single_response }
        let(:archer_info) { dummy_info_response }
        let(:searcher) { instance_double('SeriesSearcher') }
        let(:scraper) { instance_double('SeriesScraper') }

        before do
          allow(SeriesSearcher).to receive(:new).and_return searcher
          allow(SeriesScraper).to receive(:new).and_return scraper
          allow(searcher).to receive(:search).and_return search_results
          allow(scraper).to receive(:info).and_return archer_info
        end

        it 'calls the search method on searcher' do
          expect(searcher).to receive(:search).with(/Archer/, {})
          series.search
        end

        it 'updates itself' do
          series.search
          series.reload
          expect(series.network).to eq 'FXX'
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
