class <%= class_name %> < PushType::Structure

  # Model the content by adding custom fields to the structure.
<% if attributes.each do |att| -%>
  <%= attribute_as_field(att) %>
<% end.empty? -%>
  # field :body, :text, validates: { presence: true }
<% end -%>

end