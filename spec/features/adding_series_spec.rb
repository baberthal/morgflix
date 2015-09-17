require 'rails_helper'

RSpec.feature 'Adding Series', :dummy_tvdb, type: :feature, js: true do
  stub_tvdb
  let(:user) { create(:user) }

  background do
    login_as(user, scope: :user)
    visit '/'
    click_on 'new_series'
    fill_in 'q', with: 'Archer'
    click_on 'search_button'
  end

  scenario 'searching for a series' do
    expect(page).to have_content 'Archer (2009)'
  end

  scenario 'adding a series' do
    click_link 'archer_2009'
    expect(page).to have_content 'successfully created'
  end
end
