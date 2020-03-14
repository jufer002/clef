Rails.application.routes.draw do
  resources :courses
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
  post '/lessons/:id', to: 'lessons#post_comment'

  # Search paths
  get '/search', to: 'lessons#search'
end
