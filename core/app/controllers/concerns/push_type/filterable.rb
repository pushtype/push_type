module PushType
  module Filterable
    extend ActiveSupport::Concern

    private

    def before_load_filters
      filters = self.send("before_node_load_filters")
      filters.each { |f| run_node_filter(*f) } unless filters.blank?
    end

    def around_action_filters
      before_filters = self.send("before_node_action_filters")
      before_filters.each { |f| run_node_filter(*f) } unless before_filters.blank?
      yield
      after_filters = self.send("after_node_action_filters")
      after_filters.each { |f| run_node_filter(*f) } unless after_filters.blank?
    end

    def run_node_filter(*args)
      methods_or_proc, opts = case args.last
        when Proc then args.first.is_a?(Hash) ? [ args.last, args.first ] : [ args.last, {} ]
        when Hash then [ args[0..-2], args.last ]
        else [ args, {} ]
      end

      unless filter_obj_not_in(opts[:only]) || filter_obj_in(opts[:except])
        if methods_or_proc.respond_to?(:call)
          instance_exec(&methods_or_proc)
        else
          Array(methods_or_proc).each { |m| send(m) }
        end
      end
    end

    def filter_obj_in(types)
      types && @node && Array(types).include?(@node.type.underscore.to_sym)
    end

    def filter_obj_not_in(types)
      types && @node && !Array(types).include?(@node.type.underscore.to_sym)
    end

    module ClassMethods

      def node_filters
        prepend_before_action :before_load_filters
        around_action :around_action_filters
      end

    end

  end
end