require 'net/http'
require 'xmlsimple'

class Tiempo

  HOST          = ENV['Tiempo::HOST']
  AFFILIATE_ID  = ENV['Tiempo::AFFILIATE_ID']
  DIVISION      = ENV['Tiempo::DIVISION']
  API_LANG      = ENV['Tiempo::API_LANG']

  def initialize(city)
      city = city.downcase
      @city_id = parse_city_id(city)
  end

  def week_minimun_temperatures
    @temperatures_data ||= fetch_temperatures_data
    parse_week_temperatures('Temperatura Mínima')
  end

  def week_maximun_temperatures
    @temperatures_data ||= fetch_temperatures_data
    parse_week_temperatures('Temperatura Máxima')
  end

private

  def parse_city_id(city_name)
    target_city = fetch_cities_data
                    .select{|city| city['name'][0]['content'].downcase == city_name }
                    .first
    raise ArgumentError, "Unable to find city #{city_name}" unless target_city
    target_city
      .fetch('name')
      .first
      .fetch('id')
      .to_i
  end

  def fetch_cities_data
    params = {
      api_lang: API_LANG,
      division: DIVISION,
      affiliate_id: AFFILIATE_ID
    }
    response = perform_get_request(HOST, params)
    parse_response_to_hash(response)
      .fetch('location')
      .first
      .fetch('data')
  end

  def fetch_temperatures_data
    params = {
      api_lang: API_LANG,
      localidad: @city_id,
      affiliate_id: AFFILIATE_ID
    }
    response = perform_get_request(HOST, params)
    parse_response_to_hash(response)
      .fetch('location')
      .first
      .fetch('var')
  end

  def perform_get_request(host, params)
    uri = URI.parse(host)
    uri.query = URI.encode_www_form(params)
    Net::HTTP.get_response(uri)
  end

  def parse_response_to_hash(response)
    XmlSimple.xml_in(response.body)
  end

  def parse_week_temperatures(target_temperatures)
    temperatures  = @temperatures_data
                      .select{ |a| a['name'] == [target_temperatures]}
                      .first

    temperatures
      .fetch('data')
      .first
      .fetch('forecast')
      .map{ |a| a['value'].to_i }
  end
end
