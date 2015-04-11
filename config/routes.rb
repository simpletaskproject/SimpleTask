Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  namespace :api, defaults: { format: :json } do
    resources :lists, only: [:index, :show, :create, :update, :destroy] do
      resources :tasks, only: [:update, :create, :destroy] do
        member do
          put 'complete'
        end
      end
    end
    get '/tasks/:scope', to: 'tasks#index'
  end

  root to: 'application#angular'
end
