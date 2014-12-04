PushType::Engine.routes.draw do

  resources :nodes, except: :show do
    resources :nodes, only: [:index, :new, :create]
    post 'position', on: :member
  end

  resources :assets, except: :show, path: 'media' do
    post 'upload', on: :collection
  end

  resources :users, except: :show

  root to: redirect('nodes')
    
end
