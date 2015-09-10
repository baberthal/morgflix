require 'rails_helper'
require './lib/gulp_helpers/lib/gulp_helpers'

RSpec.describe GulpHelpers do
  describe '#asset_path' do
    it 'can get and set the asset path' do
      described_class.config
      described_class.asset_path = 'public/assets'
      expect(described_class.asset_path).to eq 'public/assets'
    end
  end
end
