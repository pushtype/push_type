module PushType
  module ApplicationControllerMethods
    extend ActiveSupport::Concern

    included do
      class_attribute :before_load_filters, :before_node_filters, :after_node_filters
    end

    protected

    def permalink_path
      params[:permalink].split('/')
    end

    private

    def before_load_filters
      self.class.before_load_filters
    end

    def before_node_filters
      self.class.before_node_filters
    end

    def after_node_filters
      self.class.after_node_filters
    end

    def run_node_hook(*args)
      methods_or_proc, opts = case args.last
        when Proc then args.first.is_a?(Hash) ? [ args.last, args.first ] : [ args.last, {} ]
        when Hash then [ args[0..-2], args.last ]
        else [ args, {} ]
      end

      unless node_type_not_in_option(opts[:only]) || node_type_in_option(opts[:except])
        if methods_or_proc.respond_to?(:call)
          instance_exec(&methods_or_proc)
        else
          Array(methods_or_proc).each { |m| send(m) }
        end
      end
    end

    def node_type_in_option(types)
      types && @node && Array(types).include?(@node.type.underscore.to_sym)
    end

    def node_type_not_in_option(types)
      types && @node && !Array(types).include?(@node.type.underscore.to_sym)
    end

    module ClassMethods
      def before_node_load(*args, &block)
        args.push block if block_given?
        self.before_load_filters ||= []
        self.before_load_filters.push << args
      end

      def before_node_action(*args, &block)
        args.push block if block_given?
        self.before_node_filters ||= []
        self.before_node_filters << args
      end

      def after_node_action(*args, &block)
        args.push block if block_given?
        self.after_node_filters ||= []
        self.after_node_filters << args
      end
    end

  end
end