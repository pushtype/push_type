module PushType
  class AuthController < ActionController::Base

    protected

    def after_sign_in_path_for(resource_or_scope)
      stored_location_for(resource_or_scope) || push_type_admin.root_path
    end

    def after_sign_out_path_for(resource_or_scope)
      if main_app.respond_to? :home_path
        main_app.home_path
      elsif main_app.respond_to :root_path
        main_app.root_path
      else
        '/'
      end
    end

  end
end
