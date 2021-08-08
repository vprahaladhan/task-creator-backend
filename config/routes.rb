Rails.application.routes.draw do
  # resources :users
  # resources :tasks
  post '/login'   => 'auth#login'
  post '/logout'  => 'auth#logout'

  get '/users'        => 'users#get_users'
  get '/users/:id'    => 'users#get_user'
  put '/users/:id'    => 'users#edit_user'
  post '/users'       => 'users#add_user'
  delete 'users/:id'  => 'users#destroy'

  get '/tasks'                       => 'tasks#get_tasks'
  get '/users/:user_id/tasks'        => 'tasks#get_user_tasks'
  post '/users/:user_id/tasks'       => 'tasks#add_user_task'
  put '/users/:user_id/tasks/:id'    => 'tasks#edit_user_task'
  delete '/users/:user_id/tasks/:id' => 'tasks#delete_user_task'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end