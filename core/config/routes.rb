PushType::Core::Engine.routes.draw do

  # Use a Dragonfly endpoint to provide better URLs for accessing assets
  get 'media/*file_uid' => Dragonfly.app.endpoint { |params, app|
    file_name = [ params[:file_uid], params[:format] ].join('.')
    asset = PushType::Asset.find_by_file_uid! file_name
    asset.media params[:style]
  }, as: 'media'

  # A catch-all root for the nodes
  get '*permalink' => 'front_end#show', as: 'node'
  root to: 'front_end#show', permalink: PushType.config.home_slug

end
