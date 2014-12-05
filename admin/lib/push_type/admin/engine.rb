module PushType
  module Admin
    class Engine < ::Rails::Engine
      isolate_namespace PushType
      engine_name 'push_type_admin'

      config.generators do |g|
        g.assets false
        g.helper false
        g.test_framework  :minitest, spec: true, fixture: false
      end

      config.assets.precompile += %w(push_type/admin.css push_type/admin.js)
    end
  end
end
