## Description

FishingLog provides a simple dsl for recording your fishing trip information and a cli tool to filter the data.

## Documentation

### Writing reports

Reports are surrounded with a report block. You could have multiple reports per file. Each report can consist of report attributes, one weather block, and multiple catch blocks.

See examples for an example.

#### Report attributes:

- on      = Date of trip
- between = Start time, End time of trip
- at      = Name of the body of water

#### Weather attributes:

- wind       = Speed, Direction
- temp       = Degrees of air temperature
- water_temp = Degrees of top water temperature
- moon_phase = Moon phase, see [Chart](http://www.moonconnection.com/moon_phases.phtml) for appropriate values
- sky        = Description of sky conditions like :cloudy, :sunny, :raining


#### Catch attributes

- fish      = Species name
- weighing  = Weight of catch, use a consistent measure.
- time      = Time of catch
- location  = Description of where you caught the fish on the water
- using     = Bait that you used, Technique that you used
- depth     = Depth which you were targeting

### Using the cli tool

    Usage: fishing_log [options] file, ...
            --body_of_water [QUERY]      Filters on body_of_water
            --date [QUERY]               Filters on date
            --time [QUERY]               Filters on time
            --wind_speed [QUERY]         Filters on wind_speed
            --wind_direction [QUERY]     Filters on wind_direction
            --temperature [QUERY]        Filters on temperature
            --water_temp [QUERY]         Filters on water_temp
            --moon_phase [QUERY]         Filters on moon_phase
            --sky_condition [QUERY]      Filters on sky_condition

## Examples

### Example report

    report do
      at "Bear Creek"
      on "5-16-11"
      between "6:30 am", "2:00 pm"

      weather do
        wind 5, :NW
        temp 85
        water_temp 72
        moon_phase :full
      end

      caught do
        fish :bass
        weighing 1
        time "9:00 pm"
        location "Stumps in A5"
        depth 15
      end

      caught do
        fish :bass
        weighing 1.8
        time "11:15 pm"
        location "Weed bed in B4"
        depth 8
      end
    end

### Example CLI query

`fishing_log --body_of_water 'Bear Creek' spec/fixtures/reports/*`

    fish
    ==================
          bass |   3
      bluegill |   1

    bait
    ==================
      shad rap |   1

    technique
    ==================
      trolling |   1

    location
    =======================
       Stumps in A5 |   2
     Weed bed in B4 |   1
      Channel in B3 |   1

    depth
    ============
      15 |   2
       8 |   1
      22 |   1

## Questions and/or Comments

Feel free to email [TJ Singleton](tjsingleton@vantagestreet.com) with any questions.
