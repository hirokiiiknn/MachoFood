Rails.application.routes.draw do
  devise_for :users
  root to: 'tweets#index'
  resources :tweets do
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  resources :users, only: [:edit,:update, :show]

  post   '/like/:tweet_id' => 'likes#like',   as: 'like'
  delete '/like/:tweet_id' => 'likes#unlike', as: 'unlike'

end
