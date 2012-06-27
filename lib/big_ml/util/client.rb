require 'httmultiparty'
require 'big_ml/util/authenticable'
require 'big_ml/util/config'
require 'big_ml/util/request'

module BigML
  module Util
    class Client
      include HTTMultiParty
      include Authenticable
      include Request
      format :json

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
end
