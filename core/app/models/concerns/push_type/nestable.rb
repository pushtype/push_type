module PushType
  module Nestable
    extend ActiveSupport::Concern

    def child_node_types
      self.class.child_node_types
    end

    def custom_child_order?
      self.class.child_node_order.present?
    end

    def sortable?
      !custom_child_order?
    end

    def children
      return super() unless custom_child_order?
      super.reorder(self.class.child_node_order)
    end

    module ClassMethods

      attr_reader :child_node_order

      def child_node_types
        types = @child_node_types || PushType.config.root_node_types
        PushType.node_types_from_list(types)
      end

      def has_child_nodes(*args)
        if args.last.is_a? Hash
          opts = args.pop
          @child_node_order = case opts[:order]
            when :blog then ['published_at DESC', 'created_at DESC']
            else opts[:order]
          end
        else
          @child_node_order = nil
        end
        @child_node_types = args
      end

    end

  end
end