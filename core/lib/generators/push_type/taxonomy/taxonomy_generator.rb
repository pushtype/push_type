module PushType
  class TaxonomyGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)

    def create_field
      template 'taxonomy.rb', "app/models/#{ file_name }.rb"
      template 'taxonomy.html.erb', "app/views/taxonomies/#{ file_name }.html.erb"
    end

    hook_for :test_framework, as: :model
    hide!
  end
end