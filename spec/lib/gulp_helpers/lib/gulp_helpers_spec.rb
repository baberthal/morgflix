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

  describe '#configure' do
    it 'yields the config object' do
      expect { |b| described_class.configure(&b) }.to yield_control
    end
  end

  describe 'delegations' do
    context 'when the method is available on the config object' do
      it 'delegates to the config object' do
        expect(described_class.stylesheet_path).to eq '/stylesheets'
      end

      describe '#respond_to?' do
        it 'returns true' do
          expect(described_class.respond_to?(:stylesheet_path)).to be_truthy
        end
      end
    end

    context 'when the method is not available on the config object' do
      it 'calls super' do
        expect { described_class.not_a_method }.to raise_error NoMethodError
      end

      describe '#respond_to?' do
        it 'returns false' do
          expect(described_class.respond_to?(:not_a_method)).to be_falsy
        end
      end
    end
  end
end
