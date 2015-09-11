require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  before :each do
    GulpHelpers.configure do |config|
      config.stylesheet_path = 'whatever/stylesheets'
    end
  end

  after :each do
    GulpHelpers.configure do |config|
      config.stylesheet_path = '/stylesheets'
    end
  end

  describe '#gulp_stylesheet_link_tag' do
    it 'returns a link tag for the stylesheet specified' do
      expect(helper.gulp_stylesheet_link_tag('application'))
        .to match(%r{/assets/whatever/stylesheets/application})
    end
  end

  describe '#gulp_stylesheet_link_tag' do
    it 'returns a link tag for the javascript file specified' do
      expect(helper.gulp_javascript_include_tag('app'))
        .to match(%r{/assets/javascripts/app})
    end
  end

  describe '#gulp_stylesheet_link_tag' do
    it 'returns an anchor tag for the image specified' do
      expect(helper.gulp_image_tag('smiley'))
        .to match(%r{/assets/images/smiley})
    end
  end

  describe '#bootstrap_class_for' do
    let(:expected) do
      {
        success: 'alert-success',
        error: 'alert-danger',
        alert: 'alert-warning',
        notice: 'alert-info',
        danger: 'alert-danger'
      }
    end

    it 'returns the proper class given the flash_type' do
      expected.each do |k, v|
        expect(helper.bootstrap_class_for(k)).to eq v
      end
    end
  end
end
