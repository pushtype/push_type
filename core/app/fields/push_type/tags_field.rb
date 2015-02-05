module PushType
  class TagsField < ArrayField

    def template
      @opts[:template] || 'tags'
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

    node_hook do |object, field|
      object.define_singleton_method :all_tags do
        sql = <<-SQL.gsub(/^ */, '').gsub(/\n/, ' ')
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