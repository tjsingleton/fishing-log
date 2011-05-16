require "./lib/report"
require "./lib/catch"
require "./lib/weather"

describe Report do
  let(:report) { Report.new }

  it "can set the body of water" do
    report.at "Bear Creek"
    report.data[:body_of_water].should == "Bear Creek"
  end

  it "weather evals the weather" do
    object = nil
    report.weather do
      object = self
    end
    object.should be_a(Weather)
  end

  it "caught evals a new catch" do
    object = nil
    report.caught do
      object = self
    end
    object.should be_a(Catch)
  end

end
