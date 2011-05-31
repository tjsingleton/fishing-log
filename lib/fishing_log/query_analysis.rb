module FishingLog
  class QueryAnalysis
    def initialize(subject)
      @subject = subject
    end

    def analyze
      fish, bait, technique, location, depth = *5.times.map { counter }

      @subject.values.each do |catches|
        catches.each do |catch|
          increase fish,      catch, :name
          increase bait,      catch, :bait
          increase technique, catch, :technique
          increase location,  catch, :location
          increase depth,     catch, :depth
        end
      end

      {
        fish:      fish,
        bait:      bait,
        technique: technique,
        location:  location,
        depth:     depth
      }
    end

    def report(out = STDOUT)
      separator = " | "
      padding = 2

      analyze.each do |category, counter_hash|
        out.puts category

        value_width, count_width = *[counter_hash.keys,
                                     counter_hash.values].map do |item|
          item.max{|str| str.to_s.size }.to_s.size + padding
        end

        out.puts "=" * (value_width + count_width + separator.size + padding)


        counter_hash.each do |value, count|
          out.puts [
            pad(value, value_width),
            pad(count, count_width)
          ].join(separator)
        end

        out.puts
      end

      out
    end

    private
    def counter
      Hash.new {|hsh, key| hsh[key] = 0 }
    end

    def increase(counter_hash, catch, key)
      if counter_key = catch[key]
        counter_hash[counter_key] += 1
      end
    end

    def pad(value, width)
      string = value.to_s
      needed = width - string.size
      " " * needed + string
    end
  end
end
