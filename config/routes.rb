Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: { format: :json } do
    resources :lists, only: [:index, :show, :create, :update, :destroy] do
      resources :tasks, only: [:update, :create, :destroy]
    end
    get '/tasks', to: 'tasks#index'
  end

  root to: 'application#angular'
end
