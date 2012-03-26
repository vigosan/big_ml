module BigML
  module Config
    # The username if none is set
    DEFAULT_BIGML_USERNAME = nil
    # The api key if none is set
    DEFAULT_BIGML_API_KEY  = nil
    # The endpoint that will be used to connect if none is set
    BIGML_ENDPOINT         = "https://bigml.io"
    #
    BIGML_AUTH             = "username=#{DEFAULT_BIGML_USERNAME};api_key=#{DEFAULT_BIGML_API_KEY}"
    # An array of valid keys in the options hash when configuring a {BigML::Client}
    VALID_OPTIONS_KEYS     = [:username, :api_key]

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
    end
  end
end
