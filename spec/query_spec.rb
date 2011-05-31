require 'spec_helper'

describe FishingLog::Query do

  BODIES_OF_WATER = %w{Lanier Sinclair Oconee}
  def rand_body_of_water
    BODIES_OF_WATER[ rand(BODIES_OF_WATER.length - 1) ]
  end

  MOON_PHASES = [:new, :waning_crescent, :third_quarter, :wanning_gibbous]
  def rand_moon_phase
    MOON_PHASES[ rand(MOON_PHASES.length - 1) ]
  end

  it "can filter based on body of water" do
    catch_set = stub(catches: [])
    5.times { catch_set.catches << {body_of_water: 'Bear Creek'} }
    3.times { catch_set.catches << {body_of_water: rand_body_of_water} }

    query = FishingLog::Query.new(catch_set, {body_of_water: 'Bear Creek'})
    query.search
    body_of_water_results = query.results[:body_of_water]

    body_of_water_results.size.should == 5
    body_of_water_results.each do |result|
      result[:body_of_water].should == 'Bear Creek'
    end
  end

  it "can filter based on temp" do
    catch_set = stub(catches: [])
    (80..100).each{|n| catch_set.catches << {temperature: n} }

    query = FishingLog::Query.new(catch_set, {temperature: 90})
    query.search
    temperature_results = query.results[:temperature]

    temperature_results.size.should == 11
    temperatures = temperature_results.map{|result| result[:temperature]}
    temperatures.min.should == 85
    temperatures.max.should == 95
  end

  it "can filter based on moon phase" do
    catch_set = stub(catches: [])
    5.times { catch_set.catches << {moon_phase: :full} }
    3.times { catch_set.catches << {moon_phase: rand_moon_phase} }

    query = FishingLog::Query.new(catch_set, {moon_phase: :full})
    query.search
    moon_phase_results = query.results[:moon_phase]

    moon_phase_results.size.should == 5
    moon_phase_results.each do |result|
      result[:moon_phase].should == :full
    end
  end

    it "can filter based on temp" do
    catch_set = stub(catches: [])
    (80..100).each{|n| catch_set.catches << {water_temp: n} }

    query = FishingLog::Query.new(catch_set, {water_temp: 90})
    query.search
    water_temp_results = query.results[:water_temp]

    water_temp_results.size.should == 11
    water_temps = water_temp_results.map{|result| result[:water_temp]}
    water_temps.min.should == 85
    water_temps.max.should == 95
    end

  it "can filter based on time" do
    catch_set = stub(catches: [])
    ["9:00 am", "10:00 am", "11:00 am"].map do |time|
      catch_set.catches << {time: time}
    end

    query = FishingLog::Query.new(catch_set, {time: {start: "9:30 am",
                                         finish: "10:30 am"}})
    query.search

    time_results = query.results[:time]
    time_results.size.should == 1
    time_results.first[:time].should == "10:00 am"
  end
end
