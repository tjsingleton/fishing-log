class CatchSet
  attr_reader :catches

  def initialize
    @catches = []
  end

  def add_report(report)
    report.catches.each do |catch|
      data = catch.data.dup
      data.merge! report.data
      data.merge! report.weather.data
      @catches << data
    end
  end
end
