require_relative '../lib/fishing_log'

$fixture_path = Pathname.new(__FILE__).dirname.join('fixtures').expand_path
$reports_path = $fixture_path.join("reports")
