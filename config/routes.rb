Rails.application.routes.draw do
  root "products#index"
  resources :products
  post 'filter_products', to: 'products#filter_products'
end
