require_relative 'spec_helper'

describe ReportLoader do

  let(:report_loader) do
    ReportLoader.new("samples/5-16-11.rb",
                     "samples/5-16-11.rb")
  end

  it "can load files" do
    report_loader.should have(2).reports
  end

  it "can generate catch sets" do
    report_loader.to_catch_set.should have(4).catches
  end


end
