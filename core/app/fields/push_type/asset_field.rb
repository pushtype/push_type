module PushType
  class AssetField < PushType::FieldType

    def template
      @opts[:template] || 'asset'
    end

    def id_attr
      "#{ name }-asset-modal"
    end

    def from_json(val)
      return unless val
      PushType::Asset.find(val)
    end

    initialized_on_node do |object, field|
      object.class_eval do

        define_method field.relation_id_method do
          field_store[field.name]
        end

      end
    end

    def relation_id_method
      (name + '_id').to_sym
    end

  end
end