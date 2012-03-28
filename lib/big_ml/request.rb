module BigML
  module Request
    def get(path, options = {})
      self.class.get(path, :query => options.merge(credentials))
    end

    def post(path, options = {})
      self.class.post(path, :query => options.merge(credentials))
    end

    def delete(path)
      self.class.delete(path, :query => credentials)
    end
  end
end
