module PushType
  module Admin
    class Engine < ::Rails::Engine
      isolate_namespace PushType
      engine_name 'push_type_admin'

      config.generators do |g|
        g.assets false
        g.helper false
        g.test_framework  :test_unit, fixture: false
      end

      config.assets.precompile += %w(
        push_type/admin.css
        push_type/admin.js
        push_type/admin_assets.css 
        push_type/admin_assets.js
      )

      initializer 'push_type_admin.menus' do
        PushType.menu :main do
          element :ul
          html_options class: 'left'

          item :content do
            link    { push_type_admin.nodes_path }
            active  { request.fullpath.match %r{^#{ push_type_admin.nodes_path }} }
          end
          item :media do
            link    { push_type_admin.assets_path }
            active  { request.fullpath.match %r{^#{ push_type_admin.assets_path }} }
          end
          item :users do
            link    { push_type_admin.users_path }
            active  { request.fullpath.match %r{^#{ push_type_admin.users_path }} }
          end
        end

        PushType.menu :utility do
          element :ul
          html_options class: 'right'

          item :info do
            text    { ficon(:info) }
            link    { push_type_admin.info_path }
            link_options data: { :'reveal-id' => 'reveal-ajax', :'reveal-ajax' => true }
          end
        end
      end

    end
  end
end
