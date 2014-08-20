Rails.application.routes.draw do
  resources :items
  resources :categories
  resources :users, only: [:new, :create, :show, :index ]
  resources :sessions, only: [:new, :create, :destroy]
  resources :orders, except: [:new]

  root 'pages#home'

  get 'menu',       to: 'items#index'
  match '/signup',  to: 'users#new',         via: 'get'
  match '/login',  to: 'sessions#new',      via: 'get'
  match '/logout', to: 'sessions#destroy',  via: 'delete'

end
