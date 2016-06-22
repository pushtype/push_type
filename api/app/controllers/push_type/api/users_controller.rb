require_dependency "push_type/api_controller"

module PushType
  class Api::UsersController < ApiController

    before_action :build_user, only: [:create]
    before_action :load_user,  only: [:show, :update, :destroy]

    def index
      @users = user_scope.page(params[:page]).per(30)
    end

    def show
    end

    def create
      if @user.save
        render :show, status: :created
      else
        render json: { errors: @user.errors }, status: :unprocessable_entity
      end
    end

    def update
      if @user.update_attributes user_params_with_fields
        render :show
      else
        render json: { errors: @user.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      if @user != push_type_user
        @user.destroy
        head :no_content
      else
        head :bad_request
      end
    end

    private

    def user_scope
      PushType::User
    end

    def build_user
      @user = user_scope.new
      @user.attributes = @user.attributes.merge(user_params_with_fields.to_h)
    end

    def load_user
      @user = user_scope.find params[:id]
    end

    def user_params
      @node_params ||= params.fetch(:user, {}).permit(:name, :email)
    end

    def user_params_with_fields
      user_params.tap do |whitelist|
        @user.fields.keys.each { |k| whitelist[k] = params[:user][k] if params[:user][k].present? }
      end
    end

  end
end
