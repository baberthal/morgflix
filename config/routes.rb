require 'sidekiq/web'

Rails.application.routes.draw do
  get 'secret/index'

  devise_for :users

  authenticated :user do
    root 'secret#index', as: :authenticated_root
    resources :series
    get 'series_search' => 'secret#search', as: :series_search
  end

  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  mount Sidekiq::Web => '/sidekiq'
end
