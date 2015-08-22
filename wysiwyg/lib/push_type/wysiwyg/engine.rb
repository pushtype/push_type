module PushType
  module Wysiwyg
    class Engine < ::Rails::Engine
      isolate_namespace PushType
      engine_name 'push_type_wysiwyg'

      config.generators do |g|
        g.assets false
        g.helper false
        g.test_framework  :test_unit, fixture: false
      end

      initializer 'push_type.wysiwyg_assets' do
        PushType.admin_assets.register 'push_type/wysiwyg'
      end
    end
  end
end