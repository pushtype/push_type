module PushType
  module Nestable
    extend ActiveSupport::Concern

    def child_node_types
      self.class.child_node_types
    end

    module ClassMethods

      def child_node_types
        types = @child_node_types || PushType.config.root_node_types
        PushType.node_types_from_list(types)
      end

      def has_child_nodes(*args)
        @child_node_types = args
      end

    end

  end
end