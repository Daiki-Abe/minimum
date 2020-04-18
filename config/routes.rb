Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root "dumps#index"

  resources :dumps do
    collection do
      get 'search'
    end
    resources :dump_comments, only: [:create]
    resources :likes, only: [:create, :destroy]
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
      get 'mydump'
      get 'mybuy'
      get 'dumpsearch'
      get 'search'
    end
  end
end
