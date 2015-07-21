require 'big_ml/base'

module BigML
  class Anomaly < Base
    ANOMALY_PROPERTIES = [
      :anomaly_seed, :category, :code, :columns, :created, :credits,
      :credits_per_prediction, :dataset, :dataset_field_types,
      :dataset_status, :description, :dev, :excluded_fields, :fields_meta, 
      :forest_size, :id_fields, :input_fields, :locale, :max_columns,
      :max_rows, :model, :name, :number_of_anomalyscores,
      :number_of_batchanomalyscores, :number_of_public_anomalyscores, 
      :out_of_bag, :price, :private, :project, :range, :replacement, :resource,
      :rows, :sample_rate, :seed, :shared, :shared_hash, :sharing_key, :size,
      :source, :source_status, :status, :subscription, :tags, :top_n, :updated,
      :white_box
    ]

    attr_reader *ANOMALY_PROPERTIES

    def to_score(options)
      Score.create(resource, options)
    end

    class << self
      def create(dataset, options = {})
        response = client.post("/#{resource_name}", options, { :dataset => dataset })
        self.new(response) if response.success?
      end
    end
  end
end
