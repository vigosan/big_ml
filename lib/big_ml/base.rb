module BigML
  class Base
     attr_accessor :attrs

     def initialize(attrs = {})
        @attrs = attrs.dup
        @attrs.each { |key, value|
          instance_variable_set("@#{key}".to_sym, value)
        }
     end

    class << self
      def all(options = {})
        response = client.get("/#{resource_name}", options)
        response['objects'].map { |source| self.new(source) } if response.success?
      end

      def find(id, options = {})
        response = client.get("/#{resource_name}/#{id}", options)
        self.new(response) if response.success?
      end

      def update(id, options = {})
        client.put("/#{resource_name}/#{id}", options)
      end

      def create(file, options = {})
        response = client.post("/#{resource_name}", options.merge(:multipart => true, :file => File.new(file)))
        self.new(response) if response.success?
      end

      def delete(id)
        response = client.delete("/#{resource_name}/#{id}")
        response.success?
      end

      private

      def client
        @client ||= Client.new
      end

      def resource_name
        self.name.split("::").last.downcase
      end
    end
  end
end
