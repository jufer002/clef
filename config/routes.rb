Rails.application.routes.draw do
  # Resources
  resources :section_contents
  resources :course_contents
  resources :lessons
  resources :users

  resources :sections do
    resources :lessons
  end
  resources :courses do
    resources :sections
  end

  # Home and session paths
  root 'static_pages#home'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # Lesson paths
  get '/compose_lesson', to: 'lessons#new'
  post '/lessons/:id', to: 'lessons#post_comment'

  # Course paths
  get '/compose_course', to: 'courses#new'

  # Search paths
  get '/search', to: 'lessons#search'
end
