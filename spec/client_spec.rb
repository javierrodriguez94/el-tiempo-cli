require_relative '../lib/client.rb'
require 'spec_helper'



describe Client do
  subject { described_class.new(city, provider) }
  let(:city) { 'Barcelona' }
  let(:provider) { double('Provider') }
  let(:min_temperatures) { [14, 15, 17, 17, 17, 13, 12] }
  let(:max_temperatures) { [23, 27, 26, 26, 21, 22, 24] }

  before do
    allow(provider)
      .to receive(:new)
      .with(city)
      .and_return(provider)
    allow(provider)
      .to receive(:week_minimum_temperatures)
      .and_return(min_temperatures)
    allow(provider)
      .to receive(:week_maximum_temperatures)
      .and_return(max_temperatures)
  end

  describe '#initialize' do
    it 'initializes a Client with a given provider and a city' do
      expect(described_class.new(city, provider))
        .to be_an_instance_of described_class
    end
  end

  describe '#today_temperature' do
    it 'returns the max and min today temperature' do
      expect(subject.today_temperature).to eq [14, 23]
    end
  end

  describe '#week_max_average' do
    it 'returns the max week average temperature' do
      expect(subject.week_max_average).to eq 24
    end
  end

  describe '#week_min_average' do
    it 'returns the min week temperature' do
      expect(subject.week_min_average).to eq 15
    end
  end
end
