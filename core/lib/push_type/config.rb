module PushType

  # The config module provides attributes used for configuring the
  # PushType installation. The `PushType::InstallGenerator` creates
  # a config initializer at `config/initializers/push_type.rb`.
  #
  module Config

    # Node types that can be created at the content tree root 
    mattr_accessor :root_nodes
    @@root_nodes = :all

    # Slug of the node used for the site's 'home'
    mattr_accessor :home_slug
    @@home_slug = 'home'

    # Node types that are not exposed to the front end
    mattr_accessor :unexposed_nodes
    @@unexposed_nodes = []

    # Hash of geometry strings used for resizing images
    mattr_accessor :media_styles
    @@media_styles = {
      large:    '1024x1024>',
      medium:   '512x512>',
      small:    '256x256>'
    }

    # Address which sends PushType/Devise emails
    mattr_accessor :mailer_sender
    @@mailer_sender = 'pushtype@example.com'

    # Dragonfly datastore type
    mattr_accessor :dragonfly_datastore
    @@dragonfly_datastore = nil

    # Hash of options for dragonfly datastore
    mattr_accessor :dragonfly_datastore_options
    @@dragonfly_datastore_options = nil

    # Secret key used by dragonfly
    mattr_accessor :dragonfly_secret
    @@dragonfly_secret = nil

  end
end