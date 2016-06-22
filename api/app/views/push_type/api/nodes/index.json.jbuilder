json.nodes @nodes do |node|
  json.partial! 'node', node: node
end

json.meta do
  json.partial! 'push_type/api/shared/pagination', collection: @nodes

  if params[:action] == 'index'
    json.child_nodes @parent ? @parent.child_nodes : PushType.root_nodes
  end
end
