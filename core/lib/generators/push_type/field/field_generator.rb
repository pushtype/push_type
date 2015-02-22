module PushType
  class FieldGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)

    def create_field
      template 'field.rb', "app/fields/#{ file_name }_field.rb"
    end
  end
end