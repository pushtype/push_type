module PushType
  module InvitationMethods
    extend ActiveSupport::Concern

    def invite
      load_user
      @user.resend_confirmation_instructions
      flash[:notice] = 'Sign up instructions have been resent to the user.'
      redirect_back fallback_location: push_type_admin.user_path(@user)
    end

  end
end