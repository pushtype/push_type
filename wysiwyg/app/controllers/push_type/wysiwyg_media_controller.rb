require_dependency "push_type/admin_controller"

module PushType
  class WysiwygMediaController < AdminController

    before_filter :load_assets, only: :index
    before_filter :build_asset, only: :create

    respond_to :json

    def index
      respond_with assets_to_hash
    end

    def create
      respond_with save_asset, location: false
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

    def save_asset
      if @asset.save
        { link: main_app.media_url(@asset.file_uid) }
      else
        { error: @asset.errors.full_messages.first }
      end
    end

    def assets_to_hash
      {
        assets: @assets.map { |a| asset_to_hash(a) },
        current_page: @assets.current_page,
        total_pages: @assets.total_pages
      }
      
    end

    def asset_to_hash(a)
      {
        src: a.image? ? main_app.media_url(a.file_uid, style: '300x300#') : ActionController::Base.helpers.image_url("push_type/icon-file-#{ a.kind }.png"),
        info: {
          id:    a.id,
          kind:  a.kind,
          src:   main_app.media_url(a.file_uid),
          title: a.description_or_file_name
        }
      }
    end

  end
end
