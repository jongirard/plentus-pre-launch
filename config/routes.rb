PlentusPreLaunch::Application.routes.draw do
  devise_for :users
  resources :users, only: [:new, :create]
  get '/home', to: redirect('/')
  root :to => 'high_voltage/pages#show', id: 'home'
  devise_scope :user do
    get "/sign_up" => "devise/registrations#new", as: 'registration'
    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
  end
  #get 'register', to: 'users#new', as: 'registration'
end
