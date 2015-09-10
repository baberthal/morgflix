require 'rails_helper'
require './lib/gulp_helpers/lib/gulp_helpers'

RSpec.describe GulpHelpers do
  describe '#asset_path' do
    it 'can get and set the asset path' do
      GulpHelpers.config
      GulpHelpers.asset_path = 'public/assets'
      expect(GulpHelpers.asset_path).to eq 'public/assets'
    end
  end
end
