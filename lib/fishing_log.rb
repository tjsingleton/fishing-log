%w[catch catch_set dsl_file report report_loader weather].each do |name|
  require_relative "fishing_log/#{name}"
end

module FishingLog

end
