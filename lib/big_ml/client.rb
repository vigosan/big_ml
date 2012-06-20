require 'httmultiparty'
require 'big_ml/authenticable'
require 'big_ml/config'
require 'big_ml/request'
require 'big_ml/base'
require 'big_ml/source'

module BigML
  class Client
    include HTTMultiParty
    include Authenticable
    include Request

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
