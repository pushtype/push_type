module PushType
  module ApiAuthenticationMethods
    extend ActiveSupport::Concern

    included do
      before_action :authenticate_user!
    end

    protected

    def authenticate_user!
      unless current_push_type_user
        head(:unauthorized)
      end
    end

    def current_push_type_user
      @current_push_type_user ||= begin
        Knock::AuthToken.new(token: auth_token).entity_for(PushType::User)
      rescue
        nil
      end
    end

    def auth_token
      params[:token] || request.headers['Authorization'].try(:split).try(:last)
    end

  end
end