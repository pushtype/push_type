require_dependency "push_type/api_controller"

module PushType
  class Api::NodesController < ApiController

    before_action :build_node,  only: [:create]
    before_action :load_node, only: [:show, :update, :destroy, :restore, :position]

    def index
      @nodes = node_scope.not_trash.page(params[:page]).per(30)
    end

    def trash
      @nodes = PushType::Node.all.trashed.page(params[:page]).per(30).reorder(deleted_at: :desc)
      render :index
    end

    def show
    end

    def create
      if @node.save
        render :show, status: :created
      else
        render json: { errors: @node.errors }, status: :unprocessable_entity
      end
    end

    def update
      if @node.update_attributes node_params_with_fields.merge(updater: push_type_user)
        render :show
      else
        render json: { errors: @node.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      if @node.trashed?
        @node.destroy
        head :no_content
      else
        @node.trash!
        render :show
      end
    end

    def position
      if reorder_node
        head :no_content
      else
        render json: { errors: @node.errors }, status: :unprocessable_entity
      end
    end

    def restore
      @node.restore!
      render :show
    end

    def empty
      PushType::Node.trashed.destroy_all
      head :no_content
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
      @node = node_scope.new type: node_type, creator: push_type_user, updater: push_type_user
      @node.attributes = @node.attributes.merge(node_params_with_fields.to_h)
    end

    def load_node
      @node = PushType::Node.find params[:id]
    end

    def node_params
      @node_params ||= params.fetch(:node, {}).permit(:type, :parent_id, :title, :slug, :status, :published_at, :published_to)
    end

    def node_type
      node_params[:type]
    end

    def node_params_with_fields
      node_params.tap do |whitelist|
        @node.fields.keys.each { |k| whitelist[k] = params[:node][k] if params[:node][k].present? }
      end
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
