module PushType
  module Authenticatable
    extend ActiveSupport::Concern

    included do
      acts_as_token_authenticatable
      
      # Include default devise modules. Others available are:
      # :lockable, :timeoutable and :omniauthable
      devise :database_authenticatable, :confirmable, :recoverable, :rememberable, :trackable, :validatable

      def after_database_authentication
        reset_authentication_token
      end

      protected

      def password_required?
        persisted? ? super : false
      end
    end

    def reset_authentication_token
      update_attribute :authentication_token, nil
    end

  end
end