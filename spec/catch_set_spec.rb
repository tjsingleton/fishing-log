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

  it "should be able to search and return a query" do
    catch_set = CatchSet.new

    query = mock(Query)
    Query.should_receive(:new).with(catch_set, an_instance_of(Hash)).and_return(query)
    query.should_receive(:search)

    catch_set.search(body_of_water: "Bear Creek")
  end
end
