require 'push_type/tag_list_query'

module PushType
  class TagListField < ArrayField

    def template
      @opts[:template] || 'tag_list'
    end

    def html_options
      { multiple: true, placeholder: 'Tags...' }.merge(super).merge(class: 'tagsinput')
    end

    def to_json(val)
      super.reject(&:blank?)
    end

    def from_json(val)
      super.reject(&:blank?)
    end

    initialized_on_node do |object, field|
      object.define_singleton_method "all_#{ field.name }".to_sym do |*args|
        TagListQuery.new(field.name, object.name.underscore.to_sym).all *args
      end
    end

  end
end