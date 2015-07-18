require 'big_ml/base'

module BigML
  class Dataset < Base
    DATASET_PROPERTIES = [
      :category, :code, :columns, :created, :credits,
      :description, :dev, :excluded_fields, :field_types,
      :fields, :fields_meta, :input_fields, :locale, :name, 
      :number_of_batchpredictions, :number_of_ensembles, 
      :number_of_evaluations, :number_of_models,
      :number_of_predictions, :objective_field, :out_of_bag, :price,
      :private, :project, :range, :refresh_field_types, 
      :refresh_preferred, :replacement, :resource, :rows, 
      :sample_rate, :seed, :shared, :shared_hash, :sharing_key, :size,
      :source, :source_status, :status, :subscription, :tags, 
      :term_limit, :updated
    ]

    attr_reader *DATASET_PROPERTIES

    def to_model
      Model.create(resource)
    end

    class << self
      def create(source, options = {})
        response = client.post("/#{resource_name}", options, { :source => source })
        self.new(response) if response.success?
      end
    end
  end
end
