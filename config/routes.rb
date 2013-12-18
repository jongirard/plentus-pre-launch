PlentusPreLaunch::Application.routes.draw do
  devise_for :users, :path_names => { :sign_up => 'register' }
  resources :users, only: [:new, :create]
  resources :finances, only: [:index]
  get '/home', to: redirect('/')
  root :to => 'high_voltage/pages#show', id: 'home'
  devise_scope :user do
    get "/register", :to => "devise/registrations#new"
    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
  end
  #get 'register', to: 'users#new', as: 'registration'
end
