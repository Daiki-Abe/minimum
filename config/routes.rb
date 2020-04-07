Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
}

  root "buys#index"

  resources :dumps do
    collection do
      get 'search'
    end
  end

  resources :buys do
    collection do
      get 'search'
    end
    resources :comments, only: [:create]
    resources :hates, only: [:create, :destroy]
  end

  resources :users, only: [:show] do
    member do
      get 'mybuy'
      get 'search'
    end
  end
end
