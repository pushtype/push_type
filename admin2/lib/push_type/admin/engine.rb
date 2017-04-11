module PushType
  module Admin
    class Engine < ::Rails::Engine
      isolate_namespace PushType
      engine_name 'push_type_admin'

      config.generators do |g|
        g.assets false
        g.helper false
        g.test_framework :test_unit, fixture: false
      end

      config.assets.precompile += %w(
        push_type/admin.css
        push_type/admin.js
      )

      initializer "static assets" do |app|
        app.middleware.insert_before(::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public")
      end

    end
  end
end
