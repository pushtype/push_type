require_dependency "push_type/admin_controller"

module PushType
  class WysiwygMediaController < AdminController

    before_filter :load_assets, only: :index
    before_filter :build_asset, only: :create

    def index
      respond_to do |format|
        format.json { render json: view_context.wysiwyg_assets_hash(@assets) }
      end
    end

    def create
      respond_to do |format|
        format.json do
          if @asset.save 
            render json: { link: main_app.media_url(@asset.file_uid) }
          else
            render json: { error: @asset.errors.full_messages.first }
          end
        end
      end
    end

    private

    def load_assets
      query = PushType::Asset.not_trash.page(params[:page]).per(12)
      @assets = params[:filter] == 'image' ? query.image : query.not_image
    end

    def build_asset
      @asset = PushType::Asset.new asset_params.merge(uploader: push_type_user)
    end

    def asset_params
      params.fetch(:asset, {}).permit(:file)
    end

  end
end
