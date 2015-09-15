require 'rails_helper'

RSpec.describe SecretController, :devise, :dummy_tvdb, type: :controller do
  login_user
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    describe 'recently aired' do
      before :each do
        create(:series)
        get :index
      end

      it 'assigns series to the most recent series' do
        expect(assigns(:series)).to eq [Series.last]
      end

      it 'assigns selected to the single most recent' do
        expect(assigns(:selected)).to eq Series.last
      end
    end
  end

  describe '#search' do
    let(:searcher) { instance_double('SeriesSearcher') }
    let(:response) { dummy_search_response }

    before :each do
      allow(SeriesSearcher).to receive(:new).and_return searcher
      allow(searcher).to receive(:search).and_return response
    end

    it 'returns the search results for the given query' do
      get :search, q: 'Archer'
      expect(assigns(:results)).to eq response
    end
  end
end
