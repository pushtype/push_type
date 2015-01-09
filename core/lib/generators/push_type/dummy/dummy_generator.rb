require "rails/generators/rails/app/app_generator"

module PushType
  class PushType::DummyGenerator < Rails::Generators::Base
    desc "Creates blank Rails application and installs PushType"

    source_root File.expand_path('../templates', __FILE__)

    class_option :lib_name, default: 'push_type_core'
    class_option :path,     default: 'test/dummy'
    class_option :skip_javascript, type: :boolean, default: false

    def clean_up_test_dummy
      remove_dir(dummy_path) if File.directory?(dummy_path)
    end

    def generate_test_dummy
      opts = {}.merge options
      opts[:database]       = 'postgresql'
      opts[:force]          = true
      opts[:skip_git]       = true
      opts[:skip_keeps]     = true
      opts[:skip_gemfile]   = true
      opts[:skip_bundle]    = true

      say "Generating dummy Rails application... (#{options[:lib_name]})"
      invoke Rails::Generators::AppGenerator, [ File.expand_path(dummy_path, destination_root) ], opts
    end

    def test_dummy_config
      template  'application.rb', "#{ dummy_path }/config/application.rb",  force: true
      copy_file 'boot.rb',        "#{ dummy_path }/config/boot.rb",         force: true
    end

    def clean_test_dummy
      remove_file "#{ dummy_path }/test"
      remove_file "#{ dummy_path }/vendor"
    end

    protected

    def dummy_path
      options[:path]
    end

    def lib_name
      options[:lib_name]
    end

  end
end

