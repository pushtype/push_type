module PushType
  class Structure

    attr_accessor :field_store

    include ActiveModel::Model
    include ActiveRecord::AttributeAssignment
    include ActiveRecord::Store
    
    extend ActiveModel::Callbacks
    define_model_callbacks :initialize, only: :after

    include PushType::Customizable

    def self.name
      'PushType::Structure'
    end

    def initialize(*args)
      run_callbacks :initialize do
        @field_store ||= {}
        super
      end
    end

  end
end