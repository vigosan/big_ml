module BigML
  class Dataset < Base
    DATASET_PROPERTIES = [
      :category, :code, :columns, :created, :credits,
      :description, :fields, :locale, :name, :number_of_models,
      :number_of_predictions, :private, :resource, :rows, :size,
      :source, :source_status, :status, :tags, :updated
     ]

     attr_reader *DATASET_PROPERTIES

     class << self
      def create(source, options = {})
        response = client.post("/#{resource_name}", options, { :source => source })
        self.new(response) if response.success?
      end
     end
  end
end
