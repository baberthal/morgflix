require 'rails_helper'

RSpec.describe SecretController, :devise, type: :controller do
  describe 'GET #index' do
    login_user

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
end
