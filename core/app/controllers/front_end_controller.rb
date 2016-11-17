class FrontEndController < ApplicationController

  include PushType::Filterable

  before_action :load_node, :build_presenter, only: :show
  node_filters

  def show
    render *@node.template_args
  end

  def preview
    @node = PushType::Node.exposed.find_by_base64_id params[:id]
    build_presenter
    response.headers['X-Robots-Tag'] = 'none'
    show
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
  end

  def build_presenter
    if @node
      instance_variable_set "@#{ @node.type.underscore }", @node.present!(view_context)
    else
      raise_404
    end
  end

end