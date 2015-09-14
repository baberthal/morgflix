require 'rails_helper'

RSpec.feature 'AddingSeries', :dummy_tvdb, type: :feature do
  let(:user) { create(:user) }

  it 'adds a series' do
    login_as(user, scope: :user)
    visit '/'
    click_on 'new_series'
  end
end
