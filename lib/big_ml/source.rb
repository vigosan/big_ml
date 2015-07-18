require 'big_ml/base'

module BigML
  class Source < Base
    SOURCE_PROPERTIES = [
      :category, :code, :content_type, :created, :credits, :description, 
      :dev, :disable_datetime, :fields, :fields_meta, :file_name, :md5, 
      :name, :number_of_datasets, :number_of_ensembles, :number_of_models,
      :number_of_predictions, :private, :project, :remote, :resource, :shared,
      :shared_hash, :sharing_key, :size, :source_parser, :status,
      :subscription, :tags, :term_analysis, :type, :updated
    ]

    attr_reader *SOURCE_PROPERTIES

    def to_dataset
      Dataset.create(resource)
    end

    class << self
      def create(file, options = {})
        response = client.post("/#{resource_name}", options.merge(:multipart => true, :file => File.new(file)))
        self.new(response) if response.success?
      end
    end
  end
end
