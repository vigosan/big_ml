require 'big_ml/base'

module BigML
  class Score < Base
    SCORE_PROPERTIES = [
      :anomaly, :anomaly_status, :anomaly_type,
      :category, :code, :created, :credits, :dataset, :dataset_status, 
      :description, :dev, :importance, :input_data, :locale, :name, 
      :private, :project, :resource, :score, :query_string,
      :source, :source_status, :status, :subscription, :tags, :updated
    ]

    attr_reader *SCORE_PROPERTIES

    class << self
      def create(anomaly, options = {})
        response = client.post("/#{resource_name}", {}, { anomaly.split('/').first.to_sym => anomaly }.merge!(options))
        self.new(response) if response.success?
      end
    end
  end
end
