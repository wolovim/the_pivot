Rails.application.routes.draw do
  root 'pages#home'

  resources :items
  resources :categories
  get 'menu', to: 'items#index'
end