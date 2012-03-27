module BigML
  module Authenticable
    def credentials
      {
        :username => username,
        :api_key  => api_key
      }
    end
  end
end
