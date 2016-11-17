module PushType
  class AuthController < ActionController::Base

    include AuthHelper

    protected

    def after_sign_in_path_for(resource_or_scope)
      stored_location_for(resource_or_scope) || push_type_admin.root_path
    end

    def after_sign_out_path_for(resource_or_scope)
      push_type_admin.new_user_session_path
    end

  end
end
