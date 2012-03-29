module BigML
  class Source
    SOURCE_PROPERTIES = [
      :code, :content_type, :created, :credits, :fields, :file_name, :md5, 
      :name, :number_of_datasets, :number_of_models, :number_of_predictions, 
      :private, :resource, :size, :source_parser, :status, :type, :updated
     ]

     attr_accessor :attrs
     attr_reader *SOURCE_PROPERTIES

     def initialize(attrs = {})
        @attrs = attrs.dup
        @attrs.each { |key, value|
          instance_variable_set("@#{key}".to_sym, value)
        }
     end

     def id
       resource.split('/').last
     end
  end
end
