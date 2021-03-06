module FishingLog
  class Catch
    attr_reader :data

    def initialize
      @data = {}
    end

    def fish(name)
      @data[:name] = name
    end

    def weighing(pounds)
      @data[:weight] = pounds
    end

    def time(at)
      @data[:time] = at
    end

    def location(name)
      @data[:location] = name
    end

    def using(name, technique)
      @data[:bait], @data[:technique] = name, technique
    end

    def depth(ft)
      @data[:depth] = ft
    end
  end
end
