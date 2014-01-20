PlentusPreLaunch::Application.routes.draw do
  devise_for :users, :path_names => { :sign_up => 'register' }, :controllers => { :registrations => "registrations" }
  resources :users, only: [:new, :create]
  resources :finances, only: [:index]
  get '/home', to: redirect('/')
  authenticated :user do
      root :to => "finances#index", :as => "authenticated_root"
    end
  root :to => 'high_voltage/pages#show', id: 'home'
  devise_scope :user do
    get "/register", :to => "registrations#new"
    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
    get "/passwordreset/new" => "devise/passwords#new"
  end
  #get 'register', to: 'users#new', as: 'registration'
end
