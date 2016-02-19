module PushType
  class AssetField < RelationField

    options template: 'asset'

    def relation_class
      PushType::Asset
    end

    on_instance do |object, field|
      object.class_eval do
        define_method(field.relation_name.to_sym) do
          field.relation_class.not_trash.find_by_id field.json_value unless field.json_value.blank?
        end unless method_defined?(field.relation_name.to_sym)
      end
    end

  end
end