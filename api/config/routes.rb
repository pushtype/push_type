PushType::Api::Engine.routes.draw do

  scope module: 'api', except: [:new, :edit], defaults: { format: :json } do

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

    resources :assets, path: 'media' do
      collection do
        get 'trash'
        delete 'trash' => 'assets#empty'
      end
      member do
        put 'restore'
      end
    end

    resources :users
    
  end

end
