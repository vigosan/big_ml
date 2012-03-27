require 'big_ml'
require 'rspec'
require 'webmock/rspec'

RSpec.configure do |config|
  config.mock_with :rspec
end

BigML.configure do |config|
  config.username = 'test'
  config.api_key  = 'secreto'
end
