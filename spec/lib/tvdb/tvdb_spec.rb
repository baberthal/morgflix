require 'rails_helper'
require './lib/tvdb/tvdb'

RSpec.describe TVDB do
  describe 'singleton methods' do
    it 'knows the api key' do
      expect(described_class.api_key).to_not be_nil
      expect(described_class.api_key).to eq ENV['TVDB_KEY']
    end

    describe '#languages' do
      it 'returns an array of language hashes' do
        expect(described_class.languages).to be_an Array
      end
    end

    describe '#typemasks' do
      it 'returns a hash' do
        expect(described_class.typemasks).to be_a Hash
      end

      it 'returns the typemasks included in an xml_mirror' do
        expect(described_class.typemasks[:xml]).to include '1'
        expect(described_class.typemasks[:xml]).to include '3'
        expect(described_class.typemasks[:xml]).to include '5'
        expect(described_class.typemasks[:xml]).to include '7'
      end

      it 'returns the typemasks included in a banner_mirror' do
        expect(described_class.typemasks[:banner]).to include '2'
        expect(described_class.typemasks[:banner]).to include '3'
        expect(described_class.typemasks[:banner]).to include '6'
        expect(described_class.typemasks[:banner]).to include '7'
      end

      it 'returns the typemasks included in a zip_mirror' do
        expect(described_class.typemasks[:zip]).to include '4'
        expect(described_class.typemasks[:zip]).to include '6'
        expect(described_class.typemasks[:zip]).to include '7'
      end
    end

    describe '#mirror_list' do
      it 'returns a mirror_list object' do
        expect(described_class.mirror_list).to be_a TVDB::MirrorList
      end
    end

    describe '#xml_mirror' do
      it 'returns a properly formatted morror' do
        expect(described_class.xml_mirror).to match(%r{thetvdb\.com/api})
      end
    end

    describe '#banner_mirror' do
      it 'returns a properly formatted morror' do
        expect(described_class.banner_mirror).to match(%r{thetvdb\.com/api})
      end
    end

    describe '#zip_mirror' do
      it 'returns a properly formatted morror' do
        expect(described_class.zip_mirror).to match(%r{thetvdb\.com/api})
      end
    end
  end
end
