require 'closure_tree'
require 'dragonfly'

module PushType

  class << self

    def config
      PushType::Core::Engine.config
    end

    def setup(&block)
      yield config if block
    end

    def root_nodes
      node_types_from_list(config.root_nodes)
    end

    def unexposed_nodes
      node_types_from_list(config.unexposed_nodes).map(&:camelcase)
    end

    def node_types_from_list(types = nil)
      return [] unless types
      types_array = Array.wrap(types)
      if types_array.include? :all
        PushType::Node.descendants.map(&:name).map(&:underscore)
      else
        types_array.map(&:to_s).select do |kind|
          begin
            kind.camelcase.constantize.ancestors.include? PushType::Node
          rescue NameError
            false
          end
        end
      end.sort
    end
  end

  module Core
  end
end

require 'push_type/core/engine'
require 'push_type/rails/routes'
require 'push_type/field_type'
