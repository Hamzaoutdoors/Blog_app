Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  root 'users#index'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy]
  end
  
  resources :posts, only: [:new, :create, :destroy, :edit, :update] do
    resources :comments, only: [:create]
    resources :likes, only: [:create]
  end

  resources :comments, only: [:destroy]
  resources :likes, only: [:destroy]

  namespace :api, defaults: { format: :json } do
    resources :posts, only: [:index] do
      resources :comments, only: [:create, :index]
    end
  end
end



