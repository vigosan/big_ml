require 'big_ml/base'

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

      def download(id)
        response = client.get("/#{resource_name}/#{id}/download")
        response.body if response.success?
      end
    end

    def download
      self.class.download(id)
    end

  end
end
