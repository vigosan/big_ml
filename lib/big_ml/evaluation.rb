require 'big_ml/base'

module BigML
  class Evaluation < Base
    EVALUATION_PROPERTIES = [
      :category, :code, :combiner, :created, :credits, :dataset, :dataset_status, 
      :description, :dev, :ensemble, :fields_map, :locale, :max_rows, :missing_strategy,
      :model, :model_status, :model_type, :name, :number_of_models, :ordering,
      :out_of_bag, :private, :range, :replacement, :resource, :result, :rows, :sample_rate,
      :shared, :shared_hash, :sharing_key, :size, :status, :subscription, :tags,
      :threshold, :type, :updated
    ]

    attr_reader *EVALUATION_PROPERTIES

    class << self
      def create(model, dataset, options = {})
        response = client.post("/#{resource_name}", {}, { model: model, dataset: dataset }.merge!(options))
        self.new(response) if response.success?
      end
    end
  end
end
