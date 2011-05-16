class Report
  attr_reader :data

  def initialize(&block)
    @data = {}
    self.instance_eval(&block) if block_given?
  end

  def on(date)
    @data[:date] = date
  end

  def between(start, finish)
    @data[:start_time], @data[:finish_time] = start, finish
  end

  def at(name)
    @data[:body_of_water] = name
  end

  def weather(&block)
    @weather ||= Weather.new
    @weather.tap do |weather|
      weather.instance_eval(&block) if block_given?
    end
  end

  def caught(&block)
    @catches ||= []
    @catches << Catch.new.tap do |fish|
      fish.instance_eval(&block) if block_given?
    end
  end
end
