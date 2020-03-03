Rails.application.routes.draw do
  # Resources
  resources :lessons
  resources :users

  # Home and session paths
  root 'static_pages#home'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # Lesson paths
  get '/compose', to: 'lessons#new'
  
end
