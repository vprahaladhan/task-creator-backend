Rails.application.routes.draw do
  resources :users
  resources :tasks
  post '/login' => 'auth#login'
  get '/get_current_user' => 'auth#get_user'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
