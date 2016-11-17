module PushType
  module Core
    class Engine < ::Rails::Engine
      isolate_namespace PushType
      engine_name 'push_type'

      config.generators do |g|
        g.assets false
        g.helper false
        g.test_framework  :test_unit, fixture: false
        g.hidden_namespaces << 'push_type:dummy' << 'push_type:field'
      end

      config.assets.precompile += %w(
        *.gif *.jpg *.png *.svg *.eot *.ttf *.woff *.woff2
      )

      config.to_prepare do
        Rails.application.eager_load! unless Rails.application.config.cache_classes
      end

      initializer 'push_type.dragonfly_config' do
        PushType.config.dragonfly_secret ||= Rails.application.secrets.secret_key_base
        PushType.dragonfly_app_setup!
      end

      initializer 'push_type.application_controller' do
        ActiveSupport.on_load :action_controller do
          include PushType::ApplicationControllerMethods
        end
      end

      initializer 'push_type.menu_helpers' do
        ActiveSupport.on_load :action_view do
          include PushType::MenuBuilder::Helpers
        end
      end
    end
  end
end
