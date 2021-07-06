Rails.application.routes.draw do

  root 'pages#home'

  get '/about', to: 'pages#about'

  get 'user/register', to: 'registers#new'
  post 'user/register', to: 'registers#create'

  get 'user/login', to: 'sessions#new'
  post 'user/login', to: 'sessions#create'
  delete 'user/logout', to: 'sessions#destroy'
  # resources :sessions
  resources :profiles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :users
      post '/auth/login', to: 'authentication#login'
    end
  end

end
