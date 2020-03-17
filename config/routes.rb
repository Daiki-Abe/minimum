Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
}

  root "buys#index"
  resources :buys
  resources :users, only: [:show]
end
