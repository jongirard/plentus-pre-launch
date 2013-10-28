PlentusPreLaunch::Application.routes.draw do
  resources :users, only: [:new, :create]
  root :to => 'high_voltage/pages#show', id: 'home'
  get 'sign_up', to: 'users#new', as: 'sign_up'
  match '*path' => redirect('/'), via: :get
end
