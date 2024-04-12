Rails.application.routes.draw do
  # Define routes for about and contact pages
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'

  # Route the root URL to the index action of PagesController
  root 'pages#index'
  get 'products/:id', to: 'pages#show_product', as: 'product'

  get 'cart', to: 'pages#cart'
  post 'add_to_cart', to: 'pages#add_to_cart'
  post 'update_cart', to: 'pages#update_cart'
  post 'remove_from_cart', to: 'pages#remove_from_cart'

  # Define Devise routes for admin users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


  devise_for :users



  devise_for :users


  resources :orders, only: [:new, :create] do
    member do
      get 'confirm'
      post 'confirm'
      get 'thank_you'
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
