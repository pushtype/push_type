module PushType
  class PushType::InstallGenerator < Rails::Generators::Base
    desc "Install and configure PushType for this application"

    source_root File.expand_path('../templates', __FILE__)

    class_option :migrate, type: :boolean, default: true

    def create_push_type_initializer
      template 'push_type.rb', 'config/initializers/push_type.rb'
    end

    def inject_push_type_routes
      inject_into_file 'config/routes.rb', "\n\n#{ mount_heredoc }", after: 'Rails.application.routes.draw do', verbose: true
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

    private

    def mount_heredoc
      <<-EOF.gsub /^\s+/, '  '
        # Mount all the registered PushType Rails Engines. This should be placed
        # at the end of your routes.rb file to ensure your application routes are
        # not overidden by PushType.
        #
        # Overide the default mount points by passing a hash of options.
        # Example:
        #
        #   mount_push_type admin: 'cms', front_end: 'blog'
        #
        mount_push_type

      EOF
    end

  end
end