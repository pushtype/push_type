PushType::Core::Engine.routes.draw do
  devise_for :users, class_name: "PushType::User", path: ''
  devise_scope :user do
    patch 'confirmation' => 'confirmations#update', as: :user_confirm
  end
  resources :users, only: [] do
    patch :invite, on: :member
  end
end
