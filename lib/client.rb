class Client

  def initialize(city, provider)
    @provider = provider.new(city)
  end

  def today_temperature
    fetch_temperatures
    [@week_temperatures[:minimum].first, @week_temperatures[:maximum].first]
  end

  def week_max_average
    fetch_temperatures
    week_average @week_temperatures[:maximum]
  end

  def week_min_average
    fetch_temperatures
    week_average @week_temperatures[:minimum]
  end

private

  def week_average(values)
    values.inject { |total, day_temperature| total + day_temperature } / 7
  end

  def fetch_temperatures
    @week_temperatures = {
      minimum: @provider.week_minimum_temperatures,
      maximum: @provider.week_maximum_temperatures
    }
  end

end
