module PushType
  module Auth
    class Engine < ::Rails::Engine
      isolate_namespace PushType
      engine_name 'push_type_auth'

      config.generators do |g|
        g.assets false
        g.helper false
        g.test_framework  :test_unit, fixture: false
      end

      config.to_prepare do
        # Make User authenticatable
        PushType::User.include PushType::Authenticatable
        
        # Extend controllers with auth/invitation methos
        PushType::AdminController.include PushType::AuthenticationMethods
        PushType::UsersController.include PushType::InvitationMethods
        
        # Configure devise with helpers and layout
        DeviseController.helper PushType::AdminHelper
        Devise::Mailer.layout 'push_type/email'
      end

      initializer 'push_type_auth.devise_config' do
        Devise.mailer_sender = PushType.config.mailer_sender
        Devise.router_name = :push_type
      end

      initializer 'push_type.auth_assets' do
        ActiveSupport.on_load :push_type_admin do
          admin_assets.javascripts << 'push_type/auth'
        end
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
