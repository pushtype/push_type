class Page < PushType::Node

  field :description
  field :body, :rich_text, validates: { presence: true }

end