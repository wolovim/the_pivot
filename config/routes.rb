Rails.application.routes.draw do
  get 'users/new'

  root 'pages#home'

  resources :items
  resources :categories
  get 'menu', to: 'items#index'

  resources :order_items, only: [:update]

  resources :orders, except: [:new] do
    member do
      post :add_item
      post :delete_item
    end
  end

  match '/admin_dashboard', to: 'admin#dashboard', via: :get

  namespace :admin do
    resources :items
    resources :categories
    resources :orders, only: [:index, :show, :edit, :update]
  end

  resources :users, only: [:new, :create, :show, :index]
  resources :sessions, only: [:new, :create, :destroy]
  resources :orders, except: [:new]

end
