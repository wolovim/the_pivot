Rails.application.routes.draw do
  root 'pages#home'

  resources :items
  resources :categories
  get 'menu', to: 'items#index'

  resources :orders, except: [:new] do
    member do
      post :add_item
    end
  end
end
