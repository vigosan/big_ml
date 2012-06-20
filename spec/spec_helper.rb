require 'big_ml'
require 'rspec'
require 'vcr'

BigML.configure do |c|
  c.username = 'foo'
  c.api_key = 'bar'
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.configure_rspec_metadata!
  c.hook_into :fakeweb
  c.filter_sensitive_data('<USERNAME>') { BigML.username }
  c.filter_sensitive_data('<API_KEY>') { BigML.api_key }
end


RSpec.configure do |c|
  c.mock_with :rspec
  c.treat_symbols_as_metadata_keys_with_true_values = true
end
