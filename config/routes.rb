Rails.application.routes.draw do
  resources :companies, only: [:new, :create, :show, :index]
  resources :locations, only: [:new, :create, :show, :index]

  root 'index#index'
end
