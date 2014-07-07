require 'big_ml/base'

module BigML
  class Prediction < Base
    PREDICTION_PROPERTIES = [
      :category, :code, :created, :credits, :dataset, :dataset_status, 
      :description, :fields, :input_data, :model, :model_status, :name, 
      :objective_fields, :prediction, :prediction_path, :private, :resource, 
      :source, :source_status, :status, :tags, :updated
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
