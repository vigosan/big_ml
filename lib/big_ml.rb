require 'big_ml/util/client'
require 'big_ml/model'
require 'big_ml/dataset'
require 'big_ml/prediction'
require 'big_ml/batch_prediction'
require 'big_ml/source'
require 'big_ml/evaluation'

require 'big_ml/util/config'

module BigML
  extend Util::Config

  class << self
    def new(options = {})
      Client.new(options)
    end
  end
end
