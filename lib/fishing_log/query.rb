module FishingLog
  class Query
    attr_reader :criteria, :results

    FILTERS = [:body_of_water, :date, :time, :wind_speed, :wind_direction,
               :temperature, :water_temp, :moon_phase]

    TEMP_DELTA = 5


    # other data points
    # :name, :weight, :time, :location, :depth
    def initialize(catch_set, criteria = {})
      @catch_set, @criteria = catch_set, criteria
      @results = {}
    end

    def search
      @criteria.each {|key, value| send "filter_#{key}", value }
    end

    [:body_of_water, :moon_phase].each do |key|
      define_method "filter_#{key}" do |name|
        set = select {|catch| catch[key] == name }
        add_filter_set key, set
      end
    end

    def filter_temperature(temp)
      acceptable_range = (temp - TEMP_DELTA)..(temp + TEMP_DELTA)
      set = select {|catch| acceptable_range.cover? catch[:temperature] }
      add_filter_set :temperature, set
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
  end
end
