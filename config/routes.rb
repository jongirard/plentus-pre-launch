PlentusPreLaunch::Application.routes.draw do
  devise_for :users, :path_names => { :sign_up => 'register' }, :controllers => { :registrations => "registrations", :sessions => 'devise/sessions'}, :skip => [:sessions]
  resources :users, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end
  resources :finances, only: [:index]
  resources :taxes, only: [:create, :edit, :update]
  #get '/home', to: redirect('/')
  authenticated :user do
      root :to => "finances#index", :as => "authenticated_root"
      get "finances/taxes/new" => "taxes#new", :as => :new_tax
      get "finances/taxes/" => "taxes#index", :as => :index_tax
    end
  root :to => 'high_voltage/pages#show', id: 'home'
  devise_scope :user do
    get "/register", :to => "registrations#new"
    get "login" => "devise/sessions#new", :as => :new_user_session
    post 'login' => 'devise/sessions#create', :as => :user_session
    delete 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
    get "/passwordreset/new" => "devise/passwords#new"
  end
  #get 'register', to: 'users#new', as: 'registration'
end
