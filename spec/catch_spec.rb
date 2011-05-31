require_relative 'spec_helper'

describe FishingLog::Catch do
  let(:catch) { FishingLog::Catch.new }

  it "can set the fish" do
    catch.fish "Bass"
    catch.data[:name].should == "Bass"
  end

  it "can set the weight" do
    catch.weighing 1
    catch.data[:weight].should == 1
  end

  it "can set the time" do
    catch.time "9:30 am"
    catch.data[:time].should == "9:30 am"
  end

  it "can set the location" do
    catch.location "Stickups"
    catch.data[:location].should == "Stickups"
  end

  it "can set the bait and technique" do
    catch.using "Black Senko", "Wacky-rigged"
    catch.data[:bait].should == "Black Senko"
    catch.data[:technique].should == "Wacky-rigged"
  end
end
