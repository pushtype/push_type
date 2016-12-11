module PushType
  class AdminController < ActionController::Base

    layout 'push_type/admin'
    before_action :initial_breadcrumb
    helper_method :push_type_user

    helper PushType::Admin::Engine.helpers

    def info
      render layout: false
    end

    protected

    def push_type_user
      respond_to?(:current_user) ? current_user : nil
    end

    def initial_breadcrumb
      true
    end
    
  end
end
