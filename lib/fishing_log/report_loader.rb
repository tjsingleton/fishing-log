module FishingLog
  class ReportLoader
    def initialize(*files)
      @reports = []

      load_files(*files)
    end

    def load_files(*files)
      files.each {|file| @reports << DSLFile.read(file) }
    end

    def to_catch_set
      CatchSet.new.tap do |catch_set|
        @reports.each {|report| catch_set << report }
      end
    end
  end
end
