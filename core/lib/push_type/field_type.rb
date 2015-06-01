require 'push_type/fields/class_methods'
require 'push_type/fields/base'
require 'push_type/fields/ui'
require 'push_type/fields/arrays'
require 'push_type/fields/relations'

module PushType
  class FieldType

    extend PushType::Fields::ClassMethods

    include PushType::Fields::Base
    include PushType::Fields::Ui

  end
end
