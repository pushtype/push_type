class <%= class_name %> < PushType::Node

  # By default a node can have children of any other node type.
  # Optionally pass a list of acceptable node types or prevent
  # any descendents by passing false.
  has_child_nodes :all

  # Model the content by adding custom fields to the node.
<% if attributes.each do |att| -%>
  <%= attribute_as_field(att) %>
<% end.empty? -%>
  # field :body, :text, validates: { presence: true }
<% end -%>

end