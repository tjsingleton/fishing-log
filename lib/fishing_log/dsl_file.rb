module FishingLog
  module DSLFile
    def self.read(file)
      data = File.open(file).read
      module_eval(data)
    end

    def self.report(&block)
      Report.new(&block)
    end
  end
end
