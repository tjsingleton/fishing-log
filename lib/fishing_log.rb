%w[
  catch
  catch_set
  dsl_file
  report
  report_loader
  weather
  query
  query_analysis
].each do |name|
  require_relative "fishing_log/#{name}"
end

module FishingLog
  def self.search(criteria, reports = [], out = STDOUT)
    catch_set = ReportLoader.new(*reports).to_catch_set
    query     = catch_set.search(criteria)

    QueryAnalysis.new(query.results).report(out)
  end
end
