Rails.application.routes.draw do
  devise_for :users

  namespace :api do
  	resources :lists, only: [:index, :show, :update, :destroy] do
  		resources :tasks, only: [:index, :update, :destroy]
  	end
  end

  root to: 'application#angular'
end
