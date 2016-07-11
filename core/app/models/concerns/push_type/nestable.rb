module PushType
  module Nestable
    extend ActiveSupport::Concern

    included do
      validate :parent_accepts_child
    end

    def child_nodes
      self.class.child_nodes
    end

    def custom_child_order?
      self.class.child_order.present?
    end

    def sortable?
      !custom_child_order?
    end

    def descendable?
      !child_nodes.empty?
    end

    def children
      return super() unless custom_child_order?
      super.reorder(self.class.child_order)
    end

    private

    def parent_accepts_child
      if parent_id.present?
        unless parent.child_nodes.include?(self.class.name.underscore)
          errors.add :parent_id, 'does not accept this child'
        end
      end
    end

    module ClassMethods

      attr_reader :child_order

      def child_nodes
        types = @child_nodes || PushType.config.root_nodes
        PushType.subclasses_from_list(:node, types)
      end

      def has_child_nodes(*args)
        if args.last.is_a? Hash
          opts = args.pop
          @child_order = case opts[:order]
            when :blog then ['published_at DESC', 'created_at DESC']
            else opts[:order]
          end
        else
          @child_order = nil
        end
        @child_nodes = args
      end

    end

  end
end