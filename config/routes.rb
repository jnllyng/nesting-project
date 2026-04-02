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
  get "/cart", to: "carts#show", as: "cart"
  post "/cart/add/:product_id", to: "carts#add", as: "add_to_cart"
  delete "/cart/remove/:product_id", to: "carts#remove", as: "remove_from_cart"
  patch "/cart/update/:product_id", to: "carts#update", as: "update_cart"
  get "/checkout", to: "checkouts#new", as: "checkout"
  post "/checkout", to: "checkouts#create"
  get "/checkout/confirm", to: "checkouts#confirm", as: "confirm_checkout"
  post "/checkout/complete", to: "checkouts#complete", as: "complete_checkout"
  root to: "products#index"
end
