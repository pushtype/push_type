require_dependency "push_type/api_controller"

module PushType
  class Api::NodesController < ApiController

    before_action :load_node, only: [:show, :update, :destroy]

    def index
      @nodes = node_scope.not_trash.page(params[:page]).per(30)
    end

    def show
    end

    def create
    end

    def destroy
    end

    private

    def node_scope
      @node_scope ||= if params[:node_id]
        @parent = PushType::Node.find params[:node_id]
        @parent.children
      else
        PushType::Node.roots
      end
    end

    def load_node
      @node = PushType::Node.find params[:id]
    end

  end
end
