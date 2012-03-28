module BigML
  class Client
    module Source
      def get_sources(options = {})
        # we need to extract also the pagination information
        sources = get("/source", options)
        sources['objects'].map { |source| BigML::Source.new(source) }
      end

      def get_source(id, options = {})
        get("/source/#{id}", options)
      end

      def update_source(id, options = {})
        post("/source/#{id}", options)
      end

      def find_sources(options = {})
        sources = get("/source", options)
        sources['objects'].map { |source| BigML::Source.new(source) }
      end
    end
  end
end
