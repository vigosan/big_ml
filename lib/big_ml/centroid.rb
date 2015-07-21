require 'big_ml/base'

module BigML
  class Centroid < Base
    CENTROID_PROPERTIES = [
      :category, :centroid, :centroid_id, :centroid_name, :cluster,
      :cluster_type, :cluster_status, :code, :created, :credits, :dataset,
      :dataset_status, :description, :dev, :distance, :input_data, :locale,
      :name, :private, :project, :resource, :query_string, :source,
      :source_status, :status, :subscription, :tags, :updated
    ]

    attr_reader *CENTROID_PROPERTIES

    class << self
      def create(cluster, options = {})
        response = client.post("/#{resource_name}", {}, { cluster.split('/').first.to_sym => cluster }.merge!(options))
        self.new(response) if response.success?
      end
    end
  end
end
