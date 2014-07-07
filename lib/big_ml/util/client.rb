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

      attr_accessor *Config::VALID_OPTIONS_KEYS
      alias_method :debug?, :debug

      def initialize(attrs={})
        attrs = BigML.options.merge(attrs)
        Config::VALID_OPTIONS_KEYS.each { |key|
          instance_variable_set("@#{key}".to_sym, attrs[key])
        }
        self.class.base_uri big_ml_url
      end

      protected

      def big_ml_url
        dev_mode ? Config::BIGML_DEV_ENDPOINT : Config::BIGML_PROD_ENDPOINT
      end
    end
  end
end
