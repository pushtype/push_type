module PushType
  class NodeField < RelationField

    options template: 'relation', root: '/'

    def relation_class
      super
    rescue NameError
      PushType::Node
    end

    def relation_root
      root = relation_class.not_trash
      root = root.find_by_path(@opts[:root].split('/')) unless @opts[:root] == '/'
      root or raise "Cannot find root node at path '#{ @opts[:root] }'"
    end

    on_instance do |object, field|
      object.class_eval do
        define_method(field.relation_name.to_sym) do
          field.relation_class.not_trash.find field.json_value unless field.json_value.blank?
        end unless method_defined?(field.relation_name.to_sym)
      end
    end

  end
end