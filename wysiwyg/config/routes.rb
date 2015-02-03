PushType::Core::Engine.routes.draw do
  resources :wysiwyg_media, only: [:index, :create]
end
