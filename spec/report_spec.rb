require_relative 'spec_helper'

describe FishingLog::Report do
  let(:report) { FishingLog::Report.new }

  it "can set the body of water" do
    report.at "Bear Creek"
    report.data[:body_of_water].should == "Bear Creek"
  end

  it "weather evals the weather" do
    object = nil
    report.weather do
      object = self
    end
    object.should be_a(FishingLog::Weather)
  end

  it "caught evals a new catch" do
    object = nil
    report.caught do
      object = self
    end
    object.should be_a(FishingLog::Catch)
  end
end
