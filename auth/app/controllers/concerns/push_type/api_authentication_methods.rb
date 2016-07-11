module PushType
  module ApiAuthenticationMethods
    extend ActiveSupport::Concern

    included do
      acts_as_token_authentication_handler_for PushType::User, as: :user
    end

  end
end