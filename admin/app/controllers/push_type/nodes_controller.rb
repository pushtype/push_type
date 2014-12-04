require_dependency "push_type/admin_controller"

module PushType
  class NodesController < AdminController

    before_filter :build_node,  only: [:new, :create]
    before_filter :load_node,   only: [:edit, :update, :destroy, :position]

    def index
      @nodes = node_scope.not_trash.page(params[:page])
    end

    def new
    end

    def create
      if @node.save
        flash[:notice] = "#{ @node.type } successfully created."
        redirect_to redirect_path
      else
        render 'new'
      end
    end

    def edit
    end

    def update
      if @node.update_attributes node_params.merge(updater: push_type_user)
        flash[:notice] = "#{ @node.type } successfully updated."
        redirect_to redirect_path
      else
        render 'edit'
      end
    end

    def destroy
      @node.trash!
      flash[:notice] = "#{ @node.type } trashed."
      redirect_to redirect_path
    end

    def position
      if reorder_node
        head :ok
      else
        render json: @node.errors, status: :unprocessable_entity
      end
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

    def build_node
      @node = node_scope.new type: params[:kind].camelcase, creator: push_type_user, updater: push_type_user
      @node.attributes = @node.attributes.merge(node_params)
    end

    def load_node
      @node = PushType::Node.find params[:id]
    end

    def node_params
      fields = [:title, :slug, :status, :published_at, :published_to] + @node.fields.keys
      params.fetch(@node.type.downcase.to_sym, {}).permit(*fields)
    end

    def redirect_path
      @node.root? ? push_type.nodes_path : push_type.node_nodes_path(@node.parent_id)
    end

    def initial_breadcrumb
      breadcrumbs.add 'Content', push_type.nodes_path
    end

    def reorder_node
      if params[:prev]
        PushType::Node.find(params[:prev]).append_sibling(@node)
      elsif params[:next]
        PushType::Node.find(params[:next]).prepend_sibling(@node)
      end
    end
    
  end
end
