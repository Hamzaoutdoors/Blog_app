Rails.application.routes.draw do
  devise_for :users
  root 'users#index'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy]
  end

  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end

  get 'api/posts', to: "apiposts#index"

  # scope '/api/:post_id/' do
  #   resources :comments, only: [:index, :create]
  # end

end
