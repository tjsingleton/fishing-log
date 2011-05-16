require "./lib/report"
require "./lib/catch"
require "./lib/weather"
require "./lib/dsl_file"

describe DSLFile do
  let(:report) { DSLFile.read("samples/5-16-11.rb") }

  it "should be a report" do
    report.should be_a(Report)
  end
end
