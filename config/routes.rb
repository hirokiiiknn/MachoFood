Rails.application.routes.draw do
  devise_for :users
  root to: 'tweets#index'
  resources :tweets do
    resources :comments, only: :create
    # resources :likes, only: [:like, :unlike,:set_variables]
    collection do
      get 'search'
    end
  end
  resources :users, only: [:edit,:update, :show]

  post   '/like/:tweet_id' => 'likes#like',   as: 'like'
  delete '/like/:tweet_id' => 'likes#unlike', as: 'unlike'

end
