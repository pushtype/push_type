require_dependency "push_type/admin_controller"

module PushType
  class AssetsController < AdminController

    before_filter :build_asset, only: [:new, :create, :upload]
    before_filter :load_asset,  only: [:edit, :update, :destroy]

    def index
      @assets = PushType::Asset.not_trash.page(params[:page]).per(20)
    end

    def new
    end

    def create
      if @asset.save
        flash[:notice] = 'File successfully uploaded.'
        redirect_to push_type.assets_path
      else
        render 'new'
      end
    end

    def upload
      respond_to do |format|
        format.json do
          if @asset.save
            render json: { asset: view_context.asset_hash(@asset).as_json }, status: :created
          else
            render json: { errors: @asset.errors.as_json }, status: :unprocessable_entity
          end
        end
      end
    end

    def edit
    end

    def update
      if @asset.update_attributes asset_params
        flash[:notice] = 'Media successfully updated.'
        redirect_to push_type.assets_path
      else
        render 'edit'
      end
    end

    def destroy
      @asset.trash!
      flash[:notice] = 'Media trashed.'
      redirect_to push_type.assets_path
    end

    private

    def initial_breadcrumb
      breadcrumbs.add 'Media', push_type.assets_path
    end

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
