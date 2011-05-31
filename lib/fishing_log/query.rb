require "date"

module FishingLog
  class Query
    attr_reader :criteria, :results

    FILTERS = [:body_of_water, :date, :time, :wind_speed, :wind_direction,
               :temperature, :water_temp, :moon_phase, :sky_condition]

    TEMP_DELTA       = 5
    WATER_TEMP_DELTA = 5


    # other data points
    # :name, :weight, :time, :location, :depth
    def initialize(catch_set, criteria = {})
      @catch_set, @criteria = catch_set, criteria
      @results = {}
    end

    def search
      @criteria.each {|key, value| send "filter_#{key}", value }
      self
    end

    [:body_of_water, :moon_phase].each do |key|

      define_method "filter_#{key}" do |name|
        set = select {|catch| catch[key] == name }
        add_filter_set key, set
      end

    end

    [[:temperature, TEMP_DELTA],
     [:water_temp,  WATER_TEMP_DELTA]].each do |key, delta|

      define_method "filter_#{key}" do |temp|
        acceptable_range = (temp - delta)..(temp + delta)
        set = select {|catch| acceptable_range.cover? catch[key] }
        add_filter_set key, set
      end

    end

    def filter_time(times = {})
      start, finish = times.values_at(:start, :finish).map do |time_str|
        parse_time(time_str)
      end

      set = select do |catch|
        time = parse_time(catch[:time])
        time >= start && time <= finish
      end

      add_filter_set :time, set
    end

    FILTERS.each do |key|
      name = "filter_#{key}"
      next if defined? name

      define_method name do |value|
        raise NoMethodError, "Filter for #{key} not yet implemented"
      end
    end

    private
    def select
      raise ArgumentError, "Block required" unless block_given?

      @catch_set.catches.select {|catch| yield(catch) }
    end

    def add_filter_set(key, set)
      @results[key] ||= []
      @results[key].concat set
    end

    def parse_time(time_str)
      DateTime.parse(time_str).to_time
    end
  end
end
