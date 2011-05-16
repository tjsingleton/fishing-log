class Weather
  attr_reader :data

  def initialize
    @data = {}
  end

  def wind(speed, direction)
    @data[:wind_speed], @data[:wind_direction] = speed, direction.to_sym
  end

  def temp(degrees)
    @data[:temperature] = degrees
  end

  def water_temp(degrees)
    @data[:water_temp] = degrees
  end

  def moon_phase(phase)
    @data[:moon_phase] = phase
  end

  def sky(condition)
    @data[:sky_condition] = condition
  end
end
