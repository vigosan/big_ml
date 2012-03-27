require 'httparty'
require 'big_ml/authenticable'
require 'big_ml/config'
require 'big_ml/request'
require 'big_ml/pagination'
require 'big_ml/source'
require 'big_ml/client/source'

module BigML
  class Client
    include HTTParty
    include Authenticable
    include Request
    include Client::Source

    base_uri Config::BIGML_ENDPOINT

    attr_accessor *Config::VALID_OPTIONS_KEYS

    def initialize(attrs={})
      attrs = BigML.options.merge(attrs)
      Config::VALID_OPTIONS_KEYS.each { |key|
        instance_variable_set("@#{key}".to_sym, attrs[key])
      }
    end
  end
end
