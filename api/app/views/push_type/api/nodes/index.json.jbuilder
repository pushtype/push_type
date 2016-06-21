json.nodes @nodes do |node|
  json.partial! 'node', node: node
end

json.partial! 'push_type/api/shared/pagination', collection: @nodes
