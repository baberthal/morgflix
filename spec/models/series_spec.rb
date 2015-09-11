require 'rails_helper'

RSpec.describe Series, type: :model do
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
      let(:scraper) { instance_double("SeriesSearcher") }
      let(:series) { create(:series, name: 'Archer (2009)') }
      let(:archer_info) do
        {
          'seriesid'=>'110381',
          'language'=>'en',
          'SeriesName'=>'Archer (2009)',
          'banner'=>'graphical/110381-g8.jpg',
          'Overview'=> 'At ISIS, an international spy agency, global crises are merely opportunities for its highly trained employees to confuse, undermine, betray and royally screw each other. At the center of it all is suave master spy Sterling Archer, whose less-than-masculine code name is Duchess. Archer works with his domineering mother Malory, who is also his boss. Drama revolves around Archers ex-girlfriend, Agent Lana Kane and her new boyfriend, ISIS comptroller Cyril Figgis, as well as Malorys lovesick secretary, Cheryl.',
          'FirstAired'=>'2009-09-17',
          'Network'=>'FXX',
          'IMDB_ID'=>'tt1486217',
          'zap2it_id'=>'EP01216702'
        }
      end

      before :all do
        allow(SeriesSearcher).to receive(:new).and_return scraper
        allow(scraper).to receive(:info).with('Archer (2009)')
          .and_return archer_info
      end

      it 'calls the info method on scraper' do
        expect(scraper).to receive(:info).with('Archer (2009)')
        series.fetch_info
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
