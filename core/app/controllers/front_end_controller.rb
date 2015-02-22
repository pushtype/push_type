class FrontEndController < ApplicationController

  before_action :before_load, :load_node, :before_node, only: :node
  after_action :after_node, only: :node

  def node
    render *@node.template_args
  end

  private

  def load_node
    @node = PushType::Node.published.find_by_path permalink_path
    if @node
      instance_variable_set "@#{ @node.type.underscore }", @node
    else
      raise_404
    end
  end

  def root_path?
    request.fullpath == '/'
  end

  def raise_404
    if root_path?
      render template: 'push_type/setup', layout: false, status: 404
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def before_load
    unless before_load_filters.blank?
      before_load_filters.each { |f| run_node_hook(*f) }
    end
  end

  def before_node
    unless before_node_filters.blank?
      before_node_filters.each { |f| run_node_hook(*f) }
    end
  end

  def after_node
    unless after_node_filters.blank?
      after_node_filters.each { |f| run_node_hook(*f) }
    end
  end
  
end
