module BigML
  class Prediction < Base
    SOURCE_PROPERTIES = [
      :category, :code, :created, :credits, :dataset, :dataset_status, 
      :description, :fields, :input_data, :model, :model_status, :name, 
      :objective_fields, :prediction, :prediction_path, :private, :resource, 
      :source, :source_status, :status, :tags, :updated
     ]

     attr_reader *SOURCE_PROPERTIES

     class << self

      def create(model, options = {})
        response = client.post("/#{resource_name}", {}, { :model => model }.merge!(options))
        self.new(response) if response.success?
      end
     end
  end
end
