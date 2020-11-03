Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: %i[index show] do
    resources :friendship_invitations, only: %i[create update index destroy]
  end
  resources :posts, only: %i[index create] do
    resources :comments, only: %i[create]
    resources :likes, only: %i[create destroy]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
