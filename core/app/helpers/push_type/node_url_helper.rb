module PushType
  module NodeUrlHelper

    def node_path(source, options = {})
      permalink = source.try(:permalink) || source
      main_app.node_path(permalink, options)
    end

    def node_url(source, options = {})
      permalink = source.try(:permalink) || source
      main_app.node_url(permalink, options)
    end

  end
end
