module ActionDispatch::Routing
  class Mapper

    def mount_push_type(options = {})
      opts = {
        path:   '/push_type',
        home:   PushType.config.home_slug,
        actions: {
          node: 'push_type/nodes_front_end#show'
        }
      }.deep_merge!(options)

      # Mount the PushType engine at the specified path.
      mount PushType::Core::Engine => opts[:path]

      # Use a Dragonfly endpoint to provide better URLs for accessing assets
      get 'media/*file_uid' => Dragonfly.app.endpoint { |params, app|
        file_name = [ params[:file_uid], params[:format] ].join('.')
        asset = PushType::Asset.find_by_file_uid! file_name
        asset.media params[:style]
      }, as: 'media'

      # Taxonomies
      PushType.taxonomy_classes.each do |tax|
        get "#{ tax.base_slug }/*permalink" => 'font_end#taxonomy', as: 'taxonomy', taxonomy: tax.base_slug if tax.exposed?
      end

      # A catch-all root for the nodes
      get '*permalink' => opts[:actions][:node], as: 'node'
      root to: opts[:actions][:node], permalink: opts[:home]
    end
    
  end
end