Rails.application.routes.draw do
  devise_for :users
  root "buys#index"
  resources :buys
end
