Rails.application.routes.draw do
  get "products/index"
  get "products/show"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin::Engine.routes.draw do
  end
  ActiveAdmin.routes(self)

  resources :products, only: [ :index, :show ]
  root to: "products#index"
end
