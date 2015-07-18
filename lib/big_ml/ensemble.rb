require 'big_ml/base'

module BigML
  class Ensemble < Base
    ENSEMBLE_PROPERTIES = [
      :category, :code, :columns, :created, :credits, :credits_per_prediction,
      :dataset, :dataset_status, :description, :dev, :distributions,
      :error_models, :excluded_fields, :finished_models, :input_fields, 
      :locale, :max_columns, :max_rows, :missing_splits, :model_order,
      :models, :name, :node_threshold, :number_of_batchpredictions,
      :number_of_evaluations, :number_of_models, :number_of_predictions,
      :number_of_public_predictions, :objective_field, :ordering,
      :out_of_bag, :price, :private, :project, :randomize, :random_candidates,
      :random_candidate_ratio, :range, :replacement, :resource, :rows, 
      :sample_rate, :seed, :shared, :shared_hash, :sharing_key, :size, :source,
      :source_status, :status, :subscription, :tags, :tlp, :updated
    ]

    attr_reader *ENSEMBLE_PROPERTIES

    def to_prediction(options)
      Prediction.create(resource, options)
    end

    class << self
      def create(dataset, options = {})
        response = client.post("/#{resource_name}", {}, options.merge(dataset: dataset))
        self.new(response) if response.success?
      end
    end
  end
end
