module PushType
  class AssetField < PushType::FieldType

    include PushType::Fields::Relations

    options template: 'asset'

    def id_attr
      "#{ name }-asset-modal"
    end

    def relation_class
      PushType::Asset
    end

    initialized_on_node do |object, field|
      object.class_eval do
        define_method field.name.to_sym do
          field.relation_class.not_trash.find send(field.json_key) if send(field.json_key).present?
        end
      end
    end

  end
end