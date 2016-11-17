module ActionDispatch::Routing
  class Mapper

    def mount_push_type(opts = {})
      # Mount the registered PushType engines at the specified path.
      PushType.rails_engines.each do |k, (mod, default_path)|
        key  = push_type_engine_keys[k] || k
        path = opts[key] || default_path
        mount mod::Engine => path
      end

      scope path: opts[:front_end] do
        # Use a Dragonfly endpoint to provide better URLs for accessing assets
        get 'media/*file_uid' => Dragonfly.app.endpoint { |params, app|
          file_name = [ params[:file_uid], params[:format] ].join('.')
          asset = PushType::Asset.find_by_file_uid! file_name
          asset.media params[:style]
        }, as: 'media'

        get '/node/preview/:id' => 'front_end#preview', as: 'preview_node'
        get '*permalink'    => 'front_end#show',    as: 'node'
        get '/' => 'front_end#show', as: 'home_node', permalink: PushType.config.home_slug if PushType.config.home_slug.present?
      end
    end

    private

    def push_type_engine_keys
      {
        push_type_api:    :api,
        push_type_admin:  :admin
      }
    end
    
  end
end