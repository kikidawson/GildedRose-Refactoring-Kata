# frozen_string_literal: true

require 'gilded_rose'

describe Item do
  subject { described_class.new('Aged Brie', 10, 20) }

  it 'can return the items name' do
    expect(subject.name).to eq 'Aged Brie'
  end

  it 'can return how many days until expiry' do
    expect(subject.sell_in).to eq 10
  end

  it 'can return the items quality' do
    expect(subject.quality).to eq 20
  end

  describe '#to_s' do
    it 'returns the items details in a string' do
      expect(subject.to_s).to eq 'Aged Brie, 10, 20'
    end
  end
end
