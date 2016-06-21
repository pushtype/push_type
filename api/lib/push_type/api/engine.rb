module PushType
  module Api
    class Engine < ::Rails::Engine
      isolate_namespace PushType
      engine_name 'push_type_api'

      config.generators do |g|
        g.assets false
        g.helper false
        g.test_framework  :test_unit, fixture: false
      end
      
    end
  end
end
