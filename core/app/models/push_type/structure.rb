module PushType
  class Structure

    attr_accessor :field_store

    def self.name
      'Structure'
    end

    include ActiveModel::Model
    include ActiveRecord::AttributeAssignment
    include ActiveRecord::Store
    
    extend ActiveModel::Callbacks
    define_model_callbacks :initialize

    include PushType::Customizable

    def initialize(*args)
      run_callbacks :initialize do
        @field_store ||= {}
        super
      end
    end

  end
end