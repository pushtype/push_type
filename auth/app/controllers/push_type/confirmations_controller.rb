module PushType
  class ConfirmationsController < Devise::ConfirmationsController
    layout 'push_type/auth'

    def show
      self.resource = resource_class.find_by_confirmation_token params[:confirmation_token]
      super if resource.nil? or resource.confirmed?
    end

    def update
      self.resource = resource_class.find_by_confirmation_token! user_params[:confirmation_token]
      resource.assign_attributes(user_params)

      if resource.valid?
        self.resource.confirm
        set_flash_message :notice, :confirmed
        sign_in_and_redirect resource_name, resource
      else
        render action: 'show'
      end
    end

    private

    def user_params
      params.fetch(resource_name, {}).permit(:confirmation_token, :password, :password_confirmation)
    end

  end
end
