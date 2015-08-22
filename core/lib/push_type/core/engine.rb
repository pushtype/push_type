module PushType
  module Core
    class Engine < ::Rails::Engine
      isolate_namespace PushType
      engine_name 'push_type'

      config.generators do |g|
        g.assets false
        g.helper false
        g.test_framework  :test_unit, fixture: false
      end

      config.autoload_paths << config.root.join('app', 'fields')
      config.autoload_paths << config.root.join('app', 'presenters')

      config.to_prepare do
        Rails.application.eager_load! unless Rails.application.config.cache_classes
      end

      initializer 'push_type.dragonfly_config' do
        PushType.config.dragonfly_secret ||= Rails.application.secrets.secret_key_base
        PushType.dragonfly_app_setup!
      end

      initializer 'push_type.application_controller' do
        ActiveSupport.on_load(:action_controller) do
          include PushType::ApplicationControllerMethods
        end
      end

      initializer 'push_type.menu_helpers' do
        ActiveSupport.on_load(:action_view) do
          include PushType::MenuBuilder::Helpers
        end
      end
    end
  end
end
