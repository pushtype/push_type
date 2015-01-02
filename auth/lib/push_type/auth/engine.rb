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
        PushType::AdminController.send :include, PushType::AuthenticationMethods
        PushType::UsersController.send :include, PushType::InvitationMethods
        DeviseController.helper PushType::AdminHelper
      end
    end
  end
end
