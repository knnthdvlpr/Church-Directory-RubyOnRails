# config/routes.rb
Rails.application.routes.draw do
  devise_for :users
  
  resources :branches
  resources :departments
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

  root "branches#index"
end