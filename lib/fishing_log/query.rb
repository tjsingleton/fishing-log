module FishingLog
  class Query
    attr_reader :results, :criteria

    FILTERS = [:name, :weight, :time, :location, :depth, :body_of_water, :date,
               :start_time, :finish_time, :wind_speed, :wind_direction,
               :temperature, :water_temp, :moon_phase]

    def initialize(catch_set, criteria = {})
      @catch_set, @criteria = catch_set, criteria
      @results = []
    end

    def search
      @criteria.each do |key, value|
        send "filter_#{key}", value
      end
    end

    FILTERS.each do |key|
      name = "filter_#{key}"
      next if self.instance_methods.include? name

      define_method name do
        raise NoMethodError, "Filter for #{key} not yet implemented"
      end
    end

  end
end
