module BigML
  class Client
    module Source
      def get_sources(options = {})
        get("/source", options)
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
