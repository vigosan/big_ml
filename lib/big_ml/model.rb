require 'big_ml/base'

module BigML
  class Model < Base
    MODEL_PROPERTIES = [
      :category, :code, :columns, :created, :credits, :credits_per_prediction,
      :dataset, :dataset_field_types, :dataset_status, :description, :dev,
      :ensemble, :ensemble_id, :ensemble_index, :excluded_fields, :fields_meta,
      :input_fields, :locale, :max_columns, :max_rows, :missing_splits, :model, 
      :name, :node_threshold, :number_of_batchpredictions, 
      :number_of_evaluations, :number_of_predictions,
      :number_of_publicpredictions, :objective_field, :objective_fields,
      :ordering, :out_of_bag, :price, :private, :project, :randomize,
      :random_candidates, :random_candidate_ratio, :range, :replacement,
      :resource, :rows, :sample_rate, :seed, :selective_pruning, :shared,
      :shared_hash, :sharing_key, :size, :source, :source_status,
      :stat_pruning, :status, :subscription, :tags, :updated, :white_box
    ]

    attr_reader *MODEL_PROPERTIES

    def to_prediction(options)
      Prediction.create(resource, options)
    end

    class << self
      def create(dataset, options = {})
        response = client.post("/#{resource_name}", options, { :dataset => dataset })
        self.new(response) if response.success?
      end
    end
  end
end
