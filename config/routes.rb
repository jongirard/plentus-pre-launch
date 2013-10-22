PlentusPreLaunch::Application.routes.draw do
  resources :visitors, only: [:new, :create]
  resources :users, only: [:new, :create]
  root to: 'visitors#new'
  match '*path' => redirect('/'), via: :get
end
