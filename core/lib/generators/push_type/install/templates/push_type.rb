PushType.setup do |config|

  config.root_nodes = :all

  config.unexposed_nodes = []

  config.home_slug = 'home'

  config.media_styles = {
    large:    '1024x1024>',
    medium:   '512x512>',
    small:    '256x256>'
  }

  # Configure the default mailer "from" address
  config.mailer_sender = 'pushtype@example.com'

  # Dragonfly datastore configuration
  config.dragonfly_datastore = :file
  config.dragonfly_datastore_options = {
    root_path:    Rails.root.join('public/system/dragonfly', Rails.env),
    server_root:  Rails.root.join('public')
  }
  
  # For S3 storage, remember to add to Gemfile:
  # gem 'dragonfly-s3_data_store'
  # config.dragonfly_datastore = :s3
  # config.dragonfly_datastore_options = {
  #   bucket_name:        ENV['S3_BUCKET'],
  #   access_key_id:      ENV['S3_ACCESS_KEY_ID'],
  #   secret_access_key:  ENV['SECRET_ACCESS_KEY_ID']
  # }

  # config.dragonfly_secret = '<%= SecureRandom.hex(32) %>'

end