module PushType
  module Core
    class Engine < ::Rails::Engine
      isolate_namespace PushType
      engine_name 'push_type'

      config.root_nodes = :all

      config.home_slug = 'home'

      config.unexposed_nodes = []

      config.media_styles = {
        large:    '1024x1024>',
        medium:   '512x512>',
        small:    '256x256>'
      }

      config.generators do |g|
          g.assets false
          g.helper false
          g.test_framework  :minitest, spec: true, fixture: false
        end

      config.autoload_paths << config.root.join('app', 'fields')

      config.to_prepare do
        Rails.application.eager_load! unless Rails.application.config.cache_classes
      end
    end
  end
end
