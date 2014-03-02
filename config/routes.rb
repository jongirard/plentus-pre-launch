PlentusPreLaunch::Application.routes.draw do
  devise_for :users, :path_names => { :sign_up => 'register' }, :controllers => { :registrations => "registrations", :sessions => 'devise/sessions'}, :skip => [:sessions]
  
  #get '/home', to: redirect('/')
  authenticated :user do
      resources :finances, only: [:index]
      root :to => "finances#index", :as => "authenticated_root"
      resources :taxes, only: [:create, :update]
      get "finances/taxes" => "taxes#new", :as => :new_tax
      get "finances/taxes/:id" => "taxes#show", :as => :show_tax
      get "finances/taxes/:id/edit" => "taxes#edit", :as => :edit_tax
      resources :deductions, only: [:create, :update]
      get "finances/deductions" => "deductions#new", :as => :new_deduction
      get "finances/deductions/:id" => "deductions#show", :as => :show_deduction
      get "finances/deductions/:id/edit" => "deductions#edit", :as => :edit_deduction
      resources :debts, only: [:create, :update]
      get "finances/debts/new" => "debts#new", :as => :new_debt
      get "finances/debts/" => "debts#index", :as => :index_debt
      get "finances/debts/:id/" => "debts#show", :as => :show_debt
      get "finances/debts/:id/edit" => "debts#edit", :as => :edit_debt
    end
  root :to => 'high_voltage/pages#show', id: 'home'
  devise_scope :user do
    get "/register", :to => "registrations#new"
    get "login" => "devise/sessions#new", :as => :new_user_session
    post 'login' => 'devise/sessions#create', :as => :user_session
    delete 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
    get "/passwordreset/new" => "devise/passwords#new", :as => :forgot_password
    get "users/billing" => "registrations#billing", :as => :user_billing
  end
  #get 'register', to: 'users#new', as: 'registration'
end
