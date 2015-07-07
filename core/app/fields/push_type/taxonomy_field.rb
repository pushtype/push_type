module PushType
  class TaxonomyField < SelectField

    include PushType::Fields::Relations 

    options template: 'relation', field_options: {}

    def relation_class
      super
    rescue NameError
      PushType::Taxonomy
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