Rails.application.routes.draw do
  get 'users/show'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
}

  root "buys#index"
  resources :buys
end
