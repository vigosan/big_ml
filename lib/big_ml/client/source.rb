module BigML
  class Client
    module Source
      def get_sources(options = {})
        # we need to extract also the pagination information
        response = get("/source", options)
        if response.success?
          response['objects'].map { |source| BigML::Source.new(source) }
        else
          # errors
        end
      end

      def get_source(id, options = {})
        response = get("/source/#{id}", options)
        if response.success?
          BigML::Source.new(response)
        else
          # errors
        end
      end

      def update_source(id, options = {})
        post("/source/#{id}", options)
      end

      def find_sources(options = {})
        response = get("/source", options)
        if response.success?
          response['objects'].map { |source| BigML::Source.new(response) }
        else
          # errors
        end
      end

      def delete_source(id)
        delete("/source/#{id}")
      end
    end
  end
end
