PushType::Core::Engine.routes.draw do

  namespace :api, except: [:new, :edit], defaults: { format: :json } do
    resources :nodes
    resources :assets
    resources :users
  end

end
