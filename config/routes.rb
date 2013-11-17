PlentusPreLaunch::Application.routes.draw do
  resources :users, only: [:new, :create]
  resources :posts, path: 'blog', as: 'blog'
  root :to => 'high_voltage/pages#show', id: 'home'
  get 'register', to: 'users#new', as: 'registration'
  match '*path' => redirect('/'), via: :get
end
