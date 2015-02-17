module PushType
  module ApplicationControllerMethods
    extend ActiveSupport::Concern

    protected

    def permalink_path
      params[:permalink].split('/')
    end

    private

    def node_hook(method)
      send(method) if self.class.method_defined?(method.to_sym)
    end

  end
end