require_dependency "push_type/admin_controller"

module PushType
  class Admin::ProfilesController < AdminController

    before_action :load_user

    def edit
    end

    def update
      if update_user profile_params
        flash[:notice] = 'Profile successfully updated.'
        bypass_sign_in @user
        redirect_to push_type_admin.edit_profile_path
      else
        render 'edit'
      end
    end

    private

    def initial_breadcrumb
      breadcrumbs.add 'Profile', push_type_admin.edit_profile_path
    end

    def load_user
      @user = current_user
    end

    def update_user(user_params)
      if password_required?
        @user.update_with_password user_params
      else
        user_params.delete :current_password
        @user.update_without_password user_params
      end
    end

    def password_required?
      profile_params[:password].present? || profile_params[:password_confirmation].present?
    end

    def profile_params
      fields = [:name, :email, :current_password, :password, :password_confirmation] + @user.fields.keys
      params.fetch(:user, {}).permit(*fields)
    end

  end
end
