json.assets @assets do |asset|
  json.partial! 'asset', asset: asset

  json.links do
    json.url      media_path(asset)
    json.preview  asset.image? ? media_path(asset, style: :push_type_thumb) : image_path("push_type/icons-assets.svg##{ asset.kind }")
  end
end

json.meta do
  json.partial! 'push_type/api/shared/pagination', collection: @assets
end
