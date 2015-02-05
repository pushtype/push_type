module PushType
  class PushType::InstallGenerator < Rails::Generators::Base
    desc "Install and configure PushType for this application"

    source_root File.expand_path('../templates', __FILE__)

    class_option :migrate, type: :boolean, default: true

    def create_push_type_initializer
      copy_file 'push_type.rb', 'config/initializers/push_type.rb'
    end

    def inject_push_type_routes
      inject_into_file 'config/routes.rb', "\n\n  mount_push_type\n", after: 'Rails.application.routes.draw do', verbose: true
    end

    def install_migrations
      say '- Copying migrations'
      rake 'railties:install:migrations'
    end

    def run_migrations
      if options[:migrate]
        say '- Running migrations'
        rake 'db:migrate'
      end
    end

  end
end