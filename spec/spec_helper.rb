require "bundler/setup"
require "pry-nav"
require "tu_aqm_client"
require "vcr"
require "dotenv"

Dotenv.load

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.allow_http_connections_when_no_cassette = true
  config.configure_rspec_metadata!
  config.ignore_localhost = false
end
