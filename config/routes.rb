Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  root "ideas#index"
  
  resources :users, only: [:new, :create]

  resources :sessions, only: [:create]
  get 'session/new', to: 'sessions#new'
  delete '/sign_out', to: 'sessions#destroy'

  resources :ideas do
    resources :reviews, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end
end
