Rails.application.routes.draw do
  devise_for :users

  # Nest expenses under budgets to show their association
  resources :budgets do
    resources :expenses, only: [:index, :new, :create, :edit, :update, :destroy, :show]
  end

  resources :expense_categories, only: [:index, :new, :create, :destroy]
  resources :reports, only: [:index, :show, :new, :create]
  resources :notifications, only: [:index, :update]

  # Root path
  root 'budgets#index'

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check
end
