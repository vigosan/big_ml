module BigML
  module Request
    def get(path, options = {})
      options.merge!(credentials)
      self.class.get(path, :query => options)
    end

    def put(path, options = {})
      options.merge!(credentials)
      self.class.put(path, :query => options)
    end

    def post(path, options = {})
      options.merge!(credentials)
      self.class.post(path, :query => options)
    end

    def delete(path, options = {})
      options.merge!(credentials)
      self.class.delete(path, :query => options)
    end
  end
end
