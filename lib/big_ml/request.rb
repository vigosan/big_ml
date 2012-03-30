module BigML
  module Request
    def get(path, options = {})
      self.class.get(path, :query => credentials.merge(options))
    end

    def put(path, options = {})
      self.class.put(path, :body => credentials.merge(options))
    end

    def post(path, options = {})
      self.class.post(path, :body => credentials.merge(options))
    end

    def delete(path)
      self.class.delete(path, :query => credentials)
    end
  end
end
