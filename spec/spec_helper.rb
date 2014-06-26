require 'big_ml'
require 'rspec'
require 'vcr'

BigML.configure do |c|
  c.username = 'bigmlvcr'
  c.api_key  = '02cde8464ffa0fa4d3aa3490b5c32c3f99fe3140'
  c.dev_mode = true
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.configure_rspec_metadata!
  c.hook_into :fakeweb
  c.filter_sensitive_data('<USERNAME>') { BigML.username }
  c.filter_sensitive_data('<API_KEY>') { BigML.api_key }
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
