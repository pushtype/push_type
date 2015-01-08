module ActionDispatch::Routing
  class Mapper

    def mount_push_type(options = {})
      opts = {
        path:   '/push_type',
        home:   PushType.config.home_node,
        actions: {
          node: 'front_end#node'
        }
      }.deep_merge!(options)

      # Mount the PushType engine at the specified path.
      mount PushType::Core::Engine => opts[:path]

      # Use a Dragonfly endpoint to provide better URLs for accessing assets
      get 'media/*file_uid' => Dragonfly.app.endpoint { |params, app|
        asset = PushType::Asset.find_by_file_uid( [params[:file_uid], params[:format]].join('.') )
        asset.media params[:style]
      }, as: 'media'

      # A catch-all root for the nodes
      get '*permalink' => opts[:actions][:node], as: 'node'
      root to: opts[:actions][:node], permalink: opts[:home]
    end
    
  end
end