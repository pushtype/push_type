module PushType
  module AssetsHelper

    def asset_icon(asset)
      kind = case asset.file.mime_type
        when /\Aimage\/.*\z/ then 'image'
        when /\Aaudio\/.*\z/ then 'audio'
        when /\Avideo\/.*\z/ then 'video'
        else 'document'
      end
      "push_type/icon-file-#{ kind }.png"
    end

  end
end
