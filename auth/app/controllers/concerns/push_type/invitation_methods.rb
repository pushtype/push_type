module PushType
  module InvitationMethods
    extend ActiveSupport::Concern

    def invite
      load_user
      @user.resend_confirmation_instructions
      flash[:notice] = 'Sign up instructions have been resent to the user.'
      redirect_to :back
    end

  end
end