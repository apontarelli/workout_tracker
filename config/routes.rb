Rails.application.routes.draw do
  root 'dashboard#home'

  get    'signup', to: 'users#new'
  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Resourceful routes
  resources :workouts
  resources :programs do
    resources :template_workouts, only: [:create, :edit, :update, :destroy]
  end

  resources :exercises, only: [:index, :show] do
    collection do
      get 'new_user_exercise', to: 'exercises#new_user_exercise'
      post 'create_user_exercise', to: 'exercises#create_user_exercise'
    end
  end
  
  resources :user_exercises, only: [] do
    member do
      get 'edit', to: 'exercises#edit_user_exercise'
      patch 'update', to: 'exercises#update_user_exercise'
      delete '', to: 'exercises#destroy_user_exercise', as: 'destroy'
    end
  end

  resources :users, only: [:show, :create, :edit, :update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
