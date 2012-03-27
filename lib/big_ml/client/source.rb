module BigML
  class Client
    module Source
      def get_sources(options = {})
        # we need to extract also the pagination information
        request = get("/source", options)
        request['objects'].map { |source| BigML::Source.new(source) }
      end

      def get_source(id, options = {})
        get("/source/#{id}", options)
      end

      def update_source(id, options = {})
        post("/source/#{id}", options)
      end
    end
  end
end
