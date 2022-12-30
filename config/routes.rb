Rails.application.routes.draw do
  resources :users
  resources :orders
  resources :sessions
end
