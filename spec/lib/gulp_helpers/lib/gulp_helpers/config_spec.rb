require 'rails_helper'
require './lib/gulp_helpers/lib/gulp_helpers'

RSpec.describe GulpHelpers::Config do
  let(:config_obj) { described_class.new }

  describe '#stylesheet_path=' do
    before :each do
      config_obj.stylesheet_path = '/whatever/stylesheets'
    end

    it 'sets a new stylesheet path' do
      expect(config_obj.stylesheet_path).to eq '/whatever/stylesheets'
    end
  end

  describe '#javascript_path=' do
    before :each do
      config_obj.javascript_path = '/whatever/javascripts'
    end

    it 'sets a new javascript path' do
      expect(config_obj.javascript_path).to eq '/whatever/javascripts'
    end
  end

  describe '#image_path=' do
    before :each do
      config_obj.image_path = '/whatever/images'
    end

    it 'sets a new image path' do
      expect(config_obj.image_path).to eq '/whatever/images'
    end
  end
end
