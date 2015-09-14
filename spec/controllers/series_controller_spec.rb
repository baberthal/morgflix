require 'rails_helper'

RSpec.describe SeriesController, :devise, :dummy_tvdb, type: :controller do
  context 'when a user is logged in' do
    login_user
    let(:searcher) { instance_double('SeriesSearcher') }
    let(:scraper) { instance_double('SeriesScraper') }
    let(:archer_info) { dummy_info_response }
    let(:search_results) { dummy_search_response }

    before do
      allow(SeriesSearcher).to receive(:new).and_return searcher
      allow(SeriesScraper).to receive(:new).and_return scraper
      allow(searcher).to receive(:search).and_return search_results
      allow(scraper).to receive(:info).and_return archer_info
    end

    let(:invalid_attributes) { { name: nil } }

    describe 'GET' do
      let(:series) { create(:series) }
      describe '#index' do
        it 'assigns all series as @series' do
          get :index
          expect(assigns(:series)).to eq([series])
        end
      end

      describe '#show' do
        it 'assigns the requested series as @series' do
          get :show, id: series.to_param
          expect(assigns(:series)).to eq(series)
        end
      end

      describe '#new' do
        it 'assigns a new series as @series' do
          get :new
          expect(assigns(:series)).to be_a_new(Series)
        end
      end

      describe '#edit' do
        it 'assigns the requested series as @series' do
          get :edit, id: series.to_param
          expect(assigns(:series)).to eq(series)
        end
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        it 'creates a new Series' do
          expect do
            post :create, series: attributes_for(:series)
          end.to change(Series, :count).by(1)
        end

        it 'assigns a newly created series as @series' do
          post :create, series: attributes_for(:series)
          expect(assigns(:series)).to be_a(Series)
          expect(assigns(:series)).to be_persisted
        end

        it 'redirects to the created series' do
          post :create, series: attributes_for(:series)
          expect(response).to redirect_to(Series.last)
        end
      end

      context 'with invalid params' do
        it 'assigns a newly created but unsaved series as @series' do
          post :create, series: invalid_attributes
          expect(assigns(:series)).to be_a_new(Series)
        end

        it "re-renders the 'new' template" do
          post :create, series: invalid_attributes
          expect(response).to render_template('new')
        end
      end
    end

    describe 'PUT #update' do
      let(:series) { create(:series) }
      context 'with valid params' do
        let(:new_attributes) { { name: 'The Brink' } }

        before :each do
          put :update, id: series.to_param, series: new_attributes
        end

        it 'updates the requested series' do
          series.reload
          expect(series.name).to eq 'The Brink'
        end

        it 'assigns the requested series as @series' do
          expect(assigns(:series)).to eq(series)
        end

        it 'redirects to the series' do
          expect(response).to redirect_to(series)
        end
      end

      context 'with invalid params' do
        it 'assigns the series as @series' do
          put :update, id: series.to_param, series: invalid_attributes
          expect(assigns(:series)).to eq(series)
        end

        it "re-renders the 'edit' template" do
          put :update, id: series.to_param, series: invalid_attributes
          expect(response).to render_template('edit')
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys the requested series' do
        series = create(:series)
        expect do
          delete :destroy, id: series.to_param
        end.to change(Series, :count).by(-1)
      end

      it 'redirects to the series list' do
        series = create(:series)
        delete :destroy, id: series.to_param
        expect(response).to redirect_to(series_index_url)
      end
    end
  end
end
