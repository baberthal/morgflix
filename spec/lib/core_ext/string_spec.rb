require 'rails_helper'

RSpec.describe String do
  shared_examples 'snakeifys' do |test|
    let(:test_str) { test }
    it 'leaves the original in place' do
      expect(test_str.snakeify).to eq 'camel_cased'
      expect(test_str).to eq test
    end
  end

  shared_examples 'snakeifys!' do |test|
    let(:test_str) { test }
    it 'modifies the original' do
      expect(test_str.snakeify!).to eq 'camel_cased'
      expect(test_str).to eq 'camel_cased'
    end
  end

  describe '#snakeify' do
    context 'when the string is camelCased' do
      include_examples 'snakeifys', 'camelCased'
    end

    context 'when the string is CamelCased' do
      include_examples 'snakeifys', 'CamelCased'
    end
  end

  describe '#snakeify!' do
    context 'when the string is camelCased' do
      include_examples 'snakeifys!', 'camelCased'
    end

    context 'when the string is CamelCased' do
      include_examples 'snakeifys!', 'CamelCased'
    end

    context 'when the string is UPPERCASED' do
      let(:test_str) { 'UPPERCASED' }
      it 'snakeifys!' do
        expect(test_str.snakeify!).to eq 'uppercased'
        expect(test_str).to eq 'uppercased'
      end
    end

    context 'when the string is UPPER_CASED' do
      let(:test_str) { 'UPPER_CASED' }
      it 'snakeifys!' do
        expect(test_str.snakeify!).to eq 'upper_cased'
        expect(test_str).to eq 'upper_cased'
      end
    end
  end
end
