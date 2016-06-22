PushType::Core::Engine.routes.draw do

  namespace :api, except: [:new, :edit], defaults: { format: :json } do
    resources :nodes do
      collection do
        get 'trash'
        delete 'trash' => 'nodes#empty'
      end
      member do
        post 'position'
        put 'restore'
      end
      resources :nodes, only: [:index]
    end
    resources :assets
    resources :users
  end

end
