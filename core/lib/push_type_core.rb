require 'closure_tree'
require 'dragonfly'

module PushType

  class << self

    def config
      PushType::Engine.config
    end

    def setup(&block)
      yield config if block
    end

    def root_node_types
      node_types_from_list(config.root_node_types)
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
      end
    end
  end

  module Core
  end
end

require_relative 'push_type/engine'
require_relative 'push_type/rails/routes'
require_relative 'push_type/field_type'


