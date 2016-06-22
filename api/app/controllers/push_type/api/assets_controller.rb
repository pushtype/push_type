require_dependency "push_type/api_controller"

module PushType
  class Api::AssetsController < ApiController

    before_action :build_asset, only: [:create]
    before_action :load_asset,  only: [:show, :update, :destroy, :restore]

    def index
      @assets = PushType::Asset.not_trash.page(params[:page]).per(12)
    end

    def trash
      @assets = PushType::Asset.trashed.page(params[:page]).per(12)
      render :index
    end

    def show
    end

    def create
      if @asset.save
        render :show, status: :created
      else
        render json: { errors: @asset.errors }, status: :unprocessable_entity
      end
    end

    def update
      if @asset.update_attributes asset_params
        render :show
      else
        render json: { errors: @asset.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      if @asset.trashed?
        @asset.destroy
        head :no_content
      else
        @asset.trash!
        render :show
      end
    end

    def restore
      @asset.restore!
      render :show
    end

    def empty
      PushType::Asset.trashed.destroy_all
      head :no_content
    end

    private

    def build_asset
      @asset = PushType::Asset.new asset_params.merge(uploader: push_type_user)
    end

    def load_asset
      @asset = PushType::Asset.find params[:id]
    end

    def asset_params
      params.fetch(:asset, {}).permit(:file, :description)
    end

  end
end
