module PushType
  class ApiController < ActionController::Base

    protect_from_forgery with: :null_session

    protected

    def push_type_user
      respond_to?(:current_user) ? current_user : nil
    end
    
  end
end
