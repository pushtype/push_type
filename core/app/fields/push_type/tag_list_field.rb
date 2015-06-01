require 'push_type/tag_list_query'

module PushType
  class TagListField < PushType::FieldType

    include PushType::Fields::Arrays

    options template: 'tag_list', html_options: { multiple: true, placeholder: 'Tags...' }

    def to_json(val)
      super.reject(&:blank?) if val.present?
    end

    initialized_on_node do |object, field|
      object.define_singleton_method "all_#{ field.name }".to_sym do |*args|
        TagListQuery.new(field.name, object.name.underscore.to_sym).all *args
      end
    end

  end
end