Rails.application.routes.draw do

  resources :items do
    resources :item_images, as: :images, only: [:new, :create]
    resources :addresses, as: :addresses, only: [:new, :create, :edit, :update]
  end

  resources :addresses

  resources :categories,  only: [:index, :show]

  resources :users,       only: [:new, :create, :show, :index, :edit, :update] do
    member do
      get :items
      get :dashboard
      get :avatar
      get :orders
    end
  end

  resources :sessions,    only: [:new, :create, :destroy]
  resources :order_items, only: [:update]
  resources :orders,      except: [:new] do
    member do
      post :add_item
      post :delete_item
    end
  end

  resources :listing_requests, only: [:index] do
    resources :confirmations
    resources :denials
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
    resources :users, only: [:index, :destroy]
    resources :orders, only: [:index, :show, :edit, :update]
    put '/orders/:id/run_event', to: 'orders#run_event', as: :order_event
  end

  root   'pages#home'
  get    'menu',                   to: 'items#index'
  match  '/about_us',              to: 'pages#about_us',           via: 'get'
  match  '/signup',                to: 'users#new',                via: 'get'
  match  '/login',                 to: 'sessions#new',             via: 'get'
  match  '/logout',                to: 'sessions#destroy',         via: 'delete'
  get    '/paid',                  to: 'orders#paid'
  get    '/checkout',              to: 'orders#checkout'
  get    '/confirm',               to: 'orders#confirm'
  get    '/requested',             to: 'orders#requested'
  get    '/completed/:id',         to: 'orders#completed',         as: "completed"
  match  '/admin_dashboard',       to: 'admin#dashboard',          via: 'get'
  get    '/code',                  to: 'pages#code'
  delete '/admin/:id/orders',      to: 'admin/orders#delete_item', as: "admin_delete_order_item"
  put    '/admin/order_items/:id', to: 'admin/order_items#update'
  match  "*a",                     to: 'errors#routing_error',     via: 'get'
end
