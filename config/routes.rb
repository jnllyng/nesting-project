Rails.application.routes.draw do
  get "pages/about"
  get "pages/contact"
  get "/about", to: "pages#about"
  get "/contact", to: "pages#contact"
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :products, only: [ :index, :show ]
  resources :categories, only: [ :index, :show ]
  root to: "products#index"
end
