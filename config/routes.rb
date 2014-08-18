Rails.application.routes.draw do
  get 'users/new'

  root 'pages#home'

  resources :items
  resources :categories
  get 'menu', to: 'items#index'

  resources :orders, except: [:new]
end
