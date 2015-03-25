PushType::Core::Engine.routes.draw do

  resources :nodes, except: :show do
    collection do
      get 'trash'
      delete 'trash' => 'nodes#empty'
    end
    member do
      post 'position'
      put 'restore'
    end
    resources :nodes, only: [:index, :new, :create]
  end

  resources :taxonomies, only: [:index, :show] do
    resources :items, only: [:create, :update, :destroy], controller: 'taxonomy_items' do
      post 'position', on: :member
    end
  end

  resources :assets, except: :show, path: 'media' do
    collection do
      post 'upload'
      get 'trash'
      delete 'trash' => 'assets#empty'
    end
    member do
      put 'restore'
    end
  end

  resources :users, except: :show

  get 'info' => 'admin#info', as: 'info'

  root to: redirect('nodes')
    
end
