module PushType
  module Wysiwyg
    class Engine < ::Rails::Engine
      isolate_namespace PushType
      engine_name 'push_type_rich_text'

      config.admin_assets.register 'push_type/wysiwyg' rescue nil

      config.generators do |g|
        g.assets false
        g.helper false
        g.test_framework  :minitest, spec: true, fixture: false
      end
    end
  end
end