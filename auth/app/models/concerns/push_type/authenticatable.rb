module PushType
  module Authenticatable
    extend ActiveSupport::Concern

    included do
      # Include default devise modules. Others available are:
      # :lockable, :timeoutable and :omniauthable
      devise :database_authenticatable, :confirmable, :recoverable, :rememberable, :trackable, :validatable

      protected

      def password_required?
        persisted? ? super : false
      end
    end

  end
end