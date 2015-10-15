module PushType
  class RelationField < PushType::FieldType

    options template: 'relation'

    def initialize(*args)
      super
      raise ArgumentError, "Relation field names must end with suffix `_id` or `ids`." unless relation_name
    end

    def json_primitive
       multiple? ? :array : super 
    end

    def label
      super || relation_name.humanize
    end

    def html_options
      super.merge(multiple: multiple?)
    end

    def choices
      if relation_root.respond_to?(:hash_tree)
        flatten_tree(relation_root.hash_tree)
      else
        relation_root.all.map { |item| item_hash(item) }
      end
    end

    def relation_name
      @relation_name ||= (rel = name.to_s.gsub!(/_ids?$/, '')) && (rel && multiple? ? rel.pluralize : rel)
    end

    def relation_class
      (@opts[:to] || relation_name.singularize).classify.constantize
    end

    def relation_root
      relation_class
    end

    private

    def defaults
      super.merge({
        label:    nil,
        mapping:  { value: :id, text: :title }
      })
    end

    def item_hash(item, d = 0)
      {
        value:  item.send(@opts[:mapping][:value]),
        text:   item.send(@opts[:mapping][:text]),
        depth:  d
      }
    end

    def flatten_tree(hash_tree, d = 0)
      hash_tree.flat_map do |parent, children|
        [
          item_hash(parent, d),
          flatten_tree(children, d+1)
        ]
      end.flatten
    end

    on_instance do |object, field|
      object.class_eval do
        define_method(field.relation_name.to_sym) do
          field.relation_class.find field.json_value unless field.json_value.blank?
        end unless method_defined?(field.relation_name.to_sym)
      end
    end

  end
end