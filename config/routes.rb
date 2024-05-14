Rails.application.routes.draw do
  root 'sessions#new' 

  get    'signup', to: 'users#new'
  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Resourceful routes
  resources :workouts, only: [:index, :show, :new, :create]
  resources :programs, only: [:index, :show, :new, :create]
  resources :exercises, only: [:index, :show]
  resources :user_exercises, only: [:new, :create]
  resources :users, only: [:show, :create, :edit, :update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
