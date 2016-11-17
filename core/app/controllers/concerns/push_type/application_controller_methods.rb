module PushType
  module ApplicationControllerMethods
    extend ActiveSupport::Concern

    FILTERS = [
      :before_node_load_filters, :before_node_action_filters, :after_node_action_filters
    ]

    included do
      class_attribute *FILTERS
      helper PushType::MediaUrlHelper
      helper PushType::NodeUrlHelper
    end

    protected

    def permalink_path
      params[:permalink].split('/')
    end

    private

    FILTERS.each do |filter|
      define_method(filter) { self.class.send(filter) }
    end

    module ClassMethods
      FILTERS.each do |filter|
        method_name = filter.to_s.gsub(/_filters$/, '')

        define_method method_name do |*args, &block|
          args.push block if block
          filters = ( self.send(filter) || [] ) << args
          self.send "#{ filter }=", filters
        end
      end
    end

  end
end