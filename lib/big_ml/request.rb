module BigML
  module Request
    def get(path, options = {})
      self.class.get(path, :query => options.merge(credentials))
    end

    def post(path, options = {})
      self.class.post(path, :query => options.merge(credentials))
    end
  end
end
