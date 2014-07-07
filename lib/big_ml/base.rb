require 'big_ml/util/client'
require 'timeout'

module BigML
  class Base
    attr_accessor :attrs

    def initialize(attrs = {})
      @attrs = attrs.dup
      @attrs.each { |key, value|
        instance_variable_set("@#{key}".to_sym, value)
      }
    end

    def id
      resource.split('/').last
    end

    def destroy
      self.class.delete(id)
    end

    def update(options)
      self.class.update(id, options)
    end

    def ready?
      success? || error?
    end

    def success?
      status["code"] == 5
    end

    def error?
      status["code"] < 0
    end

    def wait_for_ready(options = {})
      BigML::Base.wait_for_ready(self, options)
    end

    class << self
      def all(options = {})
        response = client.get("/#{resource_name}", options)
        response['objects'].map { |source| self.new(source) } if response.success?
      end

      def find(id, options = {})
        response = client.get("/#{resource_name}/#{id}", options)
        self.new(response) if response.success?
      end

      def update(id, options = {})
        client.put("/#{resource_name}/#{id}", {}, options)
      end

      def delete(id)
        response = client.delete("/#{resource_name}/#{id}")
        response.success?
      end

      def delete_all
        all.each {|s| delete(s.id) }
      end

      # Keeps reloading resource until it is ready
      def wait_for_ready(resource, options = {})
        klass = resource.class
        remaining = options.fetch :timeout, 60
        delay = options.fetch :delay, 1
        until resource && resource.ready?
          resource = klass.find(resource.id)
          sleep(delay) unless resource.ready?
          remaining = remaining - delay
          raise Timeout::Error if remaining <= 0
        end
        resource
      end

      private

      def client
        @client ||= Util::Client.new
      end

      def resource_name
        self.name.split("::").last.downcase
      end
    end
  end
end
