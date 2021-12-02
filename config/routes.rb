Rails.application.routes.draw do
  resources :users
  root 'users#index'
    
    resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end
end
