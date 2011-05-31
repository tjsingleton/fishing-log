require_relative 'spec_helper'

describe FishingLog::DSLFile do
  let(:report) { FishingLog::DSLFile.read($reports_path.join("5-16-11.rb")) }

  it "should be a report" do
    report.should be_a(FishingLog::Report)
  end
end
