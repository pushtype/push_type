PushType::Admin::Engine.routes.draw do
  get '/(*path)' => 'admin#app'
  root to: 'admin#app'
end
