Rails.application.routes.draw do
  # get 'relationships/create'
  # get 'relationships/destroy'
  root to: 'tweets#index'
  devise_for :users
  resources :tweets do
    resources :comments, only: :create
    # resources :likes, only: [:like, :unlike,:set_variables]
    collection do
      get 'search'
    end
  end
  post   '/like/:tweet_id' => 'likes#like',   as: 'like'
  delete '/like/:tweet_id' => 'likes#unlike', as: 'unlike'

  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member # 追加
    get :followers, on: :member # 追加
  end
  
end
