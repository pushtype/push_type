module PushType
  class NodeGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)

    def create_model
      template 'node.rb', "app/models/#{ file_name }.rb"
      template 'template.html.erb', "app/views/nodes/#{ file_name }.html.erb"
    end

    hook_for :test_framework, as: :model
  end
end
