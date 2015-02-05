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

    node_context do |object, field|
      object.define_singleton_method "all_#{ field.name }".to_sym do
        sql = <<-SQL
          SELECT DISTINCT
            jsonb_array_elements_text(field_store->'#{ field.name }') AS _tag
          FROM
            push_type_nodes
          WHERE
            push_type_nodes.type = '#{ object.name }'
          ORDER BY
            _tag
        SQL
        object.connection.select_all(sql).rows.flatten
      end
    end

  end
end