Ideaegg::Application.routes.draw do
  get "notifications/index"
  match '/auth/:provider/callback' => 'sessions#create', via: [:get, :post]
  delete '/log_out' => 'sessions#destroy', as: :log_out
  get '/login' => 'sessions#new', as: :login
  get '/auth/failure' => 'sessions#failure'
  get '/join' => 'identities#new', as: :join

  concern :commentable do
    resources :comments, only: [:create]
  end
  
  resources :users
  resources :ideas, concerns: [:commentable] do
    member do
      post 'like' => 'likes#create', as: :like
      delete 'like' => 'likes#destroy', as: :unlike
      post 'collect' => 'collections#create', as: :collect
      delete 'collect' => 'collections#destroy', as: :not_collect
    end
  end
  
  resources :posts
  
  resources :notifications, only: [:index] do
    collection do
      post :mark
    end
  end

  get '/uploads/uptoken' => 'uploads#uptoken'

  root 'ideas#index'

end
