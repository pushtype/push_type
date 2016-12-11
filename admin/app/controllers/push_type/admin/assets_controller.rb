require_dependency "push_type/admin_controller"

module PushType
  class Admin::AssetsController < AdminController

    include PushType::AssetsHelper

    before_action :build_asset, only: [:new, :create, :upload]
    before_action :load_asset,  only: [:edit, :update, :destroy, :restore]

    def index
      respond_to do |format|
        format.html do
          @assets = PushType::Asset.not_trash.page(params[:page]).per(20)
        end
        format.json do
          @assets = PushType::Asset.not_trash.page(params[:page]).per(12)
          render json: { assets: assets_array(@assets).as_json, meta: { current_page: @assets.current_page, total_pages: @assets.total_pages } }
        end
      end
    end

    def trash
      @assets = PushType::Asset.trashed.page(params[:page]).per(20)
    end

    def new
    end

    def create
      if @asset.save
        flash[:notice] = 'File successfully uploaded.'
        redirect_to push_type_admin.assets_path
      else
        render 'new'
      end
    end

    def upload
      respond_to do |format|
        format.json do
          if @asset.save
            hash = params[:froala] ? { link: media_path(@asset) } : { asset: asset_hash(@asset).as_json }
            render json: hash, status: :created
          else
            hash = params[:froala] ? { error: @asset.errors.full_messages.first } : { errors: @asset.errors.as_json }
            render json: hash, status: :unprocessable_entity
          end
        end
      end
    end

    def edit
    end

    def update
      if @asset.update_attributes asset_params
        flash[:notice] = 'Media successfully updated.'
        redirect_to push_type_admin.assets_path
      else
        render 'edit'
      end
    end

    def destroy
      if @asset.trashed?
        @asset.destroy
        flash[:notice] = 'Media permanently deleted.'
        redirect_to push_type_admin.trash_assets_path
      else
        @asset.trash!
        flash[:notice] = 'Media trashed.'
        redirect_to push_type_admin.assets_path
      end
    end

    def restore
      @asset.restore!
      flash[:notice] = 'Media successfully restored.'
      redirect_to push_type_admin.assets_path
    end

    def empty
      PushType::Asset.trashed.destroy_all
      flash[:notice] = 'Trash successfully emptied.'
      redirect_to push_type_admin.assets_path
    end

    private

    def initial_breadcrumb
      breadcrumbs.add 'Media', push_type_admin.assets_path
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
