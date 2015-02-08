module PushType
  module AssetsHelper

    def assets_array(assets)
      assets.map { |a| asset_hash(a) }
    end

    def asset_hash(asset)
      hash = [ :id, :file_name, :file_size, :mime_type, :created_at, :new_record?, :image?, :description_or_file_name ].inject({}) do |h, att|
        h.update att => asset.send(att)
      end
      hash.update preview_thumb_url: asset_preview_thumb_url(asset)
    end

    def asset_preview_thumb_url(asset)
      if asset.image?
        main_app.media_path(file_uid: asset.file_uid, style: :push_type_thumb)
      else
        image_path(asset_icon(asset))
      end
    end

    def asset_icon(asset)
      "push_type/icon-file-#{ asset.kind }.png"
    end

  end
end
