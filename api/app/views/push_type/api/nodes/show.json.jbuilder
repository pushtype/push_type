json.node do
  json.partial! 'node', node: @node

  @node.fields.each do |key, field|
    json.set! key, field.value
  end
end

json.fields @node.fields do |key, field|
  json.name field.name
  json.kind field.kind
end