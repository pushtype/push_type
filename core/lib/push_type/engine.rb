module PushType
  class Engine < ::Rails::Engine
    isolate_namespace PushType
    engine_name 'push_type'

    config.root_node_types = :all

    config.home_node = 'home'

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
