module PushType
  module Auth
    class Engine < ::Rails::Engine
      isolate_namespace PushType
      engine_name 'push_type_auth'

      config.generators do |g|
        g.assets false
        g.helper false
        g.test_framework  :minitest, spec: true, fixture: false
      end

      config.to_prepare do
        PushType::User.send :include, PushType::Authenticatable
      end

      initializer 'push_type_auth.extend_controllers' do
        PushType::AdminController.send :include, PushType::AuthenticationMethods
        PushType::UsersController.send :include, PushType::InvitationMethods
      end

      initializer 'push_type_auth.extend_helpers' do
        DeviseController.helper PushType::AdminHelper
      end

      initializer 'push_type_auth.menus' do
        PushType.menu :utility do
          item :settings do
            text  { ficon(:widget) }
            link  { push_type.edit_profile_path }
          end
          item :sign_out do
            text  { ficon(:power) }
            link  { push_type.destroy_user_session_path }
            link_options method: 'delete'
          end
        end
      end

    end
  end
end
