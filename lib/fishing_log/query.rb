module FishingLog
  class Query
    attr_reader :criteria, :results

    FILTERS = [:body_of_water, :date, :start_time, :finish_time, :wind_speed,
               :wind_direction, :temperature, :water_temp, :moon_phase]

    # other data points
    # :name, :weight, :time, :location, :depth
    def initialize(catch_set, criteria = {})
      @catch_set, @criteria = catch_set, criteria
      @results = {}
    end

    def search
      @criteria.each {|key, value| send "filter_#{key}", value }
    end

    def filter_body_of_water(key)
      set = @catch_set.catches.select {|catch| catch[:body_of_water] == key }

      @results[:body_of_water] ||= []
      @results[:body_of_water].concat set
    end

    FILTERS.each do |key|
      name = "filter_#{key}"
      next if defined? name

      define_method name do |value|
        raise NoMethodError, "Filter for #{key} not yet implemented"
      end
    end
  end
end
