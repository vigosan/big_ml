module BigML
  class Source < Base
    SOURCE_PROPERTIES = [
      :code, :content_type, :created, :credits, :fields, :file_name, :md5, 
      :name, :number_of_datasets, :number_of_models, :number_of_predictions, 
      :private, :resource, :size, :source_parser, :status, :type, :updated
    ]

    attr_reader *SOURCE_PROPERTIES

    class << self
      def create(file, options = {})
        response = client.post("/#{resource_name}", options.merge(:multipart => true, :file => File.new(file)))
        self.new(response) if response.success?
      end
    end
  end
end
