module PushType
  class ConfirmationsController < Devise::ConfirmationsController
    layout 'push_type/auth'

    def show
      self.resource = resource_class.find_by_confirmation_token digested_token
      super if resource.nil? or resource.confirmed?
    end

    def update
      self.resource = resource_class.find_by_confirmation_token! digested_token
      resource.assign_attributes(permitted_params)

      if resource.valid?
        self.resource.confirm!
        set_flash_message :notice, :confirmed
        sign_in_and_redirect resource_name, resource
      else
        render action: 'show'
      end
    end

    private

    def permitted_params
      params.fetch(resource_name, {}).permit(:confirmation_token, :password, :password_confirmation)
    end

    def digested_token
      @digested_token ||= Devise.token_generator.digest(self, :confirmation_token, original_token)
    end

    def original_token
      @original_token ||= if params[:confirmation_token].present?
        params[:confirmation_token]
      elsif params[resource_name].try(:[], :confirmation_token).present?
        params[resource_name][:confirmation_token]
      end
    end

  end
end
