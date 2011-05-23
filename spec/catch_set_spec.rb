require_relative 'spec_helper'

describe CatchSet do
  let(:report) { DSLFile.read("samples/5-16-11.rb") }

  it "adding a report adds in each catch" do
    catch_set = CatchSet.new
    catch_set.add_report report

    catch_set.should have(2).catches
  end

  it "should denormalize the weather and report data" do
    catch_set = CatchSet.new
    catch_set.add_report report

    catch_set.catches.first.should include(wind_speed: 5,
                                           body_of_water: 'Bear Creek',
                                           name: :bass)

  end
end
