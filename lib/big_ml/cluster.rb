require 'big_ml/base'

module BigML
  class Cluster < Base
    CLUSTER_PROPERTIES = [
      :balance_fields, :category, :cluster_datasets, :cluster_seed,
      :clusters, :code, :columns, :created, :credits,
      :credits_per_prediction, :dataset, :dataset_field_types, 
      :dataset_status, :description, :dev, :excluded_fields, :fields_meta,
      :field_scale, :input_fields, :k, :locale, :max_columns, :max_rows,
      :model_clusters, :name,  :number_of_batchcentroids, :number_of_centroids,
      :number_of_public_centroids, :out_of_bag, :price, :private, :project,
      :range, :replacement, :resource, :rows, :sample_rate, :scales, :seed, 
      :shared, :shared_hash, :sharing_key, :size, :source, :source_status,
      :status, :subscription, :summary_fields, :tags, :updated,
      :wheight_field, :white_box
    ]

    attr_reader *CLUSTER_PROPERTIES

    def to_centroid(options)
      Centroid.create(resource, options)
    end

    class << self
      def create(dataset, options = {})
        response = client.post("/#{resource_name}", options, { :dataset => dataset })
        self.new(response) if response.success?
      end
    end
  end
end
