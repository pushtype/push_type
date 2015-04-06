module PushType
  class NodeGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)
    argument :attributes, type: :array, default: [], banner: "field:type field:type"

    def create_model
      template 'node.rb', "app/models/#{ file_name }.rb"
      template 'node.html.erb', "app/views/nodes/#{ file_name }.html.erb"
    end

    hook_for :test_framework, as: :model

    protected

    def attribute_as_field(att)
      "field :#{ att.name }, :#{ att.type }"
    end
  end
end
