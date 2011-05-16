require "./lib/weather"

describe Weather do
  let(:weather) { Weather.new }

  it "can set wind data" do
    weather.wind 15, "NE"
    weather.data[:wind_speed].should == 15
    weather.data[:wind_direction].should == :NE
  end

  it "can set the water temp" do
    weather.water_temp 72
    weather.data[:water_temp].should == 72
  end

  it "can set the water temp" do
    weather.water_temp 72
    weather.data[:water_temp].should == 72
  end

  it "can set the moon phase" do
    weather.moon_phase :full
    weather.data[:moon_phase].should == :full
  end

  it "can set the sky condition" do
    weather.sky :sunny
    weather.data[:sky_condition].should == :sunny
  end
end
