class <%= class_name %> < PushType::Node

  # Control child nodes
  # has_child_nodes :all

  # Set custom fields
  # field :body, :text, validates: { presence: true }
<% attributes.each do |att| -%>
  <%= attribute_as_field(att) %>
<% end -%>  

end