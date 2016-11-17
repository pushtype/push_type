class FrontEndController < ApplicationController

  include PushType::Filterable

  before_action :load_node,         only: :show
  before_action :load_preview_node, only: :preview
  before_action :build_presenter
  node_filters

  def show
    render *@node.template_args
  end

  def preview
    response.headers['X-Robots-Tag'] = 'none'
    show
  end

  private  

  def load_node
    @node = PushType::Node.exposed.published.find_by_path permalink_path
  end

  def load_preview_node
    @node = PushType::Node.exposed.find_by_base64_id params[:id]
  end

  def build_presenter
    if @node
      instance_variable_set "@#{ @node.type.underscore }", @node.present!(view_context)
    else
      raise_404
    end
  end

  def root_path?
    request.fullpath == main_app.home_node_path
  end

  def raise_404
    if root_path?
      render template: 'push_type/setup', layout: nil, status: 404
    else
      raise ActiveRecord::RecordNotFound
    end
  end

end