require 'rails_helper'

RSpec.describe Banner, type: :model do
  let(:banner) { build(:banner) }
  it 'is valid with valid attributes' do
    expect(banner).to be_valid
  end

  it 'is invalid without valid attributes' do
    banner.series = nil
    expect(banner).to_not be_valid
  end
end
