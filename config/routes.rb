Ideaegg::Application.routes.draw do
  get '/auth/:provider/callback' => 'sessions#create'
  delete '/log_out' => 'sessions#destroy', as: :log_out
  get '/auth/failure' => 'sessions#failure'

  resources :users
  resources :ideas, only: [:create, :destroy]

  root 'ideas#index'

end
