module PushType
  class TagListField < PushType::FieldType

    include PushType::Fields::Arrays

    options template: 'tag_list', html_options: { multiple: true, placeholder: 'Tags...' }

    def to_json(val)
      super.reject(&:blank?) if val.present?
    end

    initialized_on_node do |object, field|

      object.class_eval do

        # Dynamically define standard scope .with_all_`field_name`
        # Returns ActiveRecord::Relation
        #
        scope "with_all_#{ field.name }".to_sym, ->(*args) {
          raise ArgumentError, 'wrong number of arguments' unless args.present?
          tags = args[0].is_a?(Array) ? args[0] : args

          where(["field_store->'tags' ?& ARRAY[:tags]", { tags: tags }])
        }


        # Dynamically define class method .with_any_`field_name`
        # Returns Array
        #
        define_singleton_method "with_any_#{ field.name }".to_sym do |*args, &block|
          raise ArgumentError, 'wrong number of arguments' unless args.present?
          tags = args[0].is_a?(Array) ? args[0] : args

          composed_scope = (
            block.respond_to?(:call) ? block.call : all
          ).where(["field_store->'#{ field.name }' ?| ARRAY[:tags]", { tags: tags }])

          t   = Arel::Table.new('t',  ActiveRecord::Base)
          ct  = Arel::Table.new('ct', ActiveRecord::Base)

          arr_sql = Arel.sql "ARRAY[#{ tags.map { |t| Arel::Nodes::Quoted.new(t).to_sql }.join(', ') }]"
          any_tags_func = Arel::Nodes::NamedFunction.new('ANY', [arr_sql])

          lateral = ct
            .project(Arel.sql('e').count(true).as('ct'))
            .from(Arel.sql "jsonb_array_elements_text(t.field_store->'#{ field.name }') e")
            .where(Arel::Nodes::Equality.new Arel.sql('e'), any_tags_func)

          query = t
            .project(t[Arel.star])
            .from(composed_scope.as('t'))
            .join(Arel.sql ", LATERAL (#{ lateral.to_sql }) ct")
            .order(ct[:ct].desc)

          find_by_sql query.to_sql
        end


        # Dynamically define class method .all_`field_name`
        # Returns Array
        #
        define_singleton_method "all_#{ field.name }".to_sym do |*args, &block|
          composed_scope = block.respond_to?(:call) ? block.call : all
          composed_scope.projections = []

          query = composed_scope
            .project(Arel.sql "jsonb_array_elements_text(field_store->'#{ field.name }') t")
            .distinct
            .order(Arel.sql 't')
          connection.select_all(query.to_sql).rows.flatten
        end

      end
    end

  end
end