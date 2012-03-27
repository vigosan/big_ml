require 'big_ml/version'
require 'big_ml/client'
require 'big_ml/config'

module BigML
  extend Config

  class << self
    def new(options = {})
      Client.new(options)
    end
  end
end
