Rails.application.routes.draw do
  devise_for :users
  
  resources :branches do
    scope module: :branches do
      resources :departments
    end
  end
  
  resources :positions
  
  resource :profile, only: [:show, :edit, :update]
  
  namespace :admin do
    resources :members do
      member do
        patch :suspend
        patch :activate
      end
    end
    
    resources :roles, only: [:index] do
      member do
        patch :update
      end
    end
  end

  namespace :api do
    resources :departments, only: [:index]
    resources :positions, only: [:index]
  end

  if defined?(Importmap)
    mount Importmap::Engine => "/rails/importmap"
  end
  
  root "branches#index"
  
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end