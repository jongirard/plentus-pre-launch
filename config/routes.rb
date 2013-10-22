PlentusPreLaunch::Application.routes.draw do
  resources :visitors, only: [:new, :create]
  resources :users, only: [:new, :create]
  root :to => 'high_voltage/pages#show', id: 'home'
  match '*path' => redirect('/'), via: :get
end
