PushType::Admin::Engine.routes.draw do

  devise_for :users, class_name: "PushType::User", path: '/'
  devise_scope :user do
    patch 'confirmation' => 'confirmations#update', as: :user_confirm
  end

  scope module: 'admin' do
    resources :users, only: [] do
      patch :invite, on: :member
    end
    resource :profile, only: [:edit, :update]
  end
  
end