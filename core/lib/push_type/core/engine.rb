module PushType
  module Core
    class Engine < ::Rails::Engine
      isolate_namespace PushType
      engine_name 'push_type'

      config.generators do |g|
          g.assets false
          g.helper false
          g.test_framework  :minitest, spec: true, fixture: false
        end

      config.autoload_paths << config.root.join('app', 'fields')

      config.to_prepare do
        Rails.application.eager_load! unless Rails.application.config.cache_classes
        ApplicationController.send :include, PushType::ApplicationControllerMethods
      end

      initializer 'push_type.dragonfly_config' do
        PushType.config.dragonfly_secret ||= Rails.application.secrets.secret_key_base
        PushType.dragonfly_app_setup!
      end
      
    end
  end
end
