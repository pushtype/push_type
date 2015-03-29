module PushType
  class TaxonomyGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)

    def create_field
      template 'taxonomy.rb', "app/models/#{ file_name }.rb"
    end

    hook_for :test_framework, as: :model

  end
end