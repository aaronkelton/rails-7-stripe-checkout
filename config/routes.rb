Rails.application.routes.draw do
  root "products#index"
  resources :products
  get '/success', to: 'products#success'
  get '/cancel', to: 'products#cancel'

  resources :orders
  resources :webhooks, only: [:create]

  post 'create_checkout_session', to: 'stripe#create_checkout_session'

  post 'filter_products', to: 'products#filter_products'
end
