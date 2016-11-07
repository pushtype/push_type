module ActionDispatch::Routing
  class Mapper

    def mount_push_type(opts = {})
      # Mount the registered PushType engines at the specified path.
      PushType.rails_engines.each do |k, (mod, default_path)|
        key  = push_type_shorthands[k] || k
        path = opts[key] || default_path
        mount mod::Engine => path
      end
    end

    private

    def push_type_shorthands
      {
        push_type_api:    :api,
        push_type_admin:  :admin,
        push_type_auth:   :auth,
        push_type_core:   :front_end
      }
    end
    
  end
end