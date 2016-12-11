module PushType
  module MediaUrlHelper

    include ActionView::Helpers::AssetUrlHelper

    URI_REGEXP = %r{^https?://}i

    def media_path(source, options = {})
      file_uid  = source.try(:file_uid) || source
      path      = main_app.media_path(file_uid, options)

      if host = compute_asset_host(path, options)
        url = File.join(host, path)
      else
        path
      end
    end

    def media_url(source, options = {})
      file_uid  = source.try(:file_uid) || source
      path      = media_path(source)
      return path if path =~ URI_REGEXP
      main_app.media_url(file_uid, options)
    end

  end
end
