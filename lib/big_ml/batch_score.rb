require 'big_ml/base'

module BigML
  class BatchScore < Base
    BATCH_SCORE_PROPERTIES = [
      :category, :code, :created, :credits, :dataset, :dataset_status,
      :description, :fields, :dataset, :model, :model_status, :name,
      :objective_fields, :prediction, :prediction_path, :private, :resource,
      :source, :source_status, :status, :tags, :updated
    ]

    attr_reader *BATCH_SCORE_PROPERTIES

    class << self
      def create(anomaly, dataset, options = {})
        arguments = { dataset: dataset }
        if cluster.start_with? 'anomaly'
          arguments[:anomaly] = anomaly
        else
          raise ArgumentError, "Expected cluster, got #{anomaly}"
        end
        response = client.post("/#{resource_name}", {}, arguments.merge(options))
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
