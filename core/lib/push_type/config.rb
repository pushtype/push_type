module PushType
  module Config

    mattr_accessor :root_nodes
    @@root_nodes = :all

    mattr_accessor :unexposed_nodes
    @@unexposed_nodes = []

    mattr_accessor :home_slug
    @@home_slug = 'home'

    mattr_accessor :media_styles
    @@media_styles = {
      large:    '1024x1024>',
      medium:   '512x512>',
      small:    '256x256>'
    }

    mattr_accessor :mailer_sender
    @@mailer_sender = 'pushtype@example.com'

    mattr_accessor :dragonfly_datastore
    @@dragonfly_datastore = nil

    mattr_accessor :dragonfly_datastore_options
    @@dragonfly_datastore_options = nil

    mattr_accessor :dragonfly_secret
    @@dragonfly_secret = nil

  end
end