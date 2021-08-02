Rails.application.routes.draw do
  resources :users
  post '/login' => 'auth#login'
  get '/auth' => 'auth#persist'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
