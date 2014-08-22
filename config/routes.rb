Rails.application.routes.draw do
  resources :items
  resources :categories
  resources :users, only: [:new, :create, :show, :index ]
  resources :sessions, only: [:new, :create, :destroy]
  resources :order_items, only: [:update]
  resources :orders, except: [:new] do
    member do
      post :add_item
      post :delete_item
    end
  end

  namespace :admin do
    resources :items do
      member do
        put :add_category
      end
    end
    resources :categories 
    resources :orders, only: [:index, :show, :edit, :update]
  end

  # resources :users, only: [:new, :create, :show, :index]
  # resources :sessions, only: [:new, :create, :destroy]
  # resources :orders, except: [:new]

  root 'pages#home'

  get   'menu',              to: 'items#index'
  match '/signup',           to: 'users#new',         via: 'get'
  match '/login',            to: 'sessions#new',      via: 'get'
  match '/logout',           to: 'sessions#destroy',  via: 'delete'
  match '/admin_dashboard',  to: 'admin#dashboard',   via: 'get'
end
