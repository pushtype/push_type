module PushType
  class Structure

    attr_accessor :field_store

    include ActiveModel::Model
    include ActiveRecord::AttributeAssignment
    include ActiveRecord::Store
    include PushType::Customizable

    def self.name
      'PushType::Structure'
    end

    def initialize(*args)
      @field_store ||= {}
      super
    end

  end
end