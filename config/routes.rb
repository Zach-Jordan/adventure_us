Rails.application.routes.draw do
  # Define routes for about and contact pages
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'

  # Route the root URL to the index action of PagesController
  root 'pages#index'

  # Define Devise routes for admin users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
