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
        put    :add_category
        delete :remove_category
        post   :extinction
      end
    end
    resources :categories
    resources :orders, only: [:index, :show, :edit, :update] do
      member do
        post :pay
        post :complete
        post :cancel
      end
    end
    get 'completed', to: 'orders#completed', as: 'completed_orders'
    get 'ordered', to: 'orders#ordered', as: 'ordered_orders'
    get 'cancelled', to: 'orders#cancelled', as: 'cancelled_orders'
    get 'paid', to: 'orders#paid', as: 'paid_orders'
    get 'basket', to: 'orders#basket', as: 'basket_orders'
  end

  root 'pages#home'

  get   'menu',              to: 'items#index'
  match '/signup',           to: 'users#new',         via: 'get'
  match '/login',            to: 'sessions#new',      via: 'get'
  match '/logout',           to: 'sessions#destroy',  via: 'delete'
  match '/admin_dashboard',  to: 'admin#dashboard',   via: 'get'

  match '/admin_dashboard',  to: 'admin#dashboard',  via: 'get'
  match "*a",                to: 'errors#routing_error', via: 'get'
end
