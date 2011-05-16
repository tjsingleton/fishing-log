require "./lib/catch"

describe Catch do
  let(:catch) { Catch.new }

  it "can set the fish" do
    catch.fish 5, "Bass"
    catch.data[:weight].should == 5
    catch.data[:name].should == "Bass"
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
