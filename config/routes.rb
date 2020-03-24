Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
}

  root "buys#index"
  resources :buys do
    collection do
      get 'search'
    end
  end
  resources :users, only: [:show]
end
