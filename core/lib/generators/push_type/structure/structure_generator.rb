module PushType
  class StructureGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)
    argument :attributes, type: :array, default: [], banner: "field:type field:type"

    def create_model
      template 'structure.rb', "app/models/#{ file_name }.rb"
    end

    hook_for :test_framework, as: :model

    protected

    def attribute_as_field(att)
      "field :#{ att.name }, :#{ att.type }"
    end
  end
end
