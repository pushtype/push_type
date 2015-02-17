class FrontEndController < ApplicationController

  before_action :before_load, :load_node, :before_node, only: :node
  after_action :after_node, only: :node

  def node
    render *@node.template_args
  end

  private

  def load_node
    @node = PushType::Node.published.find_by_path permalink_path
    raise ActiveRecord::RecordNotFound unless @node
    instance_variable_set "@#{ @node.type.underscore }", @node
  end

  def before_load
    node_hook(:before_node_load)
  end

  def node_types_array
    ['node', @node.type.underscore]
  end

  def before_node
    node_types_array.each { |kind| node_hook(:"before_#{ kind }_action") }
  end

  def after_node
    node_types_array.each { |kind| node_hook(:"after_#{ kind }_action") }
  end
  
end
