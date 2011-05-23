require 'spec_helper'

describe Query do

  BODIES_OF_WATER = %w{Lanier Sinclair Oconee}
  def rand_body_of_water
    BODIES_OF_WATER[ rand(BODIES_OF_WATER.length - 1) ]
  end

  it "can filter based on body of water" do
    catch_set = stub(catches: [])
    5.times { catch_set.catches << {body_of_water: 'Bear Creek'} }
    3.times { catch_set.catches << {body_of_water: rand_body_of_water} }

    query = Query.new(catch_set, {body_of_water: 'Bear Creek'})
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

    query = Query.new(catch_set, {temperature: 90})
    query.search
    temperature_results = query.results[:temperature]

    temperature_results.size.should == 11
    temperatures = temperature_results.map{|result| result[:temperature]}
    temperatures.min.should == 85
    temperatures.max.should == 95
  end

end
