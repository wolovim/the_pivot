Rails.application.routes.draw do
  root 'pages#home'

  resources :items
  get 'menu', to: 'items#index'
end