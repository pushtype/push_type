module PushType
  module WysiwygMediaHelper

    include PushType::AssetsHelper

    def wysiwyg_assets_hash(assets)
      {
        assets: assets.map { |a| wysiwyg_asset_hash(a) },
        meta:   wysiwyg_assets_meta(assets)
      } 
    end

    def wysiwyg_assets_meta(assets)
      {
        current_page: assets.current_page,
        total_pages:  assets.total_pages
      }
    end

    def wysiwyg_asset_hash(asset)
      {
        src: asset_preview_thumb_url(asset),
        info: {
          id:    asset.id,
          kind:  asset.kind,
          src:   main_app.media_url(asset.file_uid),
          title: asset.description_or_file_name
        }
      }
    end


  end
end
