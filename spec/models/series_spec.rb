require 'rails_helper'

RSpec.describe Series, type: :model do
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
