require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.ignore_localhost = true
  c.allow_http_connections_when_no_cassette = true
end

RSpec.configure do |config|
	config.around(:each, :vcr) do |example|
		name = example.metadata[:full_description].split(/\s+/, 2).join("/").underscore.gsub(/[^\w\/]+/, "_")
		options = example.metadata.slice(:record, :match_requests_on).except(:example_group)
		VCR.use_cassette(name, options) {example.call}
	end
end
