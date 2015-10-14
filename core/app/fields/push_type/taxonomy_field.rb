module PushType
  class TaxonomyField < RelationField

    options template: 'relation'

    def relation_class
      super
    rescue NameError
      PushType::Taxonomy
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