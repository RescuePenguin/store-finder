Rails.application.routes.draw do
  require 'sidekiq/web'

  resources :companies, only: [:new, :create, :show, :index]
  resources :locations, only: [:new, :create]

  root 'companies#new'
  mount Sidekiq::Web, at: '/sidekiq'
end
