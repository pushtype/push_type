module PushType
  class AdminController < ActionController::Base

    protect_from_forgery with: :exception
    layout 'push_type/admin'

    def app
    end
    
  end
end
