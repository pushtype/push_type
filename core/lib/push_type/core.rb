require 'closure_tree'
require 'dragonfly'

require 'push_type/core_ext/to_bool'

module PushType

  class << self

    def version
      PushType::VERSION
    end

    def config
      PushType::Config
    end

    def setup(&block)
      yield config if block
    end

    def root_nodes
      subclasses_from_list(:node, config.root_nodes)
    end

    def unexposed_nodes
      subclasses_from_list(:node, config.unexposed_nodes)
    end

    def subclasses_from_list(scope, types = nil)
      return [] unless types
      descendants = "push_type/#{ scope }".camelcase.constantize.descendants.map { |c| c.name.underscore }
      types_array = Array.wrap(types)

      if types_array.include? :all
        descendants
      else
        descendants & types_array.map(&:to_s)
      end.sort
    end

    def dragonfly_app_setup!
      Dragonfly.app.configure do
        plugin      :imagemagick
        url_format  "/media/:job/:name"
        secret      PushType.config.dragonfly_secret
        datastore   PushType.config.dragonfly_datastore, PushType.config.dragonfly_datastore_options
      end
    end

    def menu(key, &block)
      PushType::MenuBuilder.select(key, &block)
    end

    def register_engine(mod, opts = {})
      opts[:load_hook] ||= mod.to_s.underscore.gsub(/\//, '_').to_sym

      if opts[:mount]
        rails_engines[opts[:load_hook]] = [mod, opts[:mount]]
      end
      
      ActiveSupport.run_load_hooks(opts[:load_hook], PushType)
    end

    def rails_engines
      @rails_engines ||= {}
    end

  end

  module Core
    PushType.register_engine self
  end

end

require 'push_type/config'
require 'push_type/core/engine'
require 'push_type/rails/routes'
require 'push_type/field_type'
require 'push_type/menu_builder'
require 'push_type/presenter'
require 'push_type/version'