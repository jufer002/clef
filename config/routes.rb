Rails.application.routes.draw do
  get 'static_pages/home'
  resources :lessons
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'static_pages#home'
  get '/signup', to: 'users#new'
end
