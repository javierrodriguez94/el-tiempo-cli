class Client

  def initialize(city, provider)
    @provider = provider.new(city)
  end

  def today_temperature
    fetch_temperatures
    [@week_temperatures[:minimun].first, @week_temperatures[:maximun].first]
  end

  def week_max_average
    fetch_temperatures
    week_average @week_temperatures[:maximun]
  end

  def week_min_average
    fetch_temperatures
    week_average @week_temperatures[:minimun]
  end

private

  def week_average(values)
    values.inject { |total, day_temperature| total + day_temperature } / 7
  end

  def fetch_temperatures
    @week_temperatures = {
      minimun: @provider.week_minimun_temperatures,
      maximun: @provider.week_maximun_temperatures
    }
  end

end
