module ActionDispatch::Routing
  class Mapper

    def mount_push_type(options = {})
      opts = {
        path:   '/push_type',
        home:   PushType.config.home_node,
        actions: {
          node: 'push_type/front_end#node'
        }
      }.deep_merge!(options)

      mount PushType::Core::Engine => opts[:path]
      get '*permalink' => opts[:actions][:node], as: 'node'
      root to: opts[:actions][:node], permalink: opts[:home]
    end
    
  end
end