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

  match '/admin_dashboard', to: 'admin#dashboard', via: :get

  namespace :admin do
    resources :items
    resources :categories
    resources :orders, only: [:index, :show, :edit, :update]
  end
end
