Ideaegg::Application.routes.draw do
  match '/auth/:provider/callback' => 'sessions#create', via: [:get, :post]
  delete '/log_out' => 'sessions#destroy', as: :log_out
  get '/login' => 'sessions#new', as: :login
  get '/auth/failure' => 'sessions#failure'
  get '/join' => 'identities#new', as: :join

  resources :users
  resources :ideas, only: [:create, :destroy, :new, :show]

  root 'ideas#index'

end
