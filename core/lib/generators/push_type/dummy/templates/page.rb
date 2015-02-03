class Page < PushType::Node

  field :description
  field :body, :text, validates: { presence: true }

end