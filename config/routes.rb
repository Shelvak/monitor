Rails.application.routes.draw do
  resources :tags
  # Sessions
  get 'login', to: 'sessions#new', as: 'login'
  post 'sessions', to: 'sessions#create', as: 'sessions'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  # Profiles
  get 'profile', to: 'profiles#edit', as: 'profile'
  patch 'profile', to: 'profiles#update'

  # Resources
  resources :databases
  resources :ldaps
  resources :scripts
  resources :servers
  resources :tags, only: [:index]
  resources :users
  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :schedules do
    resources :runs, shallow: true, only: [:index, :show, :destroy]
  end

  root 'sessions#new'
end
