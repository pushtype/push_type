module PushType
  module Filterable
    extend ActiveSupport::Concern

    private

    def filter_scope
      self.class.filter_scope
    end

    def filter_obj
      instance_variable_get "@#{ filter_scope }"
    end

    def filter_obj_type
      filter_obj.type.underscore.to_sym
    end

    def before_load_filters
      filters = self.send("before_#{ filter_scope }_load_filters")
      filters.each { |f| run_node_hook(*f) } unless filters.blank?
    end

    def around_action_filters
      before_filters = self.send("before_#{ filter_scope }_action_filters")
      before_filters.each { |f| run_node_hook(*f) } unless before_filters.blank?
      yield
      after_filters = self.send("after_#{ filter_scope }_action_filters")
      after_filters.each { |f| run_node_hook(*f) } unless after_filters.blank?
    end

    def run_node_hook(*args)
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
      types && filter_obj && Array(types).include?(filter_obj_type)
    end

    def filter_obj_not_in(types)
      types && filter_obj && !Array(types).include?(filter_obj_type)
    end

    module ClassMethods

      attr_reader :filter_scope

      def hooks_for(sym)
        @filter_scope = sym
        prepend_before_action :before_load_filters,   only: :show
        around_action :around_action_filters, only: :show
      end

    end

  end
end