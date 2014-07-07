module BigML
  module Util
    module Config
      # The endpoint that will be used to connect if none is set
      BIGML_PROD_ENDPOINT    = "https://bigml.io/andromeda"
      # The endpoint that will be used when dev_mode is enabled
      BIGML_DEV_ENDPOINT     = "https://bigml.io/dev/andromeda"
      # The username if none is set
      DEFAULT_BIGML_USERNAME = nil
      # The api key if none is set
      DEFAULT_BIGML_API_KEY  = nil
      # Set default mode to production
      DEFAULT_IN_DEV_MODE    = false
      # Set default debug mode to off
      DEFAULT_IN_DEBUG_MODE  = false
      # An array of valid keys in the options hash when configuring a {BigML::Client}
      VALID_OPTIONS_KEYS     = [:username, :api_key, :dev_mode, :debug]

      attr_accessor *VALID_OPTIONS_KEYS

      def configure
        yield self
        self
      end

      def options
        options = {}
        VALID_OPTIONS_KEYS.each{ |k| options[k] = send(k) }
        options
      end

      def reset
        self.username = DEFAULT_BIGML_USERNAME
        self.api_key  = DEFAULT_BIGML_API_KEY
        self.dev_mode = DEFAULT_IN_DEV_MODE
        self.debug    = DEFAULT_IN_DEBUG_MODE
      end
    end
  end
end
