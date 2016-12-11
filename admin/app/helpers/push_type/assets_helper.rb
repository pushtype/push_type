module PushType
  module AssetsHelper

    include PushType::MediaUrlHelper

    def assets_array(assets)
      assets.map { |a| asset_hash(a) }
    end

    def asset_hash(asset)
      return nil if asset.nil?
      hash = [ :id, :file_name, :file_size, :mime_type, :created_at, :new_record?, :image?, :description_or_file_name ].inject({}) do |h, att|
        h.update att => asset.send(att)
      end
      hash.update url: media_path(asset), preview_thumb_url: asset_preview_thumb_url(asset) if asset.persisted?
      hash
    end

    def asset_preview_thumb_url(asset)
      if asset.image? && !asset.svg?
        media_path(asset, style: :push_type_thumb)
      else
        image_path(asset_icon(asset))
      end
    end

    def asset_icon(asset)
      "push_type/icons-assets.svg##{ asset.kind }"
    end

    def asset_back_link(asset)
      if asset.trashed?
        push_type_admin.trash_assets_path
      else
        push_type_admin.assets_path
      end
    end

  end
end
