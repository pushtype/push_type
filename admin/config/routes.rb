PushType::Core::Engine.routes.draw do

  resources :nodes, except: :show do
    collection do
      get 'trashed'
      delete 'empty'
    end
    member do
      post 'position'
      put 'restore'
    end
    resources :nodes, only: [:index, :new, :create]
  end

  resources :assets, except: :show, path: 'media' do
    collection do
      post 'upload'
      get 'trashed'
      delete 'empty'
    end
    member do
      put 'restore'
    end
  end

  resources :users, except: :show

  get 'info' => 'admin#info', as: 'info'

  root to: redirect('nodes')
    
end
