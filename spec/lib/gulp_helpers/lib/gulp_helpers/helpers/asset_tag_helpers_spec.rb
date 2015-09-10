require 'rails_helper'
require 'action_view'
require './lib/gulp_helpers/lib/gulp_helpers/helpers/asset_tag_helper'

class AssetTagHelperDummy
end

RSpec.describe GulpHelpers::Helpers::AssetTagHelper do
  let(:dummy) { AssetTagHelperDummy.new }
  before do
    dummy.extend(ActionView::Helpers::TagHelper)
    dummy.extend(ActionView::Helpers::AssetTagHelper)
    dummy.extend(GulpHelpers::Helpers)
    GulpHelpers.config.stylesheet_path = '/stylesheets'
  end

  it 'includes ActionView::Helpers::AssetTagHelper' do
    expect(dummy.javascript_include_tag('application')).to match(/script src/)
  end

  describe 'gulp_stylesheet_link_tag' do
    it 'returns a link tag for the stylesheet specified' do
      expect(dummy.gulp_stylesheet_link_tag('application'))
        .to match(%r{/assets/stylesheets/application})
    end
  end

  describe 'gulp_stylesheet_link_tag' do
    it 'returns a link tag for the javascript file specified' do
      expect(dummy.gulp_javascript_include_tag('app'))
        .to match(%r{/assets/javascripts/app})
    end
  end

  describe 'gulp_stylesheet_link_tag' do
    it 'returns an anchor tag for the image specified' do
      expect(dummy.gulp_image_tag('smiley'))
        .to match(%r{/assets/images/smiley})
    end
  end
end
