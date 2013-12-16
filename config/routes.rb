PlentusPreLaunch::Application.routes.draw do
  resources :users, only: [:new, :create]
  get '/home', to: redirect('/')
  root :to => 'high_voltage/pages#show', id: 'home'
  get 'register', to: 'users#new', as: 'registration'
end
