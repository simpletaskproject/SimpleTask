Rails.application.routes.draw do
  devise_for :users

  namespace :api do
  	resources :lists, only: [:index, :show, :create, :update, :destroy] do
  		resources :tasks, only: [:index, :update, :create, :destroy]
  	end
  end

  root to: 'application#angular'
end
