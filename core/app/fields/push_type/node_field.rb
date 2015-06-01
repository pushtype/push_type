module PushType
  class NodeField < SelectField

    include PushType::Fields::Relations 

    options template: 'relation', field_options: {}, root: '/'

    def relation_root
      root = @opts[:root] == '/' ? PushType::Node : PushType::Node.find_by_path(@opts[:root].split('/'))
      root or raise "Cannot find root node at path '#{ @opts[:root] }'"
    end   

    initialized_on_node do |object, field|
      object.class_eval do
        define_method field.name.to_sym do
          field.relation_class.find send(field.json_key) if send(field.json_key).present?
        end
      end
    end

  end
end