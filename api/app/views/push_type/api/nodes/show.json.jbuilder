json.node do
  json.partial! 'node', node: @node

  @node.fields.each do |key, field|
    json.set! key, field.value
  end
end

json.meta do
  json.links do
    json.self push_type.api_node_url(@node)
    json.permalink main_app.node_url(@node.permalink)
  end

  if params[:action] == 'show'
    json.fields @node.fields do |key, field|
      json.name field.name
      json.kind field.kind
    end
    json.child_nodes @node.child_nodes
  end
end
