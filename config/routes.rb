Rails.application.routes.draw do
  root 'users#index'
    
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :create]
  end

  resources :posts do
    resources :comments, only: [:create]
    resources :likes, only: [:create]
  end
end
