Rails.application.routes.draw do
  get 'users/new'

  root 'pages#home'

  resources :items
  resources :categories
  get 'menu', to: 'items#index'

  resources :sessions, only: [:new, :create, :destroy]
  resources :orders, except: [:new]
end
