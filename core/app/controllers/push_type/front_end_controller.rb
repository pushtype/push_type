module PushType
  class FrontEndController < ApplicationController

    include PushType::Filterable

    before_action :load_node, only: :show
    node_filters

    def show
      render *@node.template_args
    end

    private

    def root_path?
      request.fullpath == '/'
    end

    def raise_404
      if root_path?
        render template: 'push_type/setup', layout: nil, status: 404
      else
        raise ActiveRecord::RecordNotFound
      end
    end

    def load_node
      @node = PushType::Node.exposed.published.find_by_path permalink_path
      if @node
        instance_variable_set "@#{ @node.type.underscore }", @node.present!(view_context)
      else
        raise_404
      end
    end

  end
end
