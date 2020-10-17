Rails.application.routes.draw do
  root to: 'tweets#index'
  devise_for :users,
  controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :tweets do
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  post   '/like/:tweet_id' => 'likes#like',   as: 'like'
  delete '/like/:tweet_id' => 'likes#unlike', as: 'unlike'



  resources :users do
    member do
        get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  
end
