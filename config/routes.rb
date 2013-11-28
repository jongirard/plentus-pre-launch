PlentusPreLaunch::Application.routes.draw do
  resources :users, only: [:new, :create]
  get 'blog/:guid', to: 'posts#show', as: 'blog'
  resources :posts, path: 'blog', as: 'blog'
  get '/home', to: redirect('/')
  root :to => 'high_voltage/pages#show', id: 'home'
  get 'register', to: 'users#new', as: 'registration'
end
