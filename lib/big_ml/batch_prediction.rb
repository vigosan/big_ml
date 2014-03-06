require 'big_ml/base'
require 'timeout'

module BigML
  class BatchPrediction < Base
    BATCH_PREDICTION_PROPERTIES = [
      :category, :code, :created, :credits, :dataset, :dataset_status,
      :description, :fields, :dataset, :model, :model_status, :name,
      :objective_fields, :prediction, :prediction_path, :private, :resource,
      :source, :source_status, :status, :tags, :updated
    ]

    attr_reader *BATCH_PREDICTION_PROPERTIES

    class << self
      def create(model, dataset, options = {})
        response = client.post("/#{resource_name}", {}, { :model => model, :dataset => dataset }.merge!(options))
        self.new(response) if response.success?
      end
    end

    def ready?
      success? || error?
    end

    def success?
      status["code"] == 5
    end

    def error?
      status["code"] < 0
    end

    def self.wait_for_ready(resource_or_id, options = {:delay => 1, :timeout => 60})
      resource = nil
      remaining = options[:timeout]
      until resource && resource.ready?
        resource = self.find(resource_or_id.kind_of?(BigML::Base) ? resource_or_id.id : resource_or_id)
        sleep(options[:delay]) unless resource.ready?
        remaining = remaining - options[:delay]
        raise Timeout::Error if remaining <= 0
      end
      resource
    end
  end
end
