module PushType
  class NodesFrontEndController < FrontEndController

    before_action :load_node, only: :show
    hooks_for :node

    def show
      render *@node.template_args
    end

    private

    def load_node
      @node = PushType::Node.published.find_by_path permalink_path
      if @node
        instance_variable_set "@#{ @node.type.underscore }", @node.present!(view_context)
      else
        raise_404
      end
    end

  end
end