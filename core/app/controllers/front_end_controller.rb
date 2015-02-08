class FrontEndController < ApplicationController

  before_filter :load_node, only: :node

  def node
    render *@node.template_args
  end

  private

  def load_node
    @node = PushType::Node.published.find_by_path permalink_parts
    raise ActiveRecord::RecordNotFound unless @node
    instance_variable_set "@#{ @node.type.underscore }", @node
  end

  def permalink_parts
    params[:permalink].split('/')
  end
  
end
