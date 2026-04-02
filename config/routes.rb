Rails.application.routes.draw do
  get "cart/index"
  get "pages/about"
  get "pages/contact"
  get "/about", to: "pages#about"
  get "/contact", to: "pages#contact"
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :products, only: [ :index, :show ]
  resources :categories, only: [ :index, :show ]
  resource :cart, only: [:show]
post '/cart/add/:product_id', to: 'carts#add', as: 'add_to_cart'
delete '/cart/remove/:product_id', to: 'carts#remove', as: 'remove_from_cart'
patch '/cart/update/:product_id', to: 'carts#update', as: 'update_cart'
  root to: "products#index"
end
