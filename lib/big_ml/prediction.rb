require 'big_ml/base'

module BigML
  class Prediction < Base
    PREDICTION_PROPERTIES = [
      :category, :code, :combiner, :confidence, :created, :credits, :dataset,
      :dataset_status, :description, :dev, :ensemble, :error_predictions,
      :fields, :finished_predictions,  :input_data, :locale, :missing_strategy,
      :model, :models, :model_type, :model_status, :name, :number_of_models, 
      :objective_field, :objective_fields, :objective_field_name, :output,
      :prediction, :predictions, :prediction_path, :private, :project, 
      :resource, :query_string, :source, :source_status, :status, :subscription,
      :tags, :task, :threshold, :tlp, :total_count, :updated, :votes,
      :vote_confidence
    ]

    attr_reader *PREDICTION_PROPERTIES

    class << self
      def create(model_or_ensemble, options = {})
        response = client.post("/#{resource_name}", {}, { model_or_ensemble.split('/').first.to_sym => model_or_ensemble }.merge!(options))
        self.new(response) if response.success?
      end
    end
  end
end
