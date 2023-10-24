Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'users#index'

  get '/register', to: 'users#new'
  resources :register, only: [:create], controller: 'users'

  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'


  resources :users, only: [:show, :new, :create] do
    resources :discover, only: [:index]
    resources :movies, only: [:index, :show] do
      resources :viewing_parties, only: [:create, :new, :show]
    end
  end

  get "/users/:user_id/movies/:movie_id/viewing_party/new", to: "viewing_parties#new"

  post "/users/:user_id/movies/:movie_id/viewing_party/new", to: "viewing_parties#create"

end
