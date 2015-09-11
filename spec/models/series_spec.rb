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

    describe '#fetch_info' do
      let(:archer_info) { dummy_archer_response }
      let(:scraper) { instance_double('SeriesSearcher') }
      let(:series) { create(:series, name: 'Archer (2009)') }

      before do
        allow(SeriesSearcher).to receive(:new).and_return scraper
        allow(scraper).to receive(:info).and_return archer_info
      end

      it 'calls the info method on scraper' do
        expect(scraper).to receive(:info).with('Archer (2009)', {})
        series.fetch_info
      end

      it 'updates itself' do
        series.reload
        expect(series.external_id).to eq 110_381
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
