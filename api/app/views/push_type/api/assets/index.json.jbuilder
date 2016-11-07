json.assets @assets do |asset|
  json.partial! 'asset', asset: asset

  json.links do
    json.url      push_type.media_path(file_uid: asset.file_uid)
    json.preview  asset.image? ? push_type.media_path(file_uid: asset.file_uid, style: :push_type_thumb) : image_path("push_type/icons-assets.svg##{ asset.kind }")
  end
end

json.meta do
  json.partial! 'push_type/api/shared/pagination', collection: @assets
end
