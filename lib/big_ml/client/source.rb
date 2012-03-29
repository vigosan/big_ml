module BigML
  class Client
    module Source
      def get_sources(options = {})
        # we need to extract also the pagination information
        response = get("/source", options)
        response['objects'].map { |source| BigML::Source.new(source) } if response.success?
      end

      def get_source(id, options = {})
        response = get("/source/#{id}", options)
        BigML::Source.new(response) if response.success?
      end

      def update_source(id, options = {})
        post("/source/#{id}", options)
      end

      def find_sources(options = {})
        response = get("/source", options)
        response['objects'].map { |source| BigML::Source.new(response) } if response.success?
      end

      def delete_source(id)
        delete("/source/#{id}")
      end
    end
  end
end
