require_relative '../../lib/providers/tiempo.rb'
require 'spec_helper'



describe Tiempo do

  subject { described_class.new(available_city) }

  before do
    stub_const('Tiempo::HOST', 'http://www.foo.com')
    stub_const('Tiempo::AFFILIATE_ID', '123456')
    stub_const('Tiempo::DIVISION', '1')
    stub_const('Tiempo::API_LANG', 'es')
    stub_request(:get, "http://www.foo.com?affiliate_id=123456&api_lang=es&division=1")
      .to_return(status: 200, body: cities_xml)
  end

  let(:cities_xml) { File.read("fixtures/cities.xml") }
  let(:barcelona_xml) { File.read("fixtures/barcelona.xml") }
  let(:available_city) { 'Barcelona' }
  let(:unavailable_city) { 'Madrid' }

  describe '#initialize' do

    it 'initializes the provider with a available city' do
      expect(described_class.new(available_city)).to be_an_instance_of described_class
    end

    it 'initializes the provider with a unavailable city' do
      expect{ described_class.new(unavailable_city) }.to raise_exception ArgumentError
    end
  end

  context 'with an provider initialized in a available_city' do
    before do
      stub_request(:get, 'http://www.foo.com?affiliate_id=123456&api_lang=es&localidad=1')
      .to_return(status: 200, body: barcelona_xml)
    end
    let(:week_mins) { [14, 15, 17, 17, 17, 13, 12] }
    let(:week_maxs) { [23, 27, 26, 26, 21, 22, 24] }

    describe '#week_minimum_temperatures' do
      it 'returns week minimum temperatures in the city' do
        instance = subject
        instance.instance_variable_set(:@city_id, 1)
        expect(instance.week_minimum_temperatures).to eq week_mins
      end
    end

    describe '#week_maximum_temperatures' do
      it 'returns todays temperature in the given city' do
        instance = subject
        instance.instance_variable_set(:@city_id, 1)
        expect(instance.week_maximum_temperatures).to eq week_maxs
      end
    end
  end
end
