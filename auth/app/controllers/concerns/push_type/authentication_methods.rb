module PushType
  module AuthenticationMethods
    extend ActiveSupport::Concern

    included do
      before_action :authenticate_user!
    end

    protected

    def authenticate_user!
      if user_signed_in?
        super
      else
        redirect_to push_type_admin.new_user_session_path, alert: t('devise.failure.unauthenticated')
      end
    end

  end
end