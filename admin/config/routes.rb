PushType::Core::Engine.routes.draw do

  resources :nodes, except: :show do
    resources :nodes, only: [:index, :new, :create]
    collection do
      get 'trashed'
      delete 'empty'
    end
    member do
      post 'position'
      put 'restore'
    end
  end

  resources :assets, except: :show, path: 'media' do
    post 'upload', on: :collection
  end

  resources :users, except: :show

  get 'info' => 'admin#info', as: 'info'

  root to: redirect('nodes')
    
end
