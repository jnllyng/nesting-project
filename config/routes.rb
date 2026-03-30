Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :products, only: [ :index, :show ]
  resources :categories, only: [ :index, :show ]
  root to: "products#index"
end
