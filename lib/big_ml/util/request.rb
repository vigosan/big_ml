module BigML
  module Request
    def get(path, options = {}, body = {})
      handle_response self.class.get(path, prepare_options(options, body))
    end

    def put(path, options = {}, body = {})
      handle_response self.class.put(path, prepare_options(options, body))
    end

    def post(path, options = {}, body = {})
      handle_response self.class.post(path, prepare_options(options, body))
    end

    def delete(path, options = {}, body = {})
      handle_response self.class.delete(path, prepare_options(options, body))
    end

    private
    def prepare_options(options, body)
      options.merge!(credentials)
      if body.empty?
        { :query => options }
      else
        { :headers => {'content-type' => 'application/json'}, :query => options, :body => body.to_json }
      end
    end

    def handle_response(response)
      debug? && !response.success? and raise UnsuccessfulRequestError, response.inspect
      response
    end
  end
end
