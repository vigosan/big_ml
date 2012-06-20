module BigML
  class Source
    SOURCE_PROPERTIES = [
      :code, :content_type, :created, :credits, :fields, :file_name, :md5, 
      :name, :number_of_datasets, :number_of_models, :number_of_predictions, 
      :private, :resource, :size, :source_parser, :status, :type, :updated
     ]

     attr_accessor :attrs
     attr_reader *SOURCE_PROPERTIES

     def initialize(attrs = {})
        @attrs = attrs.dup
        @attrs.each { |key, value|
          instance_variable_set("@#{key}".to_sym, value)
        }
     end

     def id
       resource.split('/').last
     end

    class << self

      def all(options = {})
        response = client.get("/source", options)
        response['objects'].map { |source| self.new(source) } if response.success?
      end

      def find(id, options = {})
        response = client.get("/source/#{id}", options)
        self.new(response) if response.success?
      end

      def update(id, options = {})
        client.put("/source/#{id}", options)
      end

      def create(file, options = {})
        response = client.post("/source", options.merge(:multipart => true, :file => File.new(file)))
        self.new(response) if response.success?
      end

      def delete(id)
        response = client.delete("/source/#{id}")
        response.success?
      end

      private

      def client
        @client ||= Client.new
      end

    end
  end
end
