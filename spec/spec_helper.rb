require 'big_ml'
require 'rspec'
require 'vcr'

BigML.configure do |c|
  c.username = 'foo'
  c.api_key  = 'bar'
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
